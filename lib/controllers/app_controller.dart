import 'package:get/get.dart';

class AppController extends GetxController {
  // Navigation state
  final RxInt currentSection = 0.obs;
  final RxBool isMenuOpen = false.obs;
  final RxBool isScrolling = false.obs;

  // Hover states for different components
  final RxMap<String, bool> hoverStates = <String, bool>{}.obs;
  final RxMap<String, bool> pressedStates = <String, bool>{}.obs;

  // Header and footer states
  final RxBool isHeaderVisible = true.obs;
  final RxBool isFooterVisible = true.obs;
  final RxDouble headerOpacity = 1.0.obs;
  final RxDouble footerOpacity = 1.0.obs;

  // Social media hover states
  final RxMap<String, bool> socialHoverStates = <String, bool>{}.obs;

  // Removed duplicate hover states - each section controller manages its own state

  // Methods to update hover states
  void setHoverState(String key, bool value) {
    hoverStates[key] = value;
    update();
  }

  void setPressedState(String key, bool value) {
    pressedStates[key] = value;
    update();
  }

  void setSocialHoverState(String platform, bool value) {
    socialHoverStates[platform] = value;
    update();
  }

  // Removed duplicate hover state methods - each section controller manages its own state

  // Navigation methods
  void setCurrentSection(int section) {
    currentSection.value = section;
    update();
  }

  void toggleMenu() {
    isMenuOpen.value = !isMenuOpen.value;
    update();
  }

  void closeMenu() {
    isMenuOpen.value = false;
    update();
  }

  // Header and footer visibility
  void setHeaderVisibility(bool visible) {
    isHeaderVisible.value = visible;
    headerOpacity.value = visible ? 1.0 : 0.0;
    update();
  }

  void setFooterVisibility(bool visible) {
    isFooterVisible.value = visible;
    footerOpacity.value = visible ? 1.0 : 0.0;
    update();
  }

  // Scroll state
  void setScrollingState(bool scrolling) {
    isScrolling.value = scrolling;
    update();
  }

  // Clear all hover states
  void clearAllHoverStates() {
    hoverStates.clear();
    pressedStates.clear();
    socialHoverStates.clear();
  }

  @override
  void onInit() {
    super.onInit();
    // Initialize default states
    setHoverState('default', false);
    setPressedState('default', false);
  }

  @override
  void onClose() {
    clearAllHoverStates();
    super.onClose();
  }
}
