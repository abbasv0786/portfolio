import 'package:flutter/material.dart';
import '../constants/colors.dart';

class AppTypography {
  // Prevent instantiation
  AppTypography._();

  // Font Family
  static const String primaryFont = 'Inter';
  static const String codeFont = 'JetBrains Mono';

  // Display Styles (Hero, Large Headers)
  static TextStyle displayLarge(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 768;
    return TextStyle(
      fontFamily: primaryFont,
      fontSize: isMobile ? 40 : 64,
      fontWeight: FontWeight.w800,
      height: 1.1,
      letterSpacing: -0.02,
      color: AppColors.textPrimary,
    );
  }

  static TextStyle displayMedium(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 768;
    return TextStyle(
      fontFamily: primaryFont,
      fontSize: isMobile ? 32 : 48,
      fontWeight: FontWeight.w700,
      height: 1.2,
      letterSpacing: -0.01,
      color: AppColors.textPrimary,
    );
  }

  static TextStyle displaySmall(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 768;
    return TextStyle(
      fontFamily: primaryFont,
      fontSize: isMobile ? 28 : 36,
      fontWeight: FontWeight.w600,
      height: 1.2,
      letterSpacing: -0.01,
      color: AppColors.textPrimary,
    );
  }

  // Heading Styles (Section Headers)
  static TextStyle headingLarge(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 768;
    return TextStyle(
      fontFamily: primaryFont,
      fontSize: isMobile ? 24 : 32,
      fontWeight: FontWeight.w600,
      height: 1.3,
      color: AppColors.textPrimary,
    );
  }

  static TextStyle headingMedium(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 768;
    return TextStyle(
      fontFamily: primaryFont,
      fontSize: isMobile ? 20 : 24,
      fontWeight: FontWeight.w600,
      height: 1.3,
      color: AppColors.textPrimary,
    );
  }

  static TextStyle headingSmall(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 768;
    return TextStyle(
      fontFamily: primaryFont,
      fontSize: isMobile ? 18 : 20,
      fontWeight: FontWeight.w500,
      height: 1.4,
      color: AppColors.textPrimary,
    );
  }

  // Body Styles
  static TextStyle bodyLarge(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 768;
    return TextStyle(
      fontFamily: primaryFont,
      fontSize: isMobile ? 16 : 18,
      fontWeight: FontWeight.w400,
      height: 1.6,
      color: AppColors.textSecondary,
    );
  }

  static TextStyle bodyMedium(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 768;
    return TextStyle(
      fontFamily: primaryFont,
      fontSize: isMobile ? 14 : 16,
      fontWeight: FontWeight.w400,
      height: 1.6,
      color: AppColors.textSecondary,
    );
  }

  static TextStyle bodySmall(BuildContext context) {
    return const TextStyle(
      fontFamily: primaryFont,
      fontSize: 14,
      fontWeight: FontWeight.w400,
      height: 1.5,
      color: AppColors.textSecondary,
    );
  }

  // Label Styles (Buttons, Tags)
  static TextStyle labelLarge(BuildContext context) {
    return const TextStyle(
      fontFamily: primaryFont,
      fontSize: 16,
      fontWeight: FontWeight.w600,
      height: 1.2,
      letterSpacing: 0.02,
      color: AppColors.textPrimary,
    );
  }

  static TextStyle labelMedium(BuildContext context) {
    return const TextStyle(
      fontFamily: primaryFont,
      fontSize: 14,
      fontWeight: FontWeight.w500,
      height: 1.2,
      letterSpacing: 0.01,
      color: AppColors.textPrimary,
    );
  }

  static TextStyle labelSmall(BuildContext context) {
    return const TextStyle(
      fontFamily: primaryFont,
      fontSize: 12,
      fontWeight: FontWeight.w500,
      height: 1.2,
      letterSpacing: 0.01,
      color: AppColors.textSecondary,
    );
  }

  // Special Styles
  static TextStyle code(BuildContext context) {
    return const TextStyle(
      fontFamily: codeFont,
      fontSize: 14,
      fontWeight: FontWeight.w400,
      height: 1.5,
      color: AppColors.primary,
    );
  }

  static TextStyle gradient(BuildContext context,
      {required TextStyle baseStyle}) {
    return baseStyle.copyWith(
      foreground: Paint()
        ..shader = const LinearGradient(
          colors: [
            AppColors.primary,
            AppColors.secondary,
          ],
        ).createShader(const Rect.fromLTWH(0.0, 0.0, 200.0, 70.0)),
    );
  }

  static TextStyle glow(BuildContext context, {required TextStyle baseStyle}) {
    return baseStyle.copyWith(
      shadows: [
        Shadow(
          color: AppColors.primary.withAlpha(102),
          blurRadius: 20,
        ),
      ],
    );
  }

  // Navigation Styles
  static TextStyle navItem(BuildContext context, {bool isActive = false}) {
    return TextStyle(
      fontFamily: primaryFont,
      fontSize: 14,
      fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
      height: 1.2,
      color: isActive ? AppColors.primary : AppColors.textSecondary,
    );
  }

  // Button Styles
  static TextStyle button(BuildContext context) {
    return const TextStyle(
      fontFamily: primaryFont,
      fontSize: 16,
      fontWeight: FontWeight.w600,
      height: 1.2,
      letterSpacing: 0.02,
      color: AppColors.textPrimary,
    );
  }

  static TextStyle buttonSmall(BuildContext context) {
    return const TextStyle(
      fontFamily: primaryFont,
      fontSize: 14,
      fontWeight: FontWeight.w500,
      height: 1.2,
      letterSpacing: 0.01,
      color: AppColors.textPrimary,
    );
  }

  // Card Styles
  static TextStyle cardTitle(BuildContext context) {
    return const TextStyle(
      fontFamily: primaryFont,
      fontSize: 20,
      fontWeight: FontWeight.w600,
      height: 1.3,
      color: AppColors.textPrimary,
    );
  }

  static TextStyle cardDescription(BuildContext context) {
    return const TextStyle(
      fontFamily: primaryFont,
      fontSize: 14,
      fontWeight: FontWeight.w400,
      height: 1.6,
      color: AppColors.textSecondaryWithOpacity,
    );
  }

  // Tag Styles
  static TextStyle tag(BuildContext context) {
    return const TextStyle(
      fontFamily: primaryFont,
      fontSize: 12,
      fontWeight: FontWeight.w500,
      height: 1.2,
      color: AppColors.secondary,
    );
  }

  // Footer Styles
  static TextStyle footerText(BuildContext context) {
    return const TextStyle(
      fontFamily: primaryFont,
      fontSize: 14,
      fontWeight: FontWeight.w400,
      height: 1.5,
      color: AppColors.textSecondary,
    );
  }

  static TextStyle footerLink(BuildContext context) {
    return const TextStyle(
      fontFamily: primaryFont,
      fontSize: 14,
      fontWeight: FontWeight.w500,
      height: 1.5,
      color: AppColors.primary,
    );
  }

  // Helper method to apply responsive sizing
  static double getResponsiveFontSize(
    BuildContext context, {
    required double mobile,
    required double desktop,
  }) {
    final width = MediaQuery.of(context).size.width;
    if (width < 768) return mobile;
    if (width < 1024) return mobile + (desktop - mobile) * 0.5;
    return desktop;
  }
}
