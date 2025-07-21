import 'package:get/get.dart';
import '../data/portfolio_data.dart';

class ExperienceController extends GetxController {
  // Hover states for experience cards
  final RxMap<int, bool> cardHoverStates = <int, bool>{}.obs;

  // Pressed states for experience cards
  final RxMap<int, bool> cardPressedStates = <int, bool>{}.obs;

  // Selected experience index for detail view
  final Rx<int?> selectedExperienceIndex = Rx<int?>(null);

  // Animation states
  final RxBool isAnimating = false.obs;
  final RxDouble animationProgress = 0.0.obs;

  // Timeline animation
  final RxDouble timelineProgress = 0.0.obs;

  // Using PortfolioData experiences instead of duplicating
  get experiences => PortfolioData.experiences;

  // Methods
  void setCardHovered(int index, bool value) {
    cardHoverStates[index] = value;
    update();
  }

  void setCardPressed(int index, bool value) {
    cardPressedStates[index] = value;
    update();
  }

  void selectExperience(int? index) {
    selectedExperienceIndex.value = index;
    update();
    if (index != null) {
      _animateSelection();
    }
  }

  void _animateSelection() async {
    isAnimating.value = true;

    // Animate in
    for (double i = 0.0; i <= 1.0; i += 0.1) {
      animationProgress.value = i;
      await Future.delayed(const Duration(milliseconds: 20));
    }

    isAnimating.value = false;
  }

  void startTimelineAnimation() async {
    for (double i = 0.0; i <= 1.0; i += 0.02) {
      timelineProgress.value = i;
      await Future.delayed(const Duration(milliseconds: 30));
    }
  }

  bool isCardHovered(int index) {
    return cardHoverStates[index] ?? false;
  }

  bool isCardPressed(int index) {
    return cardPressedStates[index] ?? false;
  }

  @override
  void onInit() {
    super.onInit();
    // Initialize hover and pressed states
    for (var i = 0; i < experiences.length; i++) {
      cardHoverStates[i] = false;
      cardPressedStates[i] = false;
    }
    // Start timeline animation
    Future.delayed(const Duration(milliseconds: 500), () {
      startTimelineAnimation();
    });
  }
}
