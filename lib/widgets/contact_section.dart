import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:get/get.dart';
import '../constants/animations.dart';
import '../constants/colors.dart';
import '../constants/spacing.dart';
import '../constants/strings.dart';
import '../constants/typography.dart';
import '../data/portfolio_data.dart';
import '../services/firestore_service.dart';

class ContactSection extends StatelessWidget {
  const ContactSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 768;

    return Container(
      padding: AppSpacing.getSectionPadding(context),
      child: Column(
        children: [
          // Section Header
          _buildSectionHeader(context),

          SizedBox(height: AppSpacing.getComponentSpacing(context) * 2),

          // Contact Cards Grid
          _buildContactCards(context, isMobile),

          SizedBox(height: AppSpacing.getComponentSpacing(context) * 2),

          // CTA
          _buildContactCTA(context),
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

  Widget _buildContactCards(BuildContext context, bool isMobile) {
    return Obx(() {
      final profile = Get.isRegistered<FirestoreService>()
          ? FirestoreService.to.profileInfo.value
          : null;

      final email = (profile?.email.isNotEmpty == true) ? profile!.email : PortfolioData.email;
      final phone = (profile?.phone.isNotEmpty == true) ? profile!.phone : PortfolioData.phone;
      final whatsapp = (profile?.whatsapp.isNotEmpty == true) ? profile!.whatsapp : PortfolioData.whatsapp;
      final linkedin = (profile?.linkedin.isNotEmpty == true) ? profile!.linkedin : PortfolioData.linkedin;
      final discord = (profile?.discord.isNotEmpty == true) ? profile!.discord : PortfolioData.discord;
      final telegram = (profile?.telegram.isNotEmpty == true) ? profile!.telegram : PortfolioData.telegram;
      final location = (profile?.location.isNotEmpty == true) ? profile!.location : 'India (Remote, Worldwide)';
      final availability = (profile?.availability.isNotEmpty == true) ? profile!.availability : 'Available for Opportunities';

      final contactItems = [
        _ContactItem(
          materialIcon: Icons.email_outlined,
          title: 'Email',
          value: email,
          action: 'mailto:$email',
          copyable: true,
        ),
        _ContactItem(
          materialIcon: Icons.phone_outlined,
          title: 'Phone',
          value: phone,
          action: 'tel:$phone',
          copyable: true,
        ),
        _ContactItem(
          faIcon: FontAwesomeIcons.whatsapp,
          title: 'WhatsApp',
          value: whatsapp,
          action: 'https://wa.me/${whatsapp.replaceAll(RegExp(r'[^\d]'), '')}',
          copyable: false,
        ),
        _ContactItem(
          faIcon: FontAwesomeIcons.linkedin,
          title: 'LinkedIn',
          value: 'ahemadabbas-vagh',
          action: linkedin,
          copyable: false,
        ),
        _ContactItem(
          faIcon: FontAwesomeIcons.discord,
          title: 'Discord',
          value: discord,
          action: 'https://discord.com/users/$discord',
          copyable: true,
        ),
        _ContactItem(
          faIcon: FontAwesomeIcons.telegram,
          title: 'Telegram',
          value: telegram,
          action: 'https://t.me/${telegram.replaceAll('@', '')}',
          copyable: false,
        ),
        _ContactItem(
          materialIcon: Icons.location_on_outlined,
          title: 'Location',
          value: location,
          action: '',
          copyable: false,
        ),
        _ContactItem(
          materialIcon: Icons.work_outline,
          title: 'Status',
          value: availability,
          action: '',
          copyable: false,
        ),
      ];

      return Wrap(
        spacing: AppSpacing.paddingMedium,
        runSpacing: AppSpacing.paddingMedium,
        alignment: WrapAlignment.center,
        children: contactItems.asMap().entries.map((entry) {
          final index = entry.key;
          final item = entry.value;
          return SizedBox(
            width: isMobile
                ? double.infinity
                : MediaQuery.of(context).size.width > 1200
                    ? 280
                    : 260,
            child: _ContactCard(item: item),
          )
              .animate()
              .fadeIn(delay: Duration(milliseconds: 100 + index * 80))
              .slideY(begin: 0.15, end: 0);
        }).toList(),
      );
    });
  }

  Widget _buildContactCTA(BuildContext context) {
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

class _ContactItem {
  final IconData? materialIcon;
  final FaIconData? faIcon;
  final String title;
  final String value;
  final String action;
  final bool copyable;

  const _ContactItem({
    this.materialIcon,
    this.faIcon,
    required this.title,
    required this.value,
    required this.action,
    required this.copyable,
  });
}

class _ContactCard extends StatefulWidget {
  final _ContactItem item;

  const _ContactCard({required this.item});

  @override
  State<_ContactCard> createState() => _ContactCardState();
}

class _ContactCardState extends State<_ContactCard> {
  bool _isHovered = false;
  bool _showCopied = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: widget.item.action.isNotEmpty
          ? SystemMouseCursors.click
          : SystemMouseCursors.basic,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: () => _handleTap(),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: _isHovered ? AppColors.glassGradient : null,
            color: _isHovered
                ? null
                : AppColors.glassPrimary.withValues(alpha: 0.3),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color:
                  _isHovered ? AppColors.primary : AppColors.glassBorder,
              width: _isHovered ? 2 : 1,
            ),
            boxShadow: _isHovered
                ? [
                    BoxShadow(
                      color: AppColors.primary.withValues(alpha: 0.15),
                      blurRadius: 15,
                      spreadRadius: 0,
                    ),
                  ]
                : null,
          ),
          child: Row(
            children: [
              // Icon
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      AppColors.primary.withValues(alpha: 0.2),
                      AppColors.secondary.withValues(alpha: 0.2),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: _buildIcon(),
                ),
              ),
              const SizedBox(width: 14),

              // Text
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.item.title,
                      style: const TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      _showCopied ? 'Copied!' : widget.item.value,
                      style: TextStyle(
                        color: _showCopied
                            ? AppColors.primary
                            : _isHovered
                                ? AppColors.primary
                                : AppColors.textPrimary,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),

              // Copy / Link icon
              if (widget.item.copyable)
                Icon(
                  Icons.copy_outlined,
                  color: _isHovered
                      ? AppColors.primary
                      : AppColors.textSecondary.withValues(alpha: 0.5),
                  size: 16,
                )
              else if (widget.item.action.isNotEmpty)
                Icon(
                  Icons.open_in_new,
                  color: _isHovered
                      ? AppColors.primary
                      : AppColors.textSecondary.withValues(alpha: 0.5),
                  size: 16,
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildIcon() {
    final color = _isHovered ? AppColors.primary : AppColors.textSecondary;

    if (widget.item.materialIcon != null) {
      return Icon(
        widget.item.materialIcon,
        color: color,
        size: 22,
      );
    } else if (widget.item.faIcon != null) {
      return FaIcon(
        widget.item.faIcon!,
        color: color,
        size: 20,
      );
    }
    return const SizedBox.shrink();
  }

  void _handleTap() async {
    if (widget.item.copyable) {
      await Clipboard.setData(ClipboardData(text: widget.item.value));
      setState(() => _showCopied = true);
      Future.delayed(const Duration(seconds: 2), () {
        if (mounted) setState(() => _showCopied = false);
      });
      if (widget.item.action.isNotEmpty) {
        _launchUrl(widget.item.action);
      }
    } else if (widget.item.action.isNotEmpty) {
      _launchUrl(widget.item.action);
    }
  }

  Future<void> _launchUrl(String url) async {
    try {
      final Uri uri = Uri.parse(url);
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      }
    } catch (e) {
      debugPrint('Error launching URL: $e');
    }
  }
}
