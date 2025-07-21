import 'package:flutter/material.dart';
import 'package:portfolio/data/portfolio_data.dart';
import '../constants/colors.dart';
import '../constants/strings.dart';
import '../widgets/enhanced_footer.dart';
import '../widgets/navigation_bar.dart';
import '../widgets/hero_section.dart';
import '../widgets/about_section.dart';
import '../widgets/projects_section.dart';
import '../widgets/experience_section.dart';
import '../widgets/approach_section.dart';
import '../widgets/contact_section.dart';
import '../widgets/scroll_to_top_button.dart';
import '../services/section_visibility_service.dart';
import '../widgets/section_title_tracker.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _scrollController = ScrollController();
  int _currentSection = -1; // Start with Home selected

  // GlobalKeys for each section
  final GlobalKey _heroKey = GlobalKey();
  final GlobalKey _aboutKey = GlobalKey();
  final GlobalKey _projectsKey = GlobalKey();
  final GlobalKey _experienceKey = GlobalKey();
  final GlobalKey _approachKey = GlobalKey();
  final GlobalKey _contactKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    SectionVisibilityService.clearSections();
    super.dispose();
  }

  void _onScroll() {
    // Use the visibility service to determine which section is currently visible
    final visibleSection = SectionVisibilityService.getVisibleSection(context);

    if (visibleSection != null) {
      final sectionIndex =
          SectionVisibilityService.getSectionIndex(visibleSection);
      if (sectionIndex != -1 && sectionIndex != _currentSection) {
        setState(() {
          _currentSection = sectionIndex;
        });
      }
    } else {
      // If no section is visible, check if we're at the top (Home)
      final scrollPosition = _scrollController.position.pixels;
      if (scrollPosition < 100 && _currentSection != -1) {
        setState(() {
          _currentSection = -1; // Home
        });
      }
    }
  }

  void _onSectionChanged(int index) {
    setState(() {
      _currentSection = index;
    });

    // Scroll to the appropriate section
    _scrollToSection(index);
  }

  void _scrollToSection(int sectionIndex) {
    if (sectionIndex == -1) {
      // Home button - scroll to top
      _scrollController.animateTo(
        0,
        duration: const Duration(milliseconds: 800),
        curve: Curves.easeInOut,
      );
      return;
    }

    // Get the section ID and key from the visibility service
    final sectionId = SectionVisibilityService.getSectionId(sectionIndex);
    if (sectionId == null) return;

    final sections = SectionVisibilityService.getRegisteredSections();
    final targetKey = sections[sectionId];

    if (targetKey != null && targetKey.currentContext != null) {
      // Temporarily disable scroll listener to prevent interference
      _scrollController.removeListener(_onScroll);

      // Use Scrollable.ensureVisible for more reliable scrolling
      Scrollable.ensureVisible(
        targetKey.currentContext!,
        duration: const Duration(milliseconds: 800),
        curve: Curves.easeInOut,
        alignment: 0.0, // Align to top
      ).then((_) {
        // Re-enable scroll listener after animation completes
        Future.delayed(const Duration(milliseconds: 100), () {
          _scrollController.addListener(_onScroll);
        });
      });
    }
  }

  void _scrollToAbout() {
    _scrollToSection(0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      drawer: PortfolioDrawer(
        currentSection: _currentSection,
        onSectionChanged: _onSectionChanged,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: AppColors.heroGradient,
        ),
        child: Column(
          children: [
            // Fixed Navigation Bar
            PortfolioNavigationBar(
              currentSection: _currentSection,
              onSectionChanged: _onSectionChanged,
              isVisible: true,
            ),

            // Scrollable Content
            Expanded(
              child: SingleChildScrollView(
                controller: _scrollController,
                child: Column(
                  children: [
                    // Hero Section
                    HeroSection(
                      key: _heroKey,
                      name: AppStrings.heroName,
                      title: AppStrings.heroTitle,
                      subtitle: AppStrings.heroSubtitle,
                      description: AppStrings.heroDescription,
                      onScrollDownPressed: _scrollToAbout,
                      onContactPressed: () => _scrollToSection(4),
                    ),

                    // About Section
                    SectionTitleTracker(
                      sectionId: 'about',
                      title: 'About',
                      sectionKey: _aboutKey,
                      child: AboutSection(key: _aboutKey),
                    ),

                    // Projects Section
                    SectionTitleTracker(
                      sectionId: 'projects',
                      title: 'Projects',
                      sectionKey: _projectsKey,
                      child: ProjectsSection(key: _projectsKey),
                    ),

                    // Experience Section
                    SectionTitleTracker(
                      sectionId: 'experience',
                      title: 'Experience',
                      sectionKey: _experienceKey,
                      child: ExperienceSection(key: _experienceKey),
                    ),

                    // Approach Section
                    SectionTitleTracker(
                      sectionId: 'approach',
                      title: 'Approach',
                      sectionKey: _approachKey,
                      child: ApproachSection(key: _approachKey),
                    ),

                    // Contact Section
                    SectionTitleTracker(
                      sectionId: 'contact',
                      title: 'Contact',
                      sectionKey: _contactKey,
                      child: ContactSection(key: _contactKey),
                    ),

                    // Footer
                    const EnhancedFooter(
                      email: PortfolioData.email,
                      whatsapp: PortfolioData.whatsapp,
                      discord: PortfolioData.discord,
                      telegram: PortfolioData.telegram,
                      linkedin: PortfolioData.linkedin,
                      twitter: PortfolioData.twitter,
                      instagram: PortfolioData.instagram,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: ScrollToTopButton(
        scrollController: _scrollController,
        showThreshold: 300,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
