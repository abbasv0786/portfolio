import 'package:flutter/material.dart';

class SectionVisibilityService {
  // Prevent instantiation
  SectionVisibilityService._();

  // Track section keys and their titles
  static final Map<String, GlobalKey> _sectionKeys = {};
  static final Map<String, String> _sectionTitles = {};

  // Register a section with its key and title
  static void registerSection(String sectionId, GlobalKey key, String title) {
    _sectionKeys[sectionId] = key;
    _sectionTitles[sectionId] = title;
  }

  // Get the currently visible section based on title visibility
  static String? getVisibleSection(BuildContext context) {
    final RenderBox? renderBox = context.findRenderObject() as RenderBox?;
    if (renderBox == null) return null;

    final viewportHeight = MediaQuery.of(context).size.height;
    final viewportCenter = viewportHeight / 2;

    String? mostVisibleSection;
    double maxVisibility = 0.0;

    for (final entry in _sectionKeys.entries) {
      final sectionId = entry.key;
      final key = entry.value;

      if (key.currentContext == null) continue;

      final sectionRenderBox =
          key.currentContext!.findRenderObject() as RenderBox?;
      if (sectionRenderBox == null) continue;

      final sectionPosition = sectionRenderBox.localToGlobal(Offset.zero);
      final sectionHeight = sectionRenderBox.size.height;

      // Calculate how much of the section is visible in the viewport
      final sectionTop = sectionPosition.dy;
      final sectionBottom = sectionTop + sectionHeight;

      // Calculate intersection with viewport
      final visibleTop = sectionTop.clamp(0.0, viewportHeight);
      final visibleBottom = sectionBottom.clamp(0.0, viewportHeight);
      final visibleHeight = visibleBottom - visibleTop;

      if (visibleHeight > 0) {
        // Calculate visibility score based on how centered the section is
        final sectionCenter = sectionTop + (sectionHeight / 2);
        final distanceFromCenter = (sectionCenter - viewportCenter).abs();
        final visibilityScore = visibleHeight /
            sectionHeight *
            (1 - distanceFromCenter / viewportHeight);

        if (visibilityScore > maxVisibility) {
          maxVisibility = visibilityScore;
          mostVisibleSection = sectionId;
        }
      }
    }

    return mostVisibleSection;
  }

  // Get all registered sections
  static Map<String, GlobalKey> getRegisteredSections() {
    return Map.unmodifiable(_sectionKeys);
  }

  // Get section title
  static String? getSectionTitle(String sectionId) {
    return _sectionTitles[sectionId];
  }

  // Clear all registered sections
  static void clearSections() {
    _sectionKeys.clear();
    _sectionTitles.clear();
  }

  // Check if a section is currently visible
  static bool isSectionVisible(String sectionId, BuildContext context) {
    final visibleSection = getVisibleSection(context);
    return visibleSection == sectionId;
  }

  // Get the section index based on section ID
  static int getSectionIndex(String sectionId) {
    final sections = _sectionKeys.keys.toList();
    return sections.indexOf(sectionId);
  }

  // Get section ID by index
  static String? getSectionId(int index) {
    final sections = _sectionKeys.keys.toList();
    if (index >= 0 && index < sections.length) {
      return sections[index];
    }
    return null;
  }
}
