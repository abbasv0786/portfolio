import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import '../constants/colors.dart';
import '../constants/animations.dart';
import '../constants/spacing.dart';
import '../constants/strings.dart';
import '../constants/typography.dart';
import '../constants/profile.dart';
import '../controllers/about_controller.dart';
import '../widgets/glassmorphism_container.dart';

class ProfileSection extends StatelessWidget {
  const ProfileSection({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AboutController>();
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < 768;

    return Container(
      padding: AppSpacing.getSectionPadding(context),
      child: _buildProfileCard(context, controller, isMobile),
    );
  }

  Widget _buildProfileCard(
      BuildContext context, AboutController controller, bool isMobile) {
    final imageWidth = isMobile
        ? ProfileConstants.profileImageWidthMobile
        : ProfileConstants.profileImageWidthDesktop;
    final imageHeight = isMobile
        ? ProfileConstants.profileImageHeightMobile
        : ProfileConstants.profileImageHeightDesktop;

    return GetBuilder<AboutController>(
      builder: (controller) => MouseRegion(
        cursor: SystemMouseCursors.click,
        onEnter: (_) => controller.setProfileHovered(true),
        onExit: (_) => controller.setProfileHovered(false),
        child: AnimatedGlassmorphismContainer(
          padding: const EdgeInsets.all(AppSpacing.paddingLarge),
          borderRadius:
              BorderRadius.circular(ProfileConstants.profileCardBorderRadius),
          enableHoverEffect: true,
          child: isMobile
              ? _buildMobileLayout(context, controller, imageWidth, imageHeight)
              : _buildDesktopLayout(
                  context, controller, imageWidth, imageHeight),
        ),
      ),
    )
        .animate()
        .fadeIn(delay: AppAnimations.delayNormal)
        .scale(begin: const Offset(0.8, 0.8), end: const Offset(1, 1));
  }

  Widget _buildMobileLayout(BuildContext context, AboutController controller,
      double imageWidth, double imageHeight) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Profile Image
        _buildProfileImage(context, controller, imageWidth, imageHeight),

        const SizedBox(height: ProfileConstants.profileImageTextSpacing),

        // Profile Text
        _buildProfileTextMobile(context),
      ],
    );
  }

  Widget _buildDesktopLayout(BuildContext context, AboutController controller,
      double imageWidth, double imageHeight) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Profile Text
        Expanded(
          child: _buildProfileText(context),
        ),

        const SizedBox(width: ProfileConstants.profileContentSpacing),

        // Profile Image
        _buildProfileImage(context, controller, imageWidth, imageHeight),
      ],
    );
  }

  Widget _buildProfileImage(BuildContext context, AboutController controller,
      double imageWidth, double imageHeight) {
    return Container(
      width: imageWidth,
      height: imageHeight,
      decoration: BoxDecoration(
        gradient: AppColors.glassGradient,
        borderRadius:
            BorderRadius.circular(ProfileConstants.profileImageBorderRadius),
        border: Border.all(
          color: controller.isProfileHovered.value
              ? AppColors.primary
              : AppColors.glassBorder,
          width: controller.isProfileHovered.value ? 2 : 1,
        ),
        boxShadow: controller.isProfileHovered.value
            ? AppColors.glassShadowIntense
            : AppColors.glassShadowLight,
      ),
      child: ClipRRect(
        borderRadius:
            BorderRadius.circular(ProfileConstants.profileImageBorderRadius),
        child: Stack(
          children: [
            // Background gradient
            Container(
              decoration: BoxDecoration(
                gradient: AppColors.glassGradient,
                borderRadius: BorderRadius.circular(
                    ProfileConstants.profileImageBorderRadius),
              ),
            ),
            // Profile image
            Center(
              child: Image.asset(
                ProfileConstants.profileImagePath,
                fit: BoxFit.contain,
                width: imageWidth,
                height: imageHeight,
                errorBuilder: (context, error, stackTrace) {
                  return Icon(
                    Icons.person,
                    size: imageWidth * 0.4,
                    color: AppColors.textPrimary.withAlpha(200),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileText(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppStrings.aboutName,
          style: AppTypography.headingLarge(context).copyWith(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: ProfileConstants.profileTextSpacing),
        Text(
          AppStrings.aboutRole,
          style: AppTypography.headingMedium(context).copyWith(
            color: AppColors.secondary,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: ProfileConstants.profileTextSpacing),
        Text(
          AppStrings.aboutBio,
          style: AppTypography.bodyLarge(context).copyWith(
            color: AppColors.textSecondary,
            height: 1.6,
          ),
        ),
        const SizedBox(height: ProfileConstants.profileTextSpacing),
        Text(
          AppStrings.aboutDescription,
          style: AppTypography.bodyMedium(context).copyWith(
            color: AppColors.textSecondary,
            height: 1.5,
          ),
        ),
      ],
    );
  }

  Widget _buildProfileTextMobile(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          AppStrings.aboutName,
          style: AppTypography.headingLarge(context).copyWith(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: ProfileConstants.profileTextSpacing),
        Text(
          AppStrings.aboutRole,
          style: AppTypography.headingMedium(context).copyWith(
            color: AppColors.secondary,
            fontWeight: FontWeight.w600,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: ProfileConstants.profileTextSpacing),
        Text(
          AppStrings.aboutBio,
          style: AppTypography.bodyLarge(context).copyWith(
            color: AppColors.textSecondary,
            height: 1.6,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: ProfileConstants.profileTextSpacing),
        Text(
          AppStrings.aboutDescription,
          style: AppTypography.bodyMedium(context).copyWith(
            color: AppColors.textSecondary,
            height: 1.5,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
