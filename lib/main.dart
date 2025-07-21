import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'constants/theme.dart';
import 'controllers/app_controller.dart';
import 'controllers/hero_controller.dart';
import 'controllers/projects_controller.dart';
import 'controllers/experience_controller.dart';
import 'controllers/about_controller.dart';
import 'controllers/contact_controller.dart';
import 'controllers/approach_controller.dart';
import 'controllers/theme_controller.dart';
import 'routes/app_routes.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // Set preferred orientations for web
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);

  // Initialize GetX controllers
  _initializeControllers();

  runApp(const MyApp());
}

void _initializeControllers() {
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
      title: 'AhemadAbbas Vagh - Profile',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      initialRoute: AppRoutes.splash,
      routes: AppRoutes.getRoutes(),
      onGenerateRoute: AppRoutes.onGenerateRoute,
      onUnknownRoute: AppRoutes.onUnknownRoute,
    );
  }
}
