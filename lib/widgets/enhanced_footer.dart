import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:portfolio/constants/typography.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:portfolio/data/portfolio_data.dart';
import '../constants/colors.dart';
import '../constants/animations.dart';
import '../constants/strings.dart';
import '../controllers/app_controller.dart';

class EnhancedFooter extends StatelessWidget {
  final String email;
  final String whatsapp;
  final String discord;
  final String telegram;
  final String linkedin;
  final String twitter;
  final String instagram;

  const EnhancedFooter({
    super.key,
    required this.email,
    required this.whatsapp,
    required this.discord,
    required this.telegram,
    required this.linkedin,
    required this.twitter,
    required this.instagram,
  });

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 768;

    return GetBuilder<AppController>(
        builder: (controller) => AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              decoration: BoxDecoration(
                color: AppColors.background
                    .withValues(alpha: controller.footerOpacity.value),
                border: Border(
                  top: BorderSide(
                    color: AppColors.glassBorder.withValues(alpha: 0.3),
                    width: 1,
                  ),
                ),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.shadowColor.withValues(alpha: 0.1),
                    blurRadius: 20,
                    spreadRadius: 0,
                    offset: const Offset(0, -2),
                  ),
                ],
              ),
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: isMobile ? 16 : 60,
                  vertical: 40,
                ),
                child: Column(
                  children: [
                    // Main Footer Content
                    isMobile
                        ? _buildMobileLayout(controller)
                        : _buildDesktopLayout(controller),
                    const SizedBox(height: 40),

                    // Divider
                    Container(
                      height: 1,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.transparent,
                            AppColors.glassBorder.withValues(alpha: 0.5),
                            Colors.transparent,
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Copyright Section
                    _buildCopyrightSection(context),
                  ],
                ),
              ),
            ).animate().fadeIn(
                  duration: AppAnimations.verySlow,
                  delay: AppAnimations.delaySlow,
                ));
  }

  Widget _buildMobileLayout(AppController controller) {
    return Column(
      children: [
        // Contact Info
        _buildContactSection(controller),
        const SizedBox(height: 32),

        // Social Links
        _buildSocialSection(controller),
      ],
    );
  }

  Widget _buildDesktopLayout(AppController controller) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Contact Info
        Expanded(
          flex: 2,
          child: _buildContactSection(controller),
        ),
        const SizedBox(width: 60),

        // Social Links
        Expanded(
          flex: 1,
          child: _buildSocialSection(controller),
        ),
      ],
    );
  }

  Widget _buildContactSection(AppController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Logo and Name
        Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                gradient: AppColors.textGradient,
                borderRadius: BorderRadius.circular(24),
                border: Border.all(
                  color: AppColors.glassBorder,
                  width: 2,
                ),
              ),
              child: const Icon(
                Icons.code,
                color: AppColors.textPrimary,
                size: 24,
              ),
            ),
            const SizedBox(width: 16),
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppStrings.aboutName,
                    style: TextStyle(
                      color: AppColors.textPrimary,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    AppStrings.aboutRole,
                    style: TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 24),

        // Contact Info
        _buildContactItem(Icons.email, email, 'Email', controller),
        const SizedBox(height: 12),
        _buildContactItem(Icons.location_on, 'India', 'Location', controller),
        const SizedBox(height: 12),
        _buildContactItem(
            Icons.work, 'Available for opportunities', 'Status', controller),
      ],
    );
  }

  Widget _buildContactItem(
      IconData icon, String text, String label, AppController controller) {
    return MouseRegion(
      onEnter: (_) => controller.setHoverState('contact_$label', true),
      onExit: (_) => controller.setHoverState('contact_$label', false),
      child: GestureDetector(
        onTap: () {
          if (label == 'Email') {
            _launchUrl('mailto:$text');
          }
        },
        child: GetBuilder<AppController>(
            builder: (controller) => AnimatedContainer(
                  duration: AppAnimations.hoverDuration,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  decoration: BoxDecoration(
                    gradient: controller.hoverStates['contact_$label'] == true
                        ? AppColors.glassGradient
                        : null,
                    color: controller.hoverStates['contact_$label'] == true
                        ? null
                        : AppColors.glassPrimary.withValues(alpha: 0.3),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: controller.hoverStates['contact_$label'] == true
                          ? AppColors.primary
                          : AppColors.glassBorder,
                      width: controller.hoverStates['contact_$label'] == true
                          ? 2
                          : 1,
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        icon,
                        color: controller.hoverStates['contact_$label'] == true
                            ? AppColors.primary
                            : AppColors.textSecondary,
                        size: 20,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              text,
                              style: TextStyle(
                                color:
                                    controller.hoverStates['contact_$label'] ==
                                            true
                                        ? AppColors.primary
                                        : AppColors.textPrimary,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            Text(
                              label,
                              style: const TextStyle(
                                color: AppColors.textSecondary,
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )),
      ),
    );
  }

  Widget _buildSocialSection(AppController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Connect',
          style: TextStyle(
            color: AppColors.textPrimary,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 20),

        // Social Media Icons
        Wrap(
          spacing: 12,
          runSpacing: 12,
          alignment: WrapAlignment.center,
          runAlignment: WrapAlignment.center,
          children: [
            _buildSocialIcon(
                FontAwesomeIcons.whatsapp, 'WhatsApp', whatsapp, controller),
            _buildSocialIcon(
                FontAwesomeIcons.discord, 'Discord', discord, controller),
            _buildSocialIcon(
                FontAwesomeIcons.telegram, 'Telegram', telegram, controller),
            _buildSocialIcon(
                FontAwesomeIcons.linkedin, 'LinkedIn', linkedin, controller),
            _buildSocialIcon(
                FontAwesomeIcons.twitter, 'Twitter', twitter, controller),
            _buildSocialIcon(
                FontAwesomeIcons.instagram, 'Instagram', instagram, controller),
          ],
        ),
      ],
    );
  }

  Widget _buildSocialIcon(
      IconData icon, String platform, String url, AppController controller) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => controller.setSocialHoverState(platform, true),
      onExit: (_) => controller.setSocialHoverState(platform, false),
      child: GestureDetector(
        onTap: () {
          _launchUrl(_getPlatformUrl(platform, url));
        },
        child: GetBuilder<AppController>(
            builder: (controller) => AnimatedContainer(
                  duration: AppAnimations.hoverDuration,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    gradient: controller.socialHoverStates[platform] == true
                        ? AppColors.glassGradient
                        : null,
                    color: controller.socialHoverStates[platform] == true
                        ? null
                        : AppColors.glassPrimary.withValues(alpha: 0.3),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: controller.socialHoverStates[platform] == true
                          ? AppColors.primary
                          : AppColors.glassBorder,
                      width: controller.socialHoverStates[platform] == true
                          ? 2
                          : 1,
                    ),
                    boxShadow: controller.socialHoverStates[platform] == true
                        ? [
                            BoxShadow(
                              color:
                                  AppColors.shadowColor.withValues(alpha: 0.3),
                              blurRadius: 10,
                              spreadRadius: 0,
                            ),
                          ]
                        : null,
                  ),
                  child: Column(
                    children: [
                      FaIcon(
                        icon,
                        color: controller.socialHoverStates[platform] == true
                            ? AppColors.primary
                            : AppColors.textSecondary,
                        size: 24,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        platform,
                        style: TextStyle(
                          color: controller.socialHoverStates[platform] == true
                              ? AppColors.primary
                              : AppColors.textSecondary,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                )),
      ),
    );
  }

  Future<void> _launchUrl(String url) async {
    try {
      final Uri uri = Uri.parse(url);
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      } else {
        // Show error message if URL cannot be launched
        if (Get.context != null) {
          ScaffoldMessenger.of(Get.context!).showSnackBar(
            SnackBar(
              content: Text('Could not open $url'),
              backgroundColor: AppColors.error,
              duration: const Duration(seconds: 2),
            ),
          );
        }
      }
    } catch (e) {
      // Show error message if URL parsing fails
      if (Get.context != null) {
        ScaffoldMessenger.of(Get.context!).showSnackBar(
          SnackBar(
            content: Text('Error opening link: $e'),
            backgroundColor: AppColors.error,
            duration: const Duration(seconds: 2),
          ),
        );
      }
    }
  }

  String _getPlatformUrl(String platform, String value) {
    switch (platform.toLowerCase()) {
      case 'whatsapp':
        return 'https://wa.me/${value.replaceAll(RegExp(r'[^\d]'), '')}';
      case 'discord':
        return 'https://discord.com/users/${value.replaceAll('#', '')}';
      case 'telegram':
        return 'https://t.me/${value.replaceAll('@', '')}';
      case 'linkedin':
      case 'twitter':
      case 'instagram':
        return value;
      default:
        return value;
    }
  }

  Widget _buildCopyrightSection(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 768;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: isMobile
          ? Column(
              children: [
                const Text(
                  PortfolioData.footerCopyright,
                  style: TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                Text(
                  AppStrings.splashCrafted,
                  style: AppTypography.bodyMedium(context).copyWith(
                    color: AppColors.textSecondary.withValues(alpha: 0.7),
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ],
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Flexible(
                  child: Text(
                    PortfolioData.footerCopyright,
                    style: TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(width: 16),
                Flexible(
                  child: Text(
                    AppStrings.splashCrafted,
                    style: AppTypography.bodyMedium(context).copyWith(
                      color: AppColors.textSecondary.withValues(alpha: 0.7),
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
