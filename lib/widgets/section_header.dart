import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../constants/colors.dart';
import '../constants/animations.dart';
import '../constants/dimensions.dart';

class SectionHeader extends StatelessWidget {
  final String title;
  final String? subtitle;
  final bool useGradientText;
  final Duration delay;

  const SectionHeader({
    super.key,
    required this.title,
    this.subtitle,
    this.useGradientText = true,
    this.delay = AppAnimations.delayNormal,
  });

  @override
  Widget build(BuildContext context) {
    final isMobile =
        MediaQuery.of(context).size.width < AppDimensions.mobileBreakpoint;

    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Main heading
          useGradientText
              ? ShaderMask(
                  shaderCallback: (bounds) =>
                      AppColors.textGradient.createShader(bounds),
                  child: Text(
                    title.toUpperCase(),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: isMobile
                          ? AppDimensions.sectionHeaderFontSizeMobile
                          : AppDimensions.sectionHeaderFontSizeDesktop,
                      fontWeight: FontWeight.bold,
                      letterSpacing: AppDimensions.sectionHeaderLetterSpacing,
                    ),
                  ),
                )
              : Text(
                  title,
                  style: TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: isMobile
                        ? AppDimensions.sectionHeaderFontSizeMobile
                        : AppDimensions.sectionHeaderFontSizeDesktop,
                    fontWeight: FontWeight.bold,
                    letterSpacing: AppDimensions.sectionHeaderLetterSpacing,
                  ),
                ),
          if (subtitle != null) ...[
            const SizedBox(height: AppDimensions.sectionHeaderSpacing),
            Text(
              subtitle!,
              style: TextStyle(
                color: AppColors.textSecondary,
                fontSize: isMobile
                    ? AppDimensions.sectionSubtitleFontSizeMobile
                    : AppDimensions.sectionSubtitleFontSizeDesktop,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ],
      ),
    ).animate().fadeIn(duration: AppAnimations.verySlow, delay: delay);
  }
}
