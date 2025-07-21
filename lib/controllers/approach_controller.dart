import 'package:get/get.dart';
import 'package:portfolio/constants/strings.dart';
import '../data/portfolio_data.dart';
import '../models/approach_phase.dart';

class ApproachController extends GetxController {
  // Hover states
  final RxInt hoveredIndex = (-1).obs;

  // Animation states
  final RxBool showContent = false.obs;

  // Timeline animation
  final RxDouble timelineProgress = 0.0.obs;

  // Approach phases data from PortfolioData with additional details
  final RxList<ApproachPhase> approachPhases = PortfolioData.approachPhasesData
      .map((phase) {
        final index = PortfolioData.approachPhasesData.indexOf(phase);
        return ApproachPhase(
          id: index,
          title: phase['title'] ?? '',
          description: phase['description'] ?? '',
          icon: phase['icon'] ?? '',
          duration: phase['duration'] ?? '',
          details: _getPhaseDetails(phase['title'] ?? ''),
          color: _getPhaseColor(index),
        );
      })
      .toList()
      .obs;

  // Get phase-specific details
  static List<String> _getPhaseDetails(String title) {
    switch (title) {
      case AppStrings.approachPhase1Title:
        return [
          'Requirements gathering and analysis',
          'Project scope definition',
          'Technology stack selection',
          'Timeline and milestone planning',
          'Risk assessment and mitigation',
        ];
      case AppStrings.approachPhase2Title:
        return [
          'Agile development methodology',
          'Code review and quality assurance',
          'Regular progress updates',
          'Performance optimization',
          'Security implementation',
        ];
      case AppStrings.approachPhase3Title:
        return [
          'Production environment setup',
          'Deployment automation',
          'Monitoring and analytics',
          'User training and documentation',
          'Post-launch support and maintenance',
        ];
      default:
        return [];
    }
  }

  // Get phase color based on index
  static int _getPhaseColor(int index) {
    const colors = [0xFF64FFDA, 0xFF7B68EE, 0xFFFF6B6B, 0xFF4ECDC4];
    return colors[index % colors.length];
  }

  // Methods
  void setCardHovered(int index, bool value) {
    hoveredIndex.value = value ? index : -1;
    update();
  }

  void toggleCardExpanded(int index) {
    // This logic needs to be updated to use the new ApproachPhase model
    // For now, we'll just update the state
    approachPhases[index].isExpanded.value =
        !(approachPhases[index].isExpanded.value);
    update();
  }

  bool isCardHovered(int index) {
    return hoveredIndex.value == index;
  }

  bool isCardExpanded(int index) {
    return approachPhases[index].isExpanded.value;
  }

  @override
  void onInit() {
    super.onInit();
    // Initialize hover and expanded states
    for (var i = 0; i < approachPhases.length; i++) {
      // This logic needs to be updated to use the new ApproachPhase model
      // For now, we'll just update the state
      approachPhases[i].isExpanded.value = false; // Start collapsed
    }
  }
}
