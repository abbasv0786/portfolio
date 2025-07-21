import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:portfolio/widgets/profile_section.dart';
import '../constants/colors.dart';
import '../constants/animations.dart';
import '../constants/spacing.dart';
import '../constants/strings.dart';
import '../constants/typography.dart';
import '../controllers/about_controller.dart';
import '../widgets/glassmorphism_container.dart';
import '../widgets/section_header.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AboutController>();
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < 768;

    return Container(
      padding: AppSpacing.getSectionPadding(context),
      child: Column(
        children: [
          // Section Header
          _buildSectionHeader(context),

          // Profile Section
          const ProfileSection(),

          // About Cards
          _buildAboutCards(context, controller, isMobile: isMobile),

          SizedBox(height: AppSpacing.getComponentSpacing(context) * 2),

          // Tech Stack
          _buildTechStack(context, controller),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context) {
    return const SectionHeader(
      title: AppStrings.aboutTitle,
      subtitle: AppStrings.aboutSubtitle,
      useGradientText: true,
    );
  }

  Widget _buildAboutCards(BuildContext context, AboutController controller,
      {required bool isMobile}) {
    return GetBuilder<AboutController>(builder: (controller) {
      if (MediaQuery.of(context).size.width < 768) {
        // Single column layout for mobile and tablet
        return Column(
          children: controller.aboutCards.map((card) {
            final index = controller.aboutCards.indexOf(card);

            return Padding(
              padding: const EdgeInsets.only(bottom: AppSpacing.paddingMedium),
              child: MouseRegion(
                cursor: SystemMouseCursors.click,
                onEnter: (_) => controller.setCardHovered(index, true),
                onExit: (_) => controller.setCardHovered(index, false),
                child: GestureDetector(
                  onTap: () {
                    // Handle card tap if needed
                  },
                  child: AnimatedGlassmorphismContainer(
                    borderRadius: BorderRadius.circular(20),
                    padding: EdgeInsets.all(
                        isMobile ? AppSpacing.paddingMedium : 32),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                AppColors.primary.withValues(alpha: 0.2),
                                AppColors.secondary.withValues(alpha: 0.2),
                              ],
                            ),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Text(
                            card.icon,
                            style: const TextStyle(fontSize: 32),
                          ),
                        ),
                        const SizedBox(width: AppSpacing.paddingMedium),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                card.title,
                                style: AppTypography.headingSmall(context)
                                    .copyWith(
                                  color: AppColors.textPrimary,
                                ),
                              ),
                              const SizedBox(height: AppSpacing.paddingSmall),
                              Text(
                                card.description,
                                style:
                                    AppTypography.bodyMedium(context).copyWith(
                                  color: AppColors.textSecondary,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            )
                .animate()
                .fadeIn(delay: Duration(milliseconds: 200 + index * 100))
                .slideY(begin: 0.2, end: 0);
          }).toList(),
        );
      } else {
        // Responsive grid layout for desktop
        return LayoutBuilder(
          builder: (context, constraints) {
            final screenWidth = constraints.maxWidth;
            final isLargeScreen = screenWidth > 1200;

            // Calculate card width to fit 2 cards per row with equal spacing
            const totalPadding =
                AppSpacing.paddingLarge * 3; // Left, right, and center spacing
            final availableWidth = screenWidth - totalPadding;
            final cardWidth = availableWidth / 2;

            // Ensure minimum card width for better appearance
            final finalCardWidth = cardWidth < 280 ? 280.0 : cardWidth;

            return Center(
              child: Wrap(
                spacing: AppSpacing.paddingLarge,
                runSpacing: AppSpacing.paddingLarge,
                alignment: WrapAlignment.center,
                children: controller.aboutCards.asMap().entries.map((entry) {
                  final index = entry.key;
                  final card = entry.value;

                  return SizedBox(
                    width: finalCardWidth,
                    child: MouseRegion(
                      cursor: SystemMouseCursors.click,
                      onEnter: (_) => controller.setCardHovered(index, true),
                      onExit: (_) => controller.setCardHovered(index, false),
                      child: AnimatedGlassmorphismContainer(
                        padding: EdgeInsets.all(isLargeScreen
                            ? AppSpacing.paddingLarge
                            : AppSpacing.paddingMedium),
                        borderRadius: BorderRadius.circular(16),
                        enableHoverEffect: true,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // Icon
                            Text(
                              card.icon,
                              style:
                                  TextStyle(fontSize: isLargeScreen ? 32 : 28),
                            ),

                            SizedBox(
                                height: isLargeScreen
                                    ? AppSpacing.paddingMedium
                                    : AppSpacing.paddingSmall),

                            // Title
                            Text(
                              card.title,
                              style: AppTypography.cardTitle(context).copyWith(
                                fontSize: isLargeScreen ? null : 16,
                              ),
                              textAlign: TextAlign.center,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),

                            SizedBox(
                                height: isLargeScreen
                                    ? AppSpacing.paddingMedium
                                    : AppSpacing.paddingSmall),

                            // Description
                            Text(
                              card.description,
                              style: AppTypography.cardDescription(context)
                                  .copyWith(
                                fontSize: isLargeScreen ? null : 14,
                              ),
                              textAlign: TextAlign.center,
                              maxLines: 4,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                      .animate()
                      .fadeIn(
                          delay: Duration(milliseconds: 200 + (index * 100)))
                      .slideY(begin: 0.2, end: 0);
                }).toList(),
              ),
            );
          },
        );
      }
    });
  }

  Widget _buildTechStack(BuildContext context, AboutController controller) {
    final isMobile = MediaQuery.of(context).size.width < 768;

    return Column(
      children: [
        Text(
          AppStrings.techStackTitle,
          style: AppTypography.headingMedium(context),
        )
            .animate()
            .fadeIn(delay: AppAnimations.delaySlow)
            .slideY(begin: 0.2, end: 0),
        const SizedBox(height: AppSpacing.paddingLarge),
        GetBuilder<AboutController>(
            builder: (controller) => SizedBox(
                  // Ensure full width and proper spacing for mobile
                  width: double.infinity,
                  child: Wrap(
                    spacing: isMobile
                        ? AppSpacing.paddingMedium
                        : AppSpacing.paddingLarge,
                    runSpacing: isMobile
                        ? AppSpacing.paddingMedium
                        : AppSpacing.paddingLarge,
                    alignment: WrapAlignment.center,
                    children: controller.techCategories.map((category) {
                      final index = controller.techCategories.indexOf(category);
                      final progress = controller.skillsAnimationProgress.value;
                      final shouldShow =
                          index < (progress * controller.techCategories.length);

                      return AnimatedOpacity(
                        opacity: shouldShow ? 1.0 : 0.0,
                        duration: const Duration(milliseconds: 300),
                        child: AnimatedGlassmorphismContainer(
                          padding: EdgeInsets.all(isMobile
                              ? AppSpacing.paddingMedium
                              : AppSpacing.paddingLarge),
                          borderRadius: BorderRadius.circular(16),
                          child: Column(
                            children: [
                              Text(
                                category.title,
                                style:
                                    AppTypography.labelMedium(context).copyWith(
                                  color: Color(category.color),
                                  fontSize: isMobile ? 14 : 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(height: AppSpacing.paddingMedium),
                              Wrap(
                                spacing: isMobile ? 4 : 6,
                                runSpacing: isMobile ? 4 : 6,
                                alignment: WrapAlignment.center,
                                children: category.skills.map((skill) {
                                  return Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: isMobile ? 8 : 10,
                                      vertical: isMobile ? 4 : 6,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Color(category.color)
                                          .withValues(alpha: 0.1),
                                      borderRadius: BorderRadius.circular(6),
                                      border: Border.all(
                                        color: Color(category.color)
                                            .withValues(alpha: 0.3),
                                        width: 1,
                                      ),
                                    ),
                                    child: Text(
                                      skill,
                                      style:
                                          AppTypography.tag(context).copyWith(
                                        color: Color(category.color),
                                        fontSize: isMobile ? 12 : 14,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  );
                                }).toList(),
                              ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                )),
      ],
    );
  }
}
