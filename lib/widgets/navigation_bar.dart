import 'package:flutter/material.dart';
import '../constants/colors.dart';
import '../constants/strings.dart';
import '../constants/dimensions.dart';
import '../constants/icons.dart';
import '../constants/profile.dart';

class PortfolioNavigationBar extends StatefulWidget {
  final int currentSection;
  final Function(int) onSectionChanged;
  final bool isVisible;

  const PortfolioNavigationBar({
    super.key,
    required this.currentSection,
    required this.onSectionChanged,
    required this.isVisible,
  });

  @override
  State<PortfolioNavigationBar> createState() => _PortfolioNavigationBarState();
}

class _PortfolioNavigationBarState extends State<PortfolioNavigationBar> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isMobile = size.width < AppDimensions.mobileBreakpoint;

    return Container(
      width: double.infinity,
      height: isMobile
          ? AppDimensions.navBarHeightMobile
          : AppDimensions.navBarHeightDesktop,
      decoration: BoxDecoration(
        color: AppColors.background.withValues(alpha: 0.9),
        border: const Border(
          bottom: BorderSide(
            color: AppColors.glassBorder,
            width: AppDimensions.buttonBorderWidth,
          ),
        ),
      ),
      child: Row(
        children: [
          // Logo/Brand section
          Container(
            width: isMobile
                ? AppDimensions.navBarLogoWidthMobile
                : AppDimensions.navBarLogoWidthDesktop,
            padding: EdgeInsets.symmetric(horizontal: isMobile ? 16 : 20),
            child: const Text(
              AppStrings.splashInitials,
              style: TextStyle(
                color: AppColors.textPrimary,
                fontSize: AppDimensions.navBarLogoFontSize,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          // Spacer to push navigation to the right
          const Expanded(child: SizedBox()),

          // Desktop Navigation
          if (!isMobile) _buildDesktopNav(),

          // Mobile menu button - positioned on the right
          if (isMobile)
            Container(
              margin: const EdgeInsets.only(
                  right: AppDimensions.navBarMenuButtonMargin),
              child: _buildMobileMenuButton(),
            ),
        ],
      ),
    );
  }

  Widget _buildDesktopNav() {
    final size = MediaQuery.of(context).size;
    final isTablet = size.width >= 768 && size.width < 1024;
    final isSmallDesktop = size.width >= 1024 && size.width < 1200;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: isTablet ? 16 : 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          _buildNavItem(AppStrings.navHome, -1,
              AppIcons.navHome), // -1 for home (scroll to top)
          SizedBox(width: isTablet ? 16 : (isSmallDesktop ? 20 : 30)),
          _buildNavItem(AppStrings.navAbout, 0, AppIcons.navAbout),
          SizedBox(width: isTablet ? 16 : (isSmallDesktop ? 20 : 30)),
          _buildNavItem(AppStrings.navProjects, 1, AppIcons.navProjects),
          SizedBox(width: isTablet ? 16 : (isSmallDesktop ? 20 : 30)),
          _buildNavItem(AppStrings.navExperience, 2, AppIcons.navExperience),
          SizedBox(width: isTablet ? 16 : (isSmallDesktop ? 20 : 30)),
          _buildNavItem(AppStrings.navApproach, 3, AppIcons.navApproach),
          SizedBox(width: isTablet ? 16 : (isSmallDesktop ? 20 : 30)),
          _buildNavItem(AppStrings.navContact, 4, AppIcons.navContact),
        ],
      ),
    );
  }

  Widget _buildMobileMenuButton() {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.glassPrimary,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: AppColors.glassBorder,
          width: 1,
        ),
      ),
      child: IconButton(
        onPressed: () {
          try {
            // Try to open drawer using Scaffold.of(context)
            final scaffold = Scaffold.of(context);
            if (scaffold.hasDrawer) {
              scaffold.openDrawer();
            }
          } catch (e) {
            // Fallback: try to find the nearest Scaffold
            try {
              final scaffold = Scaffold.maybeOf(context);
              if (scaffold != null && scaffold.hasDrawer) {
                scaffold.openDrawer();
              }
            } catch (e) {
              // If all else fails, show a snackbar
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Navigation menu is not available'),
                  duration: Duration(seconds: 2),
                ),
              );
            }
          }
        },
        icon: const Icon(
          AppIcons.navMenu,
          color: AppColors.textPrimary,
          size: AppDimensions.iconSizeMedium,
        ),
      ),
    );
  }

  Widget _buildNavItem(String title, int sectionIndex, IconData icon) {
    final isActive = widget.currentSection == sectionIndex;
    final size = MediaQuery.of(context).size;
    final isTablet = size.width >= 768 && size.width < 1024;
    final isSmallDesktop = size.width >= 1024 && size.width < 1200;

    return GestureDetector(
      onTap: () {
        widget.onSectionChanged(sectionIndex);
      },
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: isTablet ? 10 : (isSmallDesktop ? 12 : 16),
          vertical: 8,
        ),
        decoration: BoxDecoration(
          color: isActive ? AppColors.glassPrimary : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isActive ? AppColors.primary : Colors.transparent,
            width: 1,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: isActive ? AppColors.primary : AppColors.textSecondary,
              size: isTablet ? 14 : (isSmallDesktop ? 15 : 16),
            ),
            SizedBox(width: isTablet ? 4 : (isSmallDesktop ? 6 : 8)),
            Text(
              title,
              style: TextStyle(
                color: isActive ? AppColors.primary : AppColors.textSecondary,
                fontSize: isTablet ? 11 : (isSmallDesktop ? 12 : 14),
                fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PortfolioDrawer extends StatelessWidget {
  final int currentSection;
  final Function(int) onSectionChanged;

  const PortfolioDrawer({
    super.key,
    required this.currentSection,
    required this.onSectionChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: AppColors.background,
      child: Container(
        decoration: const BoxDecoration(
          gradient: AppColors.heroGradient,
        ),
        child: Column(
          children: [
            // Drawer header
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                color: AppColors.glassPrimary,
                border: Border(
                  bottom: BorderSide(
                    color: AppColors.glassBorder,
                    width: 1,
                  ),
                ),
              ),
              child: Column(
                children: [
                  // Profile image
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(40),
                      border: Border.all(
                        color: AppColors.glassBorder,
                        width: 2,
                      ),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(40),
                      child: Image.asset(
                        ProfileConstants.profileImagePath,
                        fit: BoxFit.contain,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            decoration: BoxDecoration(
                              gradient: AppColors.glassGradient,
                              borderRadius: BorderRadius.circular(40),
                            ),
                            child: const Icon(
                              Icons.person,
                              color: AppColors.textPrimary,
                              size: 40,
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Name
                  const Text(
                    AppStrings.aboutName,
                    style: TextStyle(
                      color: AppColors.textPrimary,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  // Title
                  const Text(
                    AppStrings.aboutRole,
                    style: TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),

            // Navigation items
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    _buildMobileNavItem(AppStrings.navHome, -1,
                        AppIcons.navHome), // -1 for home (scroll to top)
                    const SizedBox(height: 16),
                    _buildMobileNavItem(
                        AppStrings.navAbout, 0, AppIcons.navAbout),
                    const SizedBox(height: 16),
                    _buildMobileNavItem(
                        AppStrings.navProjects, 1, AppIcons.navProjects),
                    const SizedBox(height: 16),
                    _buildMobileNavItem(
                        AppStrings.navExperience, 2, AppIcons.navExperience),
                    const SizedBox(height: 16),
                    _buildMobileNavItem(
                        AppStrings.navApproach, 3, AppIcons.navApproach),
                    const SizedBox(height: 16),
                    _buildMobileNavItem(
                        AppStrings.navContact, 4, AppIcons.navContact),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMobileNavItem(String title, int sectionIndex, IconData icon) {
    final isActive = currentSection == sectionIndex;

    return Builder(
      builder: (context) => GestureDetector(
        onTap: () {
          Navigator.pop(context); // Close drawer
          onSectionChanged(sectionIndex);
        },
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: isActive ? AppColors.glassPrimary : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: isActive ? AppColors.primary : Colors.transparent,
              width: 1,
            ),
          ),
          child: Row(
            children: [
              Icon(
                icon,
                color: isActive ? AppColors.primary : AppColors.textSecondary,
                size: 20,
              ),
              const SizedBox(width: 12),
              Text(
                title,
                style: TextStyle(
                  color: isActive ? AppColors.primary : AppColors.textSecondary,
                  fontSize: 16,
                  fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
