import 'package:flutter/material.dart';
import '../screens/splash_screen.dart';
import '../screens/home_screen.dart';
import '../constants/routes.dart';

class AppRoutes {
  // Prevent instantiation
  AppRoutes._();

  // Route names
  static const String splash = RouteNames.splash;
  static const String home = RouteNames.home;

  // Route configuration
  static Map<String, WidgetBuilder> getRoutes() {
    return {
      splash: (context) => const SplashScreen(),
      home: (context) => const HomeScreen(),
    };
  }

  // Route generation for dynamic routes (if needed in the future)
  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    // Handle dynamic routes here if needed
    return null;
  }

  // Unknown route handler
  static Route<dynamic>? onUnknownRoute(RouteSettings settings) {
    return MaterialPageRoute(
      builder: (context) => const SplashScreen(),
    );
  }
}
