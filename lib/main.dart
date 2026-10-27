import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'constants/theme.dart';
import 'controllers/app_controller.dart';
import 'controllers/hero_controller.dart';
import 'controllers/projects_controller.dart';
import 'controllers/experience_controller.dart';
import 'controllers/about_controller.dart';
import 'controllers/contact_controller.dart';
import 'controllers/approach_controller.dart';
import 'controllers/theme_controller.dart';
import 'services/firestore_service.dart';
import 'services/auth_service.dart';
import 'routes/app_routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Set preferred orientations
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);

  // Initialize Firebase with platform-specific options
  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  } catch (e) {
    debugPrint('Firebase initialization note: $e');
  }

  // Initialize GetX Services & Controllers
  _initializeServicesAndControllers();

  runApp(const MyApp());
}

void _initializeServicesAndControllers() {
  // Services first
  Get.put(FirestoreService());
  Get.put(AuthService());

  // Controllers
  Get.put(AppController());
  Get.put(HeroSectionController());
  Get.put(ProjectsController());
  Get.put(ExperienceController());
  Get.put(AboutController());
  Get.put(ContactController());
  Get.put(ApproachController());
  Get.put(ThemeController());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'AhemadAbbas Vagh - Portfolio',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      initialRoute: AppRoutes.splash,
      routes: AppRoutes.getRoutes(),
      onGenerateRoute: AppRoutes.onGenerateRoute,
      onUnknownRoute: AppRoutes.onUnknownRoute,
    );
  }
}
