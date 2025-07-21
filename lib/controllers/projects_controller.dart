import 'package:get/get.dart';
import '../data/portfolio_data.dart';

class ProjectsController extends GetxController {
  // Hover states for each project
  final RxMap<String, bool> projectHoverStates = <String, bool>{}.obs;
  final RxMap<String, bool> projectPressedStates = <String, bool>{}.obs;

  // Selected project for detail view
  final Rx<int?> selectedProjectIndex = Rx<int?>(null);

  // Filter states
  final RxString selectedFilter = 'All'.obs;
  final RxList<String> filters = [
    'All',
    'iOS',
    'Flutter',
    'Cordova',
    'React Native',
    'AI/ML',
  ].obs;

  // Animation states
  final RxBool isAnimating = false.obs;
  final RxDouble animationProgress = 0.0.obs;

  // Using PortfolioData projects instead of duplicating
  get projects => PortfolioData.projects;

  // Filtered projects
  List get filteredProjects {
    if (selectedFilter.value == 'All') {
      return projects;
    }
    return projects
        .where((project) =>
            project.category.toLowerCase() ==
            selectedFilter.value.toLowerCase())
        .toList();
  }

  // Methods
  void setProjectHovered(String projectId, bool value) {
    projectHoverStates[projectId] = value;
    update();
  }

  void setProjectPressed(String projectId, bool value) {
    projectPressedStates[projectId] = value;
    update();
  }

  void selectProject(int? index) {
    selectedProjectIndex.value = index;
    update();
  }

  void setFilter(String filter) {
    selectedFilter.value = filter;
    update();
    _animateFilterChange();
  }

  void _animateFilterChange() async {
    isAnimating.value = true;
    update();

    // Fade out
    for (double i = 1.0; i >= 0.0; i -= 0.1) {
      animationProgress.value = i;
      update();
      await Future.delayed(const Duration(milliseconds: 20));
    }

    // Fade in
    for (double i = 0.0; i <= 1.0; i += 0.1) {
      animationProgress.value = i;
      update();
      await Future.delayed(const Duration(milliseconds: 20));
    }

    isAnimating.value = false;
    update();
  }

  bool isProjectHovered(String projectId) {
    return projectHoverStates[projectId] ?? false;
  }

  bool isProjectPressed(String projectId) {
    return projectPressedStates[projectId] ?? false;
  }

  @override
  void onInit() {
    super.onInit();
    // Initialize hover states
    for (var project in projects) {
      projectHoverStates[project.title] = false;
      projectPressedStates[project.title] = false;
    }
  }
}
