import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import '../constants/colors.dart';
import '../constants/animations.dart';
import '../constants/spacing.dart';
import '../constants/typography.dart';
import '../controllers/experience_controller.dart';
import '../models/experience.dart';

import '../widgets/glassmorphism_container.dart';
import 'section_header.dart';

class ExperienceSection extends StatelessWidget {
  const ExperienceSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: AppSpacing.getSectionPadding(context),
      child: Column(
        children: [
          // Section Header
          const SectionHeader(
            title: 'My work experience',
            subtitle: 'Professional journey and achievements',
          ),
          SizedBox(height: AppSpacing.getSectionSpacing(context)),

          // Experience Timeline
          GetBuilder<ExperienceController>(
              builder: (controller) => Column(
                    children: controller.experiences
                        .asMap()
                        .entries
                        .map<Widget>((entry) {
                      final index = entry.key;
                      final experience = entry.value;
                      final isHovered = controller.isCardHovered(index);

                      return MouseRegion(
                        onEnter: (_) => controller.setCardHovered(index, true),
                        onExit: (_) => controller.setCardHovered(index, false),
                        child: GestureDetector(
                          onTapDown: (_) =>
                              controller.setCardPressed(index, true),
                          onTapUp: (_) =>
                              controller.setCardPressed(index, false),
                          onTapCancel: () =>
                              controller.setCardPressed(index, false),
                          child: _ExperienceCard(
                            experience: experience,
                            index: index,
                            isHovered: isHovered,
                          ),
                        ),
                      ).animate().fadeIn(
                            delay:
                                Duration(milliseconds: (200 * index).toInt()),
                            duration: AppAnimations.normal,
                          );
                    }).toList(),
                  )),
        ],
      ),
    );
  }
}

class _ExperienceCard extends StatelessWidget {
  final Experience experience;
  final int index;
  final bool isHovered;

  const _ExperienceCard({
    required this.experience,
    required this.index,
    required this.isHovered,
  });

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 768;

    return MouseRegion(
      onEnter: (_) =>
          Get.find<ExperienceController>().setCardHovered(index, true),
      onExit: (_) =>
          Get.find<ExperienceController>().setCardHovered(index, false),
      cursor: SystemMouseCursors.click,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        margin: EdgeInsets.only(bottom: isMobile ? 16 : 24),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Timeline indicator
            Column(
              children: [
                AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  width: isMobile ? 12 : 16,
                  height: isMobile ? 12 : 16,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: isHovered ? AppColors.primary : AppColors.secondary,
                    boxShadow: isHovered
                        ? [
                            BoxShadow(
                              color: AppColors.primary.withAlpha(100),
                              blurRadius: 8,
                              spreadRadius: 2,
                            ),
                          ]
                        : [],
                  ),
                ),
                if (index <
                    Get.find<ExperienceController>().experiences.length - 1)
                  Container(
                    width: 2,
                    height: isMobile ? 120 : 150,
                    color: AppColors.textTertiary.withAlpha(50),
                  ),
              ],
            ),
            const SizedBox(width: AppSpacing.paddingMedium),
            // Experience content
            Expanded(
              child: AnimatedGlassmorphismContainer(
                padding: EdgeInsets.all(isMobile
                    ? AppSpacing.paddingMedium
                    : AppSpacing.paddingLarge),
                borderRadius: BorderRadius.circular(16),
                enableHoverEffect: true,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Company and duration
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            experience.company,
                            style: AppTypography.headingSmall(context).copyWith(
                              color: AppColors.primary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.secondary.withAlpha(30),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: AppColors.secondary.withAlpha(100),
                              width: 1,
                            ),
                          ),
                          child: Text(
                            experience.duration,
                            style: AppTypography.bodySmall(context).copyWith(
                              color: AppColors.secondary,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: AppSpacing.paddingSmall),
                    // Position
                    Text(
                      experience.position,
                      style: AppTypography.bodyLarge(context).copyWith(
                        color: AppColors.textPrimary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    if (experience.location != null) ...[
                      const SizedBox(height: AppSpacing.paddingXSmall),
                      Text(
                        experience.location!,
                        style: AppTypography.bodySmall(context).copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                    const SizedBox(height: AppSpacing.paddingMedium),
                    // Description
                    Text(
                      experience.description,
                      style: AppTypography.bodyMedium(context).copyWith(
                        color: AppColors.textSecondary,
                        height: 1.6,
                      ),
                    ),

                    if (experience.technologies.isNotEmpty) ...[
                      const SizedBox(height: AppSpacing.paddingMedium),
                      // Technologies
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: experience.technologies
                            .map((tech) => Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 10,
                                    vertical: 4,
                                  ),
                                  decoration: BoxDecoration(
                                    color: AppColors.primary.withAlpha(30),
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(
                                      color: AppColors.primary.withAlpha(100),
                                      width: 1,
                                    ),
                                  ),
                                  child: Text(
                                    tech,
                                    style: AppTypography.tag(context).copyWith(
                                      color: AppColors.primary,
                                      fontSize: 11,
                                    ),
                                  ),
                                ))
                            .toList(),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    )
        .animate()
        .fadeIn(delay: Duration(milliseconds: 100 + (index * 100)))
        .slideX(begin: -0.2, end: 0);
  }
}
