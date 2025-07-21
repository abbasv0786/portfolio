import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import '../constants/colors.dart';
import '../constants/animations.dart';
import '../constants/spacing.dart';
import '../constants/strings.dart';
import '../constants/typography.dart';
import '../controllers/hero_controller.dart';
import '../widgets/glassmorphism_container.dart';
import 'gradient_button.dart';

class HeroSection extends StatelessWidget {
  final String name;
  final String title;
  final String subtitle;
  final String description;
  final VoidCallback? onScrollDownPressed;
  final VoidCallback? onContactPressed;

  const HeroSection({
    super.key,
    required this.name,
    required this.title,
    required this.subtitle,
    required this.description,
    this.onScrollDownPressed,
    this.onContactPressed,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<HeroSectionController>();
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < 768;

    return MouseRegion(
      onEnter: (event) =>
          controller.updateMousePosition(event.position.dx, event.position.dy),
      onHover: (event) =>
          controller.updateMousePosition(event.position.dx, event.position.dy),
      onExit: (_) => controller.updateMousePosition(0, 0),
      child: Container(
        height: size.height,
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: AppColors.heroGradient,
        ),
        child: Stack(
          children: [
            // Animated background particles
            ...List.generate(
                5, (index) => _buildParticle(index, size, controller)),

            // Main content
            Center(
              child: Container(
                padding: AppSpacing.getSectionPadding(context),
                constraints: const BoxConstraints(maxWidth: 1200),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Name with gradient effect
                    Text(
                      name,
                      style: AppTypography.gradient(
                        context,
                        baseStyle: AppTypography.displayLarge(context),
                      ),
                    )
                        .animate()
                        .fadeIn(duration: AppAnimations.slow)
                        .slideY(begin: 0.3, end: 0),

                    const SizedBox(height: AppSpacing.paddingLarge),

                    // Typing animation for title
                    GetBuilder<HeroSectionController>(
                        builder: (controller) => SizedBox(
                              height: AppTypography.headingLarge(context)
                                      .fontSize! *
                                  1.5,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    controller.currentTypingText.value,
                                    style: AppTypography.headingLarge(context)
                                        .copyWith(
                                      color: AppColors.secondary,
                                    ),
                                  ),
                                  AnimatedOpacity(
                                    opacity:
                                        controller.isTyping.value ? 1.0 : 0.0,
                                    duration: const Duration(milliseconds: 300),
                                    child: Container(
                                      width: 3,
                                      height:
                                          AppTypography.headingLarge(context)
                                              .fontSize,
                                      color: AppColors.secondary,
                                    ),
                                  ),
                                ],
                              ),
                            )).animate().fadeIn(
                        delay: AppAnimations.delayNormal),

                    const SizedBox(height: AppSpacing.paddingLarge),

                    // Subtitle
                    Text(
                      subtitle,
                      style: AppTypography.bodyLarge(context),
                    )
                        .animate()
                        .fadeIn(delay: AppAnimations.delaySlow)
                        .slideY(begin: 0.2, end: 0),

                    SizedBox(height: AppSpacing.getComponentSpacing(context)),

                    // Description in glassmorphism container
                    AnimatedGlassmorphismContainer(
                      padding: const EdgeInsets.all(AppSpacing.paddingLarge),
                      borderRadius: BorderRadius.circular(20),
                      child: Text(
                        description,
                        style: AppTypography.bodyMedium(context),
                        textAlign: TextAlign.center,
                        maxLines: 4,
                      ),
                    )
                        .animate()
                        .fadeIn(delay: AppAnimations.delayVerySlow)
                        .scale(
                            begin: const Offset(0.8, 0.8),
                            end: const Offset(1, 1)),

                    SizedBox(height: AppSpacing.getComponentSpacing(context)),

                    // Action buttons
                    Wrap(
                      spacing: AppSpacing.paddingLarge,
                      runSpacing: AppSpacing.paddingMedium,
                      alignment: WrapAlignment.center,
                      children: [
                        // Share Work Button
                        MouseRegion(
                          cursor: SystemMouseCursors.click,
                          onEnter: (_) => controller.setShareWorkHovered(true),
                          onExit: (_) => controller.setShareWorkHovered(false),
                          child: GetBuilder<HeroSectionController>(
                              builder: (controller) => AnimatedBuilder(
                                    animation: controller.pulseAnimation,
                                    builder: (context, child) {
                                      return Transform.scale(
                                        scale: controller
                                                .isShareWorkHovered.value
                                            ? 1.05
                                            : controller.pulseAnimation.value,
                                        child: GradientButton(
                                          onPressed: () {
                                            // Scroll to Projects section
                                            onScrollDownPressed?.call();
                                          },
                                          text: AppStrings.heroShareWork,
                                          width: isMobile ? 150 : 180,
                                        ),
                                      );
                                    },
                                  )),
                        )
                            .animate()
                            .fadeIn(
                                delay: AppAnimations.delayVerySlow +
                                    AppAnimations.delayNormal)
                            .slideX(begin: -0.2, end: 0),

                        // Contact Button
                        MouseRegion(
                          cursor: SystemMouseCursors.click,
                          onEnter: (_) => controller.setEmailHovered(true),
                          onExit: (_) => controller.setEmailHovered(false),
                          child: GestureDetector(
                            onTap: onContactPressed,
                            child: AnimatedGlassmorphismContainer(
                              padding: EdgeInsets.symmetric(
                                horizontal: isMobile ? 24 : 32,
                                vertical: isMobile ? 12 : 16,
                              ),
                              borderRadius: BorderRadius.circular(30),
                              enableHoverEffect: true,
                              child: Text(
                                AppStrings.heroContactMe,
                                style: AppTypography.button(context),
                              ),
                            ),
                          ),
                        )
                            .animate()
                            .fadeIn(
                                delay: AppAnimations.delayVerySlow +
                                    AppAnimations.delayNormal)
                            .slideX(begin: 0.2, end: 0),
                      ],
                    ),

                    SizedBox(
                        height: AppSpacing.getComponentSpacing(context) * 2),

                    // Scroll indicator
                    MouseRegion(
                      cursor: SystemMouseCursors.click,
                      onEnter: (_) => controller.setScrollDownHovered(true),
                      onExit: (_) => controller.setScrollDownHovered(false),
                      child: GestureDetector(
                        onTap: onScrollDownPressed,
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          transform: Matrix4.translationValues(
                            0,
                            controller.floatingAnimation.value,
                            0,
                          ),
                          child: Column(
                            children: [
                              Text(
                                AppStrings.heroScrollDown,
                                style: AppTypography.labelSmall(context),
                              ),
                              const SizedBox(height: 8),
                              GetBuilder<HeroSectionController>(
                                  builder: (controller) => Icon(
                                        Icons.keyboard_arrow_down,
                                        color:
                                            controller.isScrollDownHovered.value
                                                ? AppColors.primary
                                                : AppColors.textSecondary,
                                        size: 24,
                                      )),
                            ],
                          ),
                        ),
                      ),
                    )
                        .animate()
                        .fadeIn(delay: const Duration(seconds: 2))
                        .then()
                        .animate(onPlay: (controller) => controller.repeat())
                        .moveY(
                            begin: 0,
                            end: 10,
                            duration: const Duration(seconds: 2))
                        .then()
                        .moveY(
                            begin: 10,
                            end: 0,
                            duration: const Duration(seconds: 2)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildParticle(
      int index, Size size, HeroSectionController controller) {
    return GetBuilder<HeroSectionController>(builder: (controller) {
      final offset = controller.parallaxOffset.value;
      final mouseX = controller.mouseX.value;
      final mouseY = controller.mouseY.value;

      return Positioned(
        left: (size.width * (0.1 + index * 0.2)) +
            (mouseX * 0.02 * index) +
            offset,
        top: (size.height * (0.1 + index * 0.15)) + (mouseY * 0.02 * index),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          width: 100 + (index * 20),
          height: 100 + (index * 20),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: RadialGradient(
              colors: [
                AppColors.primary.withAlpha(20 - (index * 3)),
                AppColors.secondary.withAlpha(10 - (index * 2)),
                Colors.transparent,
              ],
            ),
          ),
        )
            .animate()
            .fadeIn(delay: Duration(milliseconds: 500 + (index * 200)))
            .scale(
              begin: const Offset(0, 0),
              end: const Offset(1, 1),
              duration: const Duration(seconds: 1),
            ),
      );
    });
  }
}
