import 'package:flutter/material.dart';

class AppColors {
  // Primary Brand Colors
  static const Color primary = Color(0xFF6366F1);
  static const Color primaryLight = Color(0xFF818CF8);
  static const Color primaryDark = Color(0xFF4F46E5);
  static const Color secondary = Color(0xFFE6E6FA);
  static const Color accent = Color(0xFF8B5CF6);
  static const Color accentLight = Color(0xFFA78BFA);
  static const Color accentDark = Color(0xFF7C3AED);

  // Glassmorphism Colors
  static const Color glassPrimary = Color(0x1A6366F1);
  static const Color glassSecondary = Color(0x1A8B5CF6);
  static const Color glassAccent = Color(0x1AE6E6FA);
  static const Color glassBackground = Color(0x0AFFFFFF);
  static const Color glassBorder = Color(0x33FFFFFF);
  static const Color glassShadow = Color(0x40000000);

  // Background Colors
  static const Color background = Color(0xFF0A0A0A);
  static const Color backgroundSecondary = Color(0xFF1A1A2E);
  static const Color backgroundTertiary = Color(0xFF16213E);
  static const Color backgroundWithOpacity = Color(0x1A1A1A2E);
  static const Color surface = Color(0xFF1E1E2E);
  static const Color surfaceVariant = Color(0xFF16213E);
  static const Color surfaceGlass = Color(0x1A1A1A2E);

  // Text Colors
  static const Color textPrimary = Color(0xFFFFFFFF);
  static const Color textSecondary = Color(0xFFE6E6FA);
  static const Color textTertiary = Color(0xFFB3B3B3);
  static const Color textPrimaryWithOpacity = Color(0x80FFFFFF);
  static const Color textSecondaryWithOpacity = Color(0xB3E6E6FA);

  // Border Colors
  static const Color borderPrimary = Color(0x4DFFFFFF);
  static const Color borderSecondary = Color(0x33FFFFFF);
  static const Color borderAccent = Color(0x4D6366F1);
  static const Color borderWithOpacity = Color(0x33FFFFFF);
  static const Color border = Color(0xFF3F3F5F);

  // Shadow Colors
  static const Color shadowColor = Color(0x40000000);
  static const Color shadowLight = Color(0x20000000);
  static const Color shadowDark = Color(0x60000000);

  // Status Colors
  static const Color success = Color(0xFF10B981);
  static const Color warning = Color(0xFFF59E0B);
  static const Color error = Color(0xFFEF4444);
  static const Color info = Color(0xFF3B82F6);

  // Glassmorphism Gradients
  static const LinearGradient glassGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0x1A6366F1),
      Color(0x1A8B5CF6),
      Color(0x1A6366F1),
    ],
  );

  static const LinearGradient glassGradientVertical = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color(0x1A6366F1),
      Color(0x1A8B5CF6),
      Color(0x1A6366F1),
    ],
  );

  static const RadialGradient glassGradientRadial = RadialGradient(
    center: Alignment.center,
    radius: 1.0,
    colors: [
      Color(0x1A6366F1),
      Color(0x1A8B5CF6),
      Color(0x1A6366F1),
    ],
  );

  // Background Gradients
  static const LinearGradient heroGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFF0A0A0A),
      Color(0xFF1A1A2E),
      Color(0xFF16213E),
    ],
  );

  static const LinearGradient cardGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0x1A6366F1),
      Color(0x1A8B5CF6),
      Color(0x1A6366F1),
    ],
  );

  static const LinearGradient textGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFFE6E6FA),
      Color(0xFF8B5CF6),
      Color(0xFF6366F1),
    ],
  );

  static const LinearGradient buttonGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFF6366F1),
      Color(0xFF8B5CF6),
    ],
  );

  static const LinearGradient buttonGradientHover = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFF818CF8),
      Color(0xFFA78BFA),
    ],
  );

  // Advanced Gradients
  static const LinearGradient premiumGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFF6366F1),
      Color(0xFF8B5CF6),
      Color(0xFFEC4899),
    ],
  );

  static const LinearGradient neonGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFF00FFFF),
      Color(0xFF6366F1),
      Color(0xFF8B5CF6),
    ],
  );

  // Glassmorphism Effects
  static const List<BoxShadow> glassShadowEffects = [
    BoxShadow(
      color: shadowColor,
      blurRadius: 20,
      spreadRadius: 0,
      offset: Offset(0, 10),
    ),
    BoxShadow(
      color: glassBorder,
      blurRadius: 1,
      spreadRadius: 0,
      offset: Offset(0, 0),
    ),
  ];

  static const List<BoxShadow> glassShadowLight = [
    BoxShadow(
      color: shadowLight,
      blurRadius: 10,
      spreadRadius: 0,
      offset: Offset(0, 5),
    ),
  ];

  static const List<BoxShadow> glassShadowIntense = [
    BoxShadow(
      color: shadowDark,
      blurRadius: 30,
      spreadRadius: 0,
      offset: Offset(0, 15),
    ),
    BoxShadow(
      color: glassBorder,
      blurRadius: 2,
      spreadRadius: 0,
      offset: Offset(0, 0),
    ),
  ];

  // Glassmorphism Decorations
  static BoxDecoration get glassDecoration => BoxDecoration(
        gradient: glassGradient,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: glassBorder,
          width: 1,
        ),
        boxShadow: glassShadowEffects,
      );

  static BoxDecoration get glassDecorationLight => BoxDecoration(
        gradient: glassGradient,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: glassBorder,
          width: 1,
        ),
        boxShadow: glassShadowLight,
      );

  static BoxDecoration get glassDecorationIntense => BoxDecoration(
        gradient: glassGradient,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: glassBorder,
          width: 2,
        ),
        boxShadow: glassShadowIntense,
      );
}
