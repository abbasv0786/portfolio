import 'package:flutter/material.dart';
import '../screens/splash_screen.dart';
import '../screens/home_screen.dart';
import '../screens/admin/admin_screen.dart';
import '../constants/routes.dart';

class AppRoutes {
  // Prevent instantiation
  AppRoutes._();

  // Route names
  static const String splash = RouteNames.splash;
  static const String home = RouteNames.home;
  static const String admin = RouteNames.admin;

  // Route configuration
  static Map<String, WidgetBuilder> getRoutes() {
    return {
      splash: (context) => const SplashScreen(),
      home: (context) => const HomeScreen(),
      admin: (context) => const AdminScreen(),
    };
  }

  // Route generation for dynamic routes
  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    if (settings.name == admin || settings.name == '/admin') {
      return MaterialPageRoute(builder: (context) => const AdminScreen());
    }
    return null;
  }

  // Unknown route handler
  static Route<dynamic>? onUnknownRoute(RouteSettings settings) {
    return MaterialPageRoute(
      builder: (context) => const SplashScreen(),
    );
  }
}
