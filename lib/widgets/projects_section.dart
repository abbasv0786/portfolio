import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:get/get.dart';
import '../constants/colors.dart';
import '../constants/animations.dart';
import '../constants/spacing.dart';
import '../constants/strings.dart';
import '../controllers/projects_controller.dart';
import '../models/project.dart';
import '../constants/typography.dart';
import '../widgets/glassmorphism_container.dart';
import 'section_header.dart';

class ProjectsSection extends StatelessWidget {
  const ProjectsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: AppSpacing.getSectionPadding(context),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Section Header
          const SectionHeader(
            title: AppStrings.projectsTitle,
            subtitle: AppStrings.projectsSubtitle,
          ),
          SizedBox(height: AppSpacing.getSectionSpacing(context)),

          // Filter Chips
          GetBuilder<ProjectsController>(
              builder: (controller) => LayoutBuilder(
                    builder: (context, constraints) {
                      final isMobile = constraints.maxWidth < 768;
                      return Center(
                        child: Wrap(
                          spacing: isMobile
                              ? AppSpacing.paddingSmall
                              : AppSpacing.paddingMedium,
                          runSpacing: AppSpacing.paddingSmall,
                          alignment: WrapAlignment.center,
                          children: controller.filters.map((filter) {
                            final isSelected =
                                controller.selectedFilter.value == filter;
                            return MouseRegion(
                              cursor: SystemMouseCursors.click,
                              child: InkWell(
                                onTap: () => controller.setFilter(filter),
                                child: AnimatedGlassmorphismContainer(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: isMobile
                                        ? AppSpacing.paddingMedium
                                        : AppSpacing.paddingLarge,
                                    vertical: AppSpacing.paddingMedium,
                                  ),
                                  borderRadius: BorderRadius.circular(30),
                                  enableHoverEffect: true,
                                  hoverScale: 1.05,
                                  child: Text(
                                    filter,
                                    style: TextStyle(
                                      color: isSelected
                                          ? AppColors.primary
                                          : AppColors.textSecondary,
                                      fontSize: isMobile ? 12 : 14,
                                      fontWeight: isSelected
                                          ? FontWeight.bold
                                          : FontWeight.normal,
                                    ),
                                  ),
                                ),
                              ),
                            ).animate().fadeIn(
                                  delay: Duration(
                                      milliseconds: 100 *
                                          controller.filters.indexOf(filter)),
                                  duration: AppAnimations.normal,
                                );
                          }).toList(),
                        ),
                      );
                    },
                  )),
          SizedBox(height: AppSpacing.getComponentSpacing(context)),

          // Projects Grid
          GetBuilder<ProjectsController>(
              builder: (controller) => AnimatedOpacity(
                    opacity: controller.isAnimating.value
                        ? controller.animationProgress.value
                        : 1.0,
                    duration: AppAnimations.hoverDuration,
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        final isMobile = constraints.maxWidth < 768;
                        final spacing = AppSpacing.getGridSpacing(context);

                        return Center(
                          child: Wrap(
                            spacing: spacing,
                            runSpacing: spacing,
                            alignment: WrapAlignment.center,
                            children: controller.filteredProjects
                                .asMap()
                                .entries
                                .map((entry) {
                              final index = entry.key;
                              final project = entry.value;
                              return SizedBox(
                                width: isMobile
                                    ? constraints.maxWidth - 40
                                    : (constraints.maxWidth > 1200 ? 400 : 320),
                                child: _ProjectCard(
                                  project: project,
                                  index: index,
                                ),
                              );
                            }).toList(),
                          ),
                        );
                      },
                    ),
                  )),
        ],
      ),
    );
  }
}

class _ProjectCard extends StatelessWidget {
  final Project project;
  final int index;

  const _ProjectCard({
    required this.project,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProjectsController>(builder: (controller) {
      return MouseRegion(
        onEnter: (_) => controller.setProjectHovered(project.title, true),
        onExit: (_) => controller.setProjectHovered(project.title, false),
        child: GestureDetector(
          onTapDown: (_) => controller.setProjectPressed(project.title, true),
          onTapUp: (_) => controller.setProjectPressed(project.title, false),
          onTapCancel: () => controller.setProjectPressed(project.title, false),
          child: AnimatedGlassmorphismContainer(
            enableHoverEffect: true,
            hoverScale: 1.02,
            borderRadius: BorderRadius.circular(16),
            padding: EdgeInsets.zero,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Project Image
                AspectRatio(
                  aspectRatio: 16 / 9,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(16),
                    ),
                    child: Stack(
                      children: [
                        project.imageUrl.isNotEmpty
                            ? Image.asset(
                                project.imageUrl,
                                width: double.infinity,
                                height: double.infinity,
                                fit: BoxFit.fill,
                              )
                            : Container(
                                color: AppColors.surface,
                                alignment: Alignment.center,
                                child: const Icon(
                                  Icons.image_not_supported,
                                  color: AppColors.textSecondary,
                                  size: 48,
                                ),
                              ),
                      ],
                    ),
                  ),
                ),
                // Project Info
                Padding(
                  padding: EdgeInsets.all(AppSpacing.getCardPadding(context)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Project Title
                      Text(
                        project.title,
                        style: AppTypography.headingMedium(context).copyWith(
                          color: AppColors.textPrimary,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: AppSpacing.paddingSmall),
                      Text(
                        project.description,
                        style: AppTypography.bodyMedium(context).copyWith(
                          color: AppColors.textSecondary,
                        ),
                        maxLines: 100,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: AppSpacing.paddingMedium),
                      // Technologies
                      Wrap(
                        spacing: AppSpacing.paddingSmall,
                        runSpacing: AppSpacing.paddingSmall,
                        children: project.technologies.map((tech) {
                          return Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.primary.withAlpha(30),
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: AppColors.primary.withAlpha(100),
                                width: 1,
                              ),
                            ),
                            child: Text(
                              tech,
                              style: AppTypography.tag(context).copyWith(
                                color: AppColors.primary,
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                      const SizedBox(height: AppSpacing.paddingMedium),

                      Wrap(
                        spacing: AppSpacing.paddingMedium,
                        runSpacing: AppSpacing.paddingMedium,
                        children: [
                          _buildButton(context,
                              url: project.iOSUrl ?? '', label: 'IOS'),
                          _buildButton(context,
                              url: project.androidUrl ?? '', label: 'Android'),
                          _buildButton(context,
                              url: project.liveUrl ?? '', label: 'Live'),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      )
          .animate()
          .fadeIn(
            duration: AppAnimations.cardAnimationDuration,
            delay: Duration(milliseconds: 100 * index),
          )
          .slideY(
            begin: 0.1,
            end: 0,
            duration: AppAnimations.cardAnimationDuration,
            delay: Duration(milliseconds: 100 * index),
          );
    });
  }

  Widget _buildButton(BuildContext context,
      {required String url, required String label}) {
    if (url.isNotEmpty) {
      return MouseRegion(
        cursor: SystemMouseCursors.click,
        child: InkWell(
          onTap: () async {
            final Uri uri = Uri.parse(url);
            if (await canLaunchUrl(uri)) {
              await launchUrl(uri);
            }
          },
          borderRadius: BorderRadius.circular(8),
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 8,
            ),
            decoration: BoxDecoration(
              border: Border.all(
                color: AppColors.primary,
                width: 1,
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.link,
                  size: 16,
                  color: AppColors.primary,
                ),
                const SizedBox(width: 8),
                Text(
                  label,
                  style: AppTypography.bodySmall(context).copyWith(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    return const SizedBox.shrink();
  }
}
