import 'package:flutter/material.dart';

class AppSpacing {
  // Prevent instantiation
  AppSpacing._();

  // Section spacing
  static const double sectionSpacingWeb = 40.0;
  static const double sectionSpacingMobile = 20.0;
  static const double sectionSpacingTablet = 30.0;

  // Component spacing
  static const double componentSpacingWeb = 40.0;
  static const double componentSpacingMobile = 20.0;
  static const double componentSpacingTablet = 30.0;

  // Padding values
  static const double paddingXSmall = 4.0;
  static const double paddingSmall = 8.0;
  static const double paddingMedium = 16.0;
  static const double paddingLarge = 24.0;
  static const double paddingXLarge = 32.0;
  static const double paddingXXLarge = 48.0;
  static const double paddingHuge = 60.0;
  static const double paddingMassive = 120.0;

  // Content padding
  static const double contentPaddingWeb = 120.0;
  static const double contentPaddingTablet = 48.0;
  static const double contentPaddingMobile = 16.0;

  // Card spacing
  static const double cardSpacing = 16.0;
  static const double cardPaddingWeb = 24.0;
  static const double cardPaddingMobile = 16.0;

  // Grid spacing
  static const double gridSpacingWeb = 32.0;
  static const double gridSpacingMobile = 16.0;
  static const double gridSpacingTablet = 24.0;

  // Icon spacing
  static const double iconSpacing = 12.0;
  static const double iconSize = 24.0;
  static const double iconSizeSmall = 16.0;
  static const double iconSizeLarge = 32.0;

  // Helper methods
  static EdgeInsets getHorizontalPadding(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width < 768) {
      return const EdgeInsets.symmetric(horizontal: contentPaddingMobile);
    } else if (width < 1024) {
      return const EdgeInsets.symmetric(horizontal: contentPaddingTablet);
    } else {
      return const EdgeInsets.symmetric(horizontal: contentPaddingWeb);
    }
  }

  static EdgeInsets getSectionPadding(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width < 768) {
      return const EdgeInsets.symmetric(
        horizontal: contentPaddingMobile,
        vertical: sectionSpacingMobile,
      );
    } else if (width < 1024) {
      return const EdgeInsets.symmetric(
        horizontal: contentPaddingTablet,
        vertical: sectionSpacingTablet,
      );
    } else {
      return const EdgeInsets.symmetric(
        horizontal: contentPaddingWeb,
        vertical: sectionSpacingWeb,
      );
    }
  }

  static double getSectionSpacing(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width < 768) {
      return sectionSpacingMobile;
    } else if (width < 1024) {
      return sectionSpacingTablet;
    } else {
      return sectionSpacingWeb;
    }
  }

  static double getComponentSpacing(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width < 768) {
      return componentSpacingMobile;
    } else if (width < 1024) {
      return componentSpacingTablet;
    } else {
      return componentSpacingWeb;
    }
  }

  static double getCardPadding(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return width < 768 ? cardPaddingMobile : cardPaddingWeb;
  }

  static double getGridSpacing(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width < 768) {
      return gridSpacingMobile;
    } else if (width < 1024) {
      return gridSpacingTablet;
    } else {
      return gridSpacingWeb;
    }
  }
}
