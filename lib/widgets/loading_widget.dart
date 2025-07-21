import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../constants/colors.dart';
import '../constants/animations.dart';
import '../constants/spacing.dart';
import '../widgets/glassmorphism_container.dart';

class LoadingWidget extends StatelessWidget {
  final String? message;
  final double size;
  final bool showMessage;

  const LoadingWidget({
    super.key,
    this.message,
    this.size = 60,
    this.showMessage = true,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedGlassmorphismContainer(
      padding: const EdgeInsets.all(AppSpacing.paddingLarge),
      borderRadius: BorderRadius.circular(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Animated loading spinner
          SizedBox(
            width: size,
            height: size,
            child: Stack(
              children: [
                // Outer ring
                SizedBox(
                  width: size,
                  height: size,
                  child: CircularProgressIndicator(
                    strokeWidth: 3,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      AppColors.primary.withAlpha(100),
                    ),
                  ),
                )
                    .animate()
                    .rotate(duration: AppAnimations.loadingAnimationDuration)
                    .then()
                    .rotate(duration: AppAnimations.loadingAnimationDuration),

                // Inner ring
                SizedBox(
                  width: size * 0.7,
                  height: size * 0.7,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      AppColors.secondary.withAlpha(150),
                    ),
                  ),
                )
                    .animate()
                    .rotate(
                      duration: AppAnimations.loadingAnimationDuration,
                      delay: AppAnimations.delayNormal,
                    )
                    .then()
                    .rotate(
                      duration: AppAnimations.loadingAnimationDuration,
                      delay: AppAnimations.delayNormal,
                    ),

                // Center dot
                Center(
                  child: Container(
                    width: size * 0.2,
                    height: size * 0.2,
                    decoration: BoxDecoration(
                      color: AppColors.accent,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.accent.withAlpha(50),
                          blurRadius: 10,
                          spreadRadius: 2,
                        ),
                      ],
                    ),
                  ),
                )
                    .animate()
                    .scale(
                      duration: AppAnimations.fast,
                      begin: const Offset(0.8, 0.8),
                      end: const Offset(1.2, 1.2),
                    )
                    .then()
                    .scale(
                      duration: AppAnimations.fast,
                      begin: const Offset(1.2, 1.2),
                      end: const Offset(0.8, 0.8),
                    ),
              ],
            ),
          ),

          if (showMessage && message != null) ...[
            const SizedBox(height: AppSpacing.paddingMedium),
            Text(
              message!,
              style: const TextStyle(
                color: AppColors.textSecondary,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            )
                .animate()
                .fadeIn(delay: AppAnimations.delayNormal)
                .slideY(begin: 0.2, end: 0),
          ],
        ],
      ),
    )
        .animate()
        .fadeIn(duration: AppAnimations.normal)
        .scale(begin: const Offset(0.8, 0.8), end: const Offset(1, 1));
  }
}

class ShimmerLoadingWidget extends StatelessWidget {
  final double width;
  final double height;
  final BorderRadius? borderRadius;

  const ShimmerLoadingWidget({
    super.key,
    required this.width,
    required this.height,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: borderRadius ?? BorderRadius.circular(8),
        gradient: LinearGradient(
          colors: [
            AppColors.glassPrimary.withAlpha(50),
            AppColors.glassPrimary.withAlpha(100),
            AppColors.glassPrimary.withAlpha(50),
          ],
          stops: const [0.0, 0.5, 1.0],
        ),
      ),
    ).animate().shimmer(
          duration: AppAnimations.loadingAnimationDuration,
          color: AppColors.primary.withAlpha(30),
        );
  }
}

class PulseLoadingWidget extends StatelessWidget {
  final Widget child;
  final Duration duration;

  const PulseLoadingWidget({
    super.key,
    required this.child,
    this.duration = AppAnimations.loadingAnimationDuration,
  });

  @override
  Widget build(BuildContext context) {
    return child
        .animate()
        .scale(
          duration: duration,
          begin: const Offset(1, 1),
          end: const Offset(1.05, 1.05),
        )
        .then()
        .scale(
          duration: duration,
          begin: const Offset(1.05, 1.05),
          end: const Offset(1, 1),
        );
  }
}
