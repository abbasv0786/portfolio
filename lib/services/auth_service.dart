import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'firestore_service.dart';

class AuthService extends GetxService {
  static AuthService get to => Get.find<AuthService>();

  // Must match the admin email in firestore.rules
  static const String adminEmail = 'abbasv0786@gmail.com';

  final FirebaseAuth _auth = FirebaseAuth.instance;

  final Rx<User?> currentUser = Rx<User?>(null);
  final RxBool isLoading = false.obs;
  final RxString authError = ''.obs;

  @override
  void onInit() {
    super.onInit();
    try {
      _auth.authStateChanges().listen(_onAuthChanged);
    } catch (e) {
      debugPrint('Auth state listener init note: $e');
    }
  }

  static bool _isAdmin(User? user) =>
      user?.email?.toLowerCase() == adminEmail.toLowerCase();

  void _onAuthChanged(User? user) {
    currentUser.value = _isAdmin(user) ? user : null;
    if (!Get.isRegistered<FirestoreService>()) return;
    if (currentUser.value != null) {
      FirestoreService.to.syncContactMessages();
    } else {
      FirestoreService.to.stopContactMessages();
    }
  }

  bool get isAuthenticated => currentUser.value != null;

  /// Sign in with Email and Password via Firebase Auth
  Future<bool> signInWithEmailPassword(String email, String password) async {
    isLoading.value = true;
    authError.value = '';
    try {
      final credential = await _auth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );
      if (!_isAdmin(credential.user)) {
        await _auth.signOut();
        authError.value = 'This account is not authorized for admin access.';
        return false;
      }
      currentUser.value = credential.user;
      return true;
    } on FirebaseAuthException catch (e) {
      debugPrint('Firebase Auth error: ${e.code} - ${e.message}');
      if (e.code == 'user-not-found' ||
          e.code == 'wrong-password' ||
          e.code == 'invalid-credential') {
        authError.value = 'Invalid email or password.';
      } else if (e.code == 'configuration-not-found' ||
          e.code == 'operation-not-allowed') {
        authError.value =
            'Email/Password sign-in is not enabled in Firebase Console.';
      } else {
        authError.value = e.message ?? 'Authentication error occurred.';
      }
      return false;
    } catch (e) {
      debugPrint('Sign in exception: $e');
      authError.value = 'Sign in failed.';
      return false;
    } finally {
      isLoading.value = false;
    }
  }

  /// Sign out
  Future<void> signOut() async {
    try {
      await _auth.signOut();
    } catch (_) {}
    currentUser.value = null;
  }
}
