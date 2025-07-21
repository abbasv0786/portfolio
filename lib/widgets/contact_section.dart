import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../constants/animations.dart';
import '../constants/spacing.dart';
import '../constants/strings.dart';
import '../constants/typography.dart';

class ContactSection extends StatelessWidget {
  const ContactSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: AppSpacing.getSectionPadding(context),
      child: Column(
        children: [
          // Section Header
          _buildSectionHeader(context),

          SizedBox(height: AppSpacing.getComponentSpacing(context) * 2),

          // Contact Info
          _buildContactInfo(context),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context) {
    return Column(
      children: [
        Text(
          AppStrings.contactTitle,
          style: AppTypography.headingLarge(context),
        )
            .animate()
            .fadeIn(duration: AppAnimations.slow)
            .slideY(begin: 0.3, end: 0),
        const SizedBox(height: AppSpacing.paddingMedium),
        Text(
          AppStrings.contactSubtitle,
          style: AppTypography.bodyLarge(context),
          textAlign: TextAlign.center,
        )
            .animate()
            .fadeIn(delay: AppAnimations.delayNormal)
            .slideY(begin: 0.2, end: 0),
      ],
    );
  }

  Widget _buildContactInfo(BuildContext context) {
    return Column(
      children: [
        Text(
          AppStrings.contactCTATitle,
          style: AppTypography.headingMedium(context),
        ),
        const SizedBox(height: AppSpacing.paddingMedium),
        Text(
          AppStrings.contactCTADescription,
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
