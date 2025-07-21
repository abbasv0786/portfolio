import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../constants/colors.dart';

class ThemeController extends GetxController {
  // Theme state
  final RxBool isDarkMode = false.obs;
  final RxBool isHighContrast = false.obs;
  final RxBool isReducedMotion = false.obs;

  // Color scheme
  final Rx<Color> primaryColor = AppColors.primary.obs;
  final Rx<Color> secondaryColor = AppColors.secondary.obs;
  final Rx<Color> accentColor = AppColors.accent.obs;

  // Animation preferences
  final RxBool enableAnimations = true.obs;
  final RxBool enableHoverEffects = true.obs;
  final RxBool enableParticles = true.obs;

  // Accessibility settings
  final RxDouble textScaleFactor = 1.0.obs;
  final RxBool enableScreenReader = false.obs;

  // Methods
  void toggleDarkMode() {
    isDarkMode.value = !isDarkMode.value;
    _updateColorScheme();
  }

  void toggleHighContrast() {
    isHighContrast.value = !isHighContrast.value;
    _updateColorScheme();
  }

  void toggleReducedMotion() {
    isReducedMotion.value = !isReducedMotion.value;
    enableAnimations.value = !isReducedMotion.value;
  }

  void setPrimaryColor(Color color) {
    primaryColor.value = color;
    _updateColorScheme();
  }

  void setSecondaryColor(Color color) {
    secondaryColor.value = color;
    _updateColorScheme();
  }

  void setAccentColor(Color color) {
    accentColor.value = color;
    _updateColorScheme();
  }

  void setTextScaleFactor(double factor) {
    textScaleFactor.value = factor.clamp(0.8, 2.0);
  }

  void toggleAnimations() {
    enableAnimations.value = !enableAnimations.value;
  }

  void toggleHoverEffects() {
    enableHoverEffects.value = !enableHoverEffects.value;
  }

  void toggleParticles() {
    enableParticles.value = !enableParticles.value;
  }

  void toggleScreenReader() {
    enableScreenReader.value = !enableScreenReader.value;
  }

  void _updateColorScheme() {
    if (isDarkMode.value) {
      // Dark mode colors
      primaryColor.value = const Color(0xFF64FFDA);
      secondaryColor.value = const Color(0xFF7B68EE);
      accentColor.value = const Color(0xFFFF6B6B);
    } else {
      // Light mode colors
      primaryColor.value = AppColors.primary;
      secondaryColor.value = AppColors.secondary;
      accentColor.value = AppColors.accent;
    }

    if (isHighContrast.value) {
      // High contrast adjustments
      primaryColor.value = primaryColor.value.withAlpha(255);
      secondaryColor.value = secondaryColor.value.withAlpha(255);
      accentColor.value = accentColor.value.withAlpha(255);
    }
  }

  // Get current theme data
  ThemeData get currentTheme {
    return ThemeData(
      brightness: isDarkMode.value ? Brightness.dark : Brightness.light,
      primaryColor: primaryColor.value,
      colorScheme: ColorScheme.fromSeed(
        seedColor: primaryColor.value,
        brightness: isDarkMode.value ? Brightness.dark : Brightness.light,
      ),
      textTheme: TextTheme(
        bodyLarge: TextStyle(
          fontSize: 16 * textScaleFactor.value,
        ),
        bodyMedium: TextStyle(
          fontSize: 14 * textScaleFactor.value,
        ),
        bodySmall: TextStyle(
          fontSize: 12 * textScaleFactor.value,
        ),
      ),
      // Disable animations if reduced motion is enabled
      pageTransitionsTheme: isReducedMotion.value
          ? const PageTransitionsTheme(
              builders: {
                TargetPlatform.android: CupertinoPageTransitionsBuilder(),
                TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
              },
            )
          : null,
    );
  }

  // Get animation duration based on preferences
  Duration getAnimationDuration(Duration baseDuration) {
    if (isReducedMotion.value) {
      return Duration.zero;
    }
    return baseDuration;
  }

  // Get hover effect enabled state
  bool get isHoverEnabled => enableHoverEffects.value && !isReducedMotion.value;

  // Get particle effect enabled state
  bool get isParticleEnabled => enableParticles.value && !isReducedMotion.value;

  @override
  void onInit() {
    super.onInit();
    // Initialize with system preferences
    _loadUserPreferences();
  }

  void _loadUserPreferences() {
    // Load saved preferences (in a real app, this would use SharedPreferences)
    // For now, we'll use default values
    isDarkMode.value = false;
    isHighContrast.value = false;
    isReducedMotion.value = false;
    enableAnimations.value = true;
    enableHoverEffects.value = true;
    enableParticles.value = true;
    textScaleFactor.value = 1.0;
    enableScreenReader.value = false;
  }

  void saveUserPreferences() {
    // Save preferences (in a real app, this would use SharedPreferences)
    // For now, we'll just update the state
    update();
  }
}
