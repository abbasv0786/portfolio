import 'package:get/get.dart';
import '../models/project.dart';
import '../services/firestore_service.dart';

class ProjectsController extends GetxController {
  // Hover and pressed states for each project
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
    'React Native',
    'AI/ML',
  ].obs;

  // Animation states
  final RxBool isAnimating = false.obs;
  final RxDouble animationProgress = 0.0.obs;

  // Reactive access to projects from FirestoreService
  List<Project> get projects {
    if (Get.isRegistered<FirestoreService>()) {
      final list = FirestoreService.to.projects;
      if (list.isNotEmpty) return list;
    }
    return [];
  }

  // Filtered projects
  List<Project> get filteredProjects {
    final all = projects;
    if (selectedFilter.value == 'All') {
      return all;
    }
    return all
        .where((project) =>
            (project.category ?? '').toLowerCase() ==
            selectedFilter.value.toLowerCase())
        .toList();
  }

  // Methods
  void setProjectHovered(String projectId, bool value) {
    projectHoverStates[projectId] = value;
  }

  void setProjectPressed(String projectId, bool value) {
    projectPressedStates[projectId] = value;
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
    // AnimatedOpacity interpolates between these, so only 3 rebuilds needed
    isAnimating.value = true;
    animationProgress.value = 0.0;
    update();
    await Future.delayed(const Duration(milliseconds: 150));

    animationProgress.value = 1.0;
    update();
    await Future.delayed(const Duration(milliseconds: 250));

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
    // Reactively update filters and hover states when projects change in Firestore
    if (Get.isRegistered<FirestoreService>()) {
      ever(FirestoreService.to.projects, (List<Project> projectList) {
        _syncDynamicFilters(projectList);
        for (var project in projectList) {
          projectHoverStates[project.title] = false;
          projectPressedStates[project.title] = false;
        }
        update();
      });
      _syncDynamicFilters(FirestoreService.to.projects);
    }
  }

  void _syncDynamicFilters(List<Project> projectList) {
    final categories = <String>{'All'};
    for (var p in projectList) {
      if (p.category != null && p.category!.trim().isNotEmpty) {
        categories.add(p.category!.trim());
      }
    }
    filters.assignAll(categories.toList());
  }
}
