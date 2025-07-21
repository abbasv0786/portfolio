import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import '../constants/colors.dart';
import '../constants/animations.dart';
import '../constants/spacing.dart';
import '../constants/strings.dart';
import '../constants/typography.dart';
import '../controllers/approach_controller.dart';
import '../widgets/glassmorphism_container.dart';
import '../widgets/section_header.dart';

class ApproachSection extends StatelessWidget {
  const ApproachSection({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<ApproachController>();
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < 768;

    return Container(
      padding: AppSpacing.getSectionPadding(context),
      child: Column(
        children: [
          // Section Header
          _buildSectionHeader(context),

          SizedBox(height: AppSpacing.getComponentSpacing(context) * 2),

          // Approach Cards
          _buildApproachCards(context, controller, isMobile),

          SizedBox(height: AppSpacing.getComponentSpacing(context) * 2),

          // Call to Action
          _buildCallToAction(context),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context) {
    return const SectionHeader(
      title: AppStrings.approachTitle,
      subtitle: AppStrings.approachSubtitle,
      useGradientText: true,
    );
  }

  Widget _buildApproachCards(
      BuildContext context, ApproachController controller, bool isMobile) {
    return GetBuilder<ApproachController>(
        builder: (controller) => Wrap(
              spacing: isMobile ? AppSpacing.paddingLarge : 24,
              runSpacing: AppSpacing.paddingLarge,
              alignment: WrapAlignment.center,
              runAlignment: WrapAlignment.center,
              children: controller.approachPhases.asMap().entries.map((entry) {
                final index = entry.key;
                final phase = entry.value;
                final isExpanded = controller.isCardExpanded(index);

                return SizedBox(
                  width: isMobile
                      ? double.infinity
                      : (MediaQuery.of(context).size.width - 320) / 2,
                  child: MouseRegion(
                    cursor: SystemMouseCursors.click,
                    onEnter: (_) => controller.setCardHovered(index, true),
                    onExit: (_) => controller.setCardHovered(index, false),
                    child: GestureDetector(
                      onTap: () => controller.toggleCardExpanded(index),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 400),
                        curve: Curves.easeInOut,
                        height:
                            isExpanded ? 350 : 120, // Adjusted expanded height
                        child: AnimatedGlassmorphismContainer(
                          padding: EdgeInsets.all(isExpanded
                              ? AppSpacing.paddingMedium
                              : AppSpacing.paddingMedium),
                          borderRadius: BorderRadius.circular(20),
                          enableHoverEffect: true,
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                // Header with icon and title
                                Row(
                                  children: [
                                    Container(
                                      width: 48,
                                      height: 48,
                                      decoration: BoxDecoration(
                                        color: Color(phase.color).withAlpha(30),
                                        borderRadius: BorderRadius.circular(12),
                                        border: Border.all(
                                          color:
                                              Color(phase.color).withAlpha(100),
                                          width: 1,
                                        ),
                                      ),
                                      child: Center(
                                        child: Text(
                                          phase.icon,
                                          style: const TextStyle(fontSize: 24),
                                        ),
                                      ),
                                    ),

                                    const SizedBox(
                                        width: AppSpacing.paddingMedium),

                                    Expanded(
                                      child: Text(
                                        phase.title,
                                        style: AppTypography.cardTitle(context),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),

                                    // Expand/Collapse icon with animation
                                    AnimatedRotation(
                                      turns: isExpanded ? 0.5 : 0.0,
                                      duration:
                                          const Duration(milliseconds: 300),
                                      child: const Icon(
                                        Icons.keyboard_arrow_down,
                                        color: AppColors.textSecondary,
                                        size: 24,
                                      ),
                                    ),
                                  ],
                                ),

                                const SizedBox(
                                    height: AppSpacing.paddingMedium),

                                // Description
                                Text(
                                  phase.description,
                                  style: AppTypography.cardDescription(context),
                                  maxLines: isExpanded ? null : 1,
                                  overflow:
                                      isExpanded ? null : TextOverflow.ellipsis,
                                ),

                                // Expanded details
                                if (isExpanded) ...[
                                  const SizedBox(
                                      height: AppSpacing.paddingSmall),
                                  Container(
                                    padding: const EdgeInsets.all(
                                        AppSpacing.paddingSmall),
                                    decoration: BoxDecoration(
                                      color:
                                          AppColors.glassPrimary.withAlpha(30),
                                      borderRadius: BorderRadius.circular(12),
                                      border: Border.all(
                                        color:
                                            AppColors.glassBorder.withAlpha(50),
                                        width: 1,
                                      ),
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Key Activities:',
                                          style:
                                              AppTypography.labelMedium(context)
                                                  .copyWith(
                                            color: Color(phase.color),
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        const SizedBox(
                                            height: AppSpacing.paddingSmall),
                                        ...phase.details.map((detail) =>
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  bottom:
                                                      AppSpacing.paddingSmall),
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Container(
                                                    width: 6,
                                                    height: 6,
                                                    margin:
                                                        const EdgeInsets.only(
                                                            top: 8,
                                                            right: AppSpacing
                                                                .paddingSmall),
                                                    decoration: BoxDecoration(
                                                      color: Color(phase.color),
                                                      shape: BoxShape.circle,
                                                    ),
                                                  ),
                                                  Expanded(
                                                    child: Text(
                                                      detail,
                                                      style: AppTypography
                                                          .bodyMedium(context),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            )),
                                      ],
                                    ),
                                  ),
                                ],
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ));
  }

  Widget _buildCallToAction(BuildContext context) {
    return Column(
      children: [
        Text(
          AppStrings.approachCTATitle,
          style: AppTypography.headingMedium(context),
        ),
        const SizedBox(height: AppSpacing.paddingMedium),
        Text(
          AppStrings.approachCTADescription,
          style: AppTypography.bodyLarge(context),
          textAlign: TextAlign.center,
        ),
      ],
    )
        .animate()
        .fadeIn(delay: AppAnimations.delaySlow)
        .slideY(begin: 0.2, end: 0);
  }
}
