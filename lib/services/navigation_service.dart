import 'package:get/get.dart';
import '../routes/app_routes.dart';

class NavigationService {
  // Prevent instantiation
  NavigationService._();

  // Navigate to home screen
  static void navigateToHome() {
    Get.offAllNamed(AppRoutes.home);
  }

  // Navigate to splash screen
  static void navigateToSplash() {
    Get.offAllNamed(AppRoutes.splash);
  }

  // Navigate to a specific route
  static void navigateTo(String routeName) {
    Get.toNamed(routeName);
  }

  // Replace current screen with a new one
  static void replaceWith(String routeName) {
    Get.offNamed(routeName);
  }

  // Replace all screens with a new one
  static void replaceAllWith(String routeName) {
    Get.offAllNamed(routeName);
  }

  // Go back
  static void goBack() {
    Get.back();
  }

  // Go back to a specific route
  static void goBackTo(String routeName) {
    Get.until((route) => route.settings.name == routeName);
  }

  // Get current route name
  static String? getCurrentRoute() {
    return Get.currentRoute;
  }

  // Get previous route name
  static String? getPreviousRoute() {
    return Get.previousRoute;
  }
}
