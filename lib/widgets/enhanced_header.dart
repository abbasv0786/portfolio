import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../constants/colors.dart';
import '../constants/animations.dart';
import '../controllers/app_controller.dart';

class EnhancedHeader extends StatelessWidget {
  final VoidCallback? onMenuPressed;
  final VoidCallback? onLogoPressed;
  final Function(int)? onNavigate;

  const EnhancedHeader({
    super.key,
    this.onMenuPressed,
    this.onLogoPressed,
    this.onNavigate,
  });

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 768;

    return GetBuilder<AppController>(
        builder: (controller) => AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              height: 80,
              decoration: BoxDecoration(
                color: AppColors.background
                    .withValues(alpha: controller.headerOpacity.value),
                border: Border(
                  bottom: BorderSide(
                    color: AppColors.glassBorder.withValues(alpha: 0.3),
                    width: 1,
                  ),
                ),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.shadowColor.withValues(alpha: 0.1),
                    blurRadius: 20,
                    spreadRadius: 0,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: isMobile ? 16 : 60,
                  vertical: 16,
                ),
                child: Row(
                  children: [
                    // Logo/Brand Section
                    MouseRegion(
                      cursor: SystemMouseCursors.click,
                      onEnter: (_) => controller.setHoverState('logo', true),
                      onExit: (_) => controller.setHoverState('logo', false),
                      child: GestureDetector(
                        onTap: onLogoPressed,
                        child: AnimatedContainer(
                          duration: AppAnimations.hoverDuration,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 8),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: controller.hoverStates['logo'] == true
                                ? AppColors.glassPrimary.withValues(alpha: 0.3)
                                : Colors.transparent,
                            border: Border.all(
                              color: AppColors.glassBorder,
                              width: 1,
                            ),
                          ),
                          child: const Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.home,
                                color: AppColors.textSecondary,
                                size: 16,
                              ),
                              SizedBox(width: 8),
                              Text(
                                'Home',
                                style: TextStyle(
                                  color: AppColors.textSecondary,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const Spacer(),
                    // Navigation Items (Desktop)
                    if (!isMobile) ...[
                      _buildNavItem('About', 1, Icons.person, controller),
                      const SizedBox(width: 8),
                      _buildNavItem('Projects', 2, Icons.work, controller),
                      const SizedBox(width: 8),
                      _buildNavItem(
                          'Experience', 3, Icons.timeline, controller),
                      const SizedBox(width: 8),
                      _buildNavItem(
                          'Approach', 4, Icons.psychology, controller),
                      const SizedBox(width: 8),
                      _buildNavItem('Contact', 5, Icons.email, controller),
                    ],

                    // Mobile Menu Button
                    if (isMobile) ...[
                      const SizedBox(width: 16),
                      MouseRegion(
                        cursor: SystemMouseCursors.click,
                        onEnter: (_) => controller.setHoverState('menu', true),
                        onExit: (_) => controller.setHoverState('menu', false),
                        child: GestureDetector(
                          onTap: onMenuPressed,
                          child: AnimatedContainer(
                            duration: AppAnimations.hoverDuration,
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              gradient: controller.hoverStates['menu'] == true
                                  ? AppColors.glassGradient
                                  : null,
                              color: controller.hoverStates['menu'] == true
                                  ? null
                                  : AppColors.glassPrimary
                                      .withValues(alpha: 0.3),
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: controller.hoverStates['menu'] == true
                                    ? AppColors.primary
                                    : AppColors.glassBorder,
                                width: controller.hoverStates['menu'] == true
                                    ? 2
                                    : 1,
                              ),
                            ),
                            child: const Icon(
                              Icons.menu,
                              color: AppColors.textPrimary,
                              size: 24,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ).animate().fadeIn(
                  duration: AppAnimations.verySlow,
                  delay: AppAnimations.delayFast,
                ));
  }

  Widget _buildNavItem(
      String title, int sectionIndex, IconData icon, AppController controller) {
    return GetBuilder<AppController>(builder: (controller) {
      final isActive = controller.currentSection.value == sectionIndex;
      final isHovered = controller.hoverStates['nav_$title'] == true;

      return MouseRegion(
        cursor: SystemMouseCursors.click,
        onEnter: (_) => controller.setHoverState('nav_$title', true),
        onExit: (_) => controller.setHoverState('nav_$title', false),
        child: GestureDetector(
          onTap: () {
            controller.setCurrentSection(sectionIndex);
            onNavigate?.call(sectionIndex);
          },
          child: AnimatedContainer(
            duration: AppAnimations.hoverDuration,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              gradient: isActive || isHovered ? AppColors.glassGradient : null,
              color: isActive || isHovered ? null : Colors.transparent,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: isActive ? AppColors.primary : AppColors.glassBorder,
                width: isActive ? 2 : 1,
              ),
              boxShadow: isActive || isHovered
                  ? [
                      BoxShadow(
                        color: AppColors.shadowColor.withValues(alpha: 0.3),
                        blurRadius: 10,
                        spreadRadius: 0,
                      ),
                    ]
                  : null,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  icon,
                  color: isActive || isHovered
                      ? AppColors.primary
                      : AppColors.textSecondary,
                  size: 16,
                ),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: TextStyle(
                    color: isActive || isHovered
                        ? AppColors.primary
                        : AppColors.textSecondary,
                    fontSize: 14,
                    fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
