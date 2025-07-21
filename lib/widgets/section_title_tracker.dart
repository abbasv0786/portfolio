import 'package:flutter/material.dart';
import '../services/section_visibility_service.dart';

class SectionTitleTracker extends StatefulWidget {
  final String sectionId;
  final String title;
  final Widget child;
  final GlobalKey sectionKey;

  const SectionTitleTracker({
    super.key,
    required this.sectionId,
    required this.title,
    required this.child,
    required this.sectionKey,
  });

  @override
  State<SectionTitleTracker> createState() => _SectionTitleTrackerState();
}

class _SectionTitleTrackerState extends State<SectionTitleTracker> {
  @override
  void initState() {
    super.initState();
    // Register this section with the visibility service
    SectionVisibilityService.registerSection(
      widget.sectionId,
      widget.sectionKey,
      widget.title,
    );
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
