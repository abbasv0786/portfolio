import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:portfolio/constants/strings.dart';

class HeroSectionController extends GetxController
    with GetTickerProviderStateMixin {
  // Animation controllers
  late AnimationController floatingAnimationController;
  late AnimationController pulseAnimationController;

  // Animations
  late Animation<double> floatingAnimation;
  late Animation<double> pulseAnimation;

  // Reactive states
  final RxBool isShareWorkHovered = false.obs;
  final RxBool isEmailHovered = false.obs;
  final RxBool isScrollDownHovered = false.obs;
  final RxDouble parallaxOffset = 0.0.obs;
  final RxDouble mouseX = 0.0.obs;
  final RxDouble mouseY = 0.0.obs;

  // Typing animation
  final RxString currentTypingText = ''.obs;
  final RxInt currentWordIndex = 0.obs;
  final RxBool isTyping = false.obs;
  bool _isDisposed = false;

  final List<String> typingWords = AppStrings.heroTypingWords;

  @override
  void onInit() {
    super.onInit();
    _initializeAnimations();
    _startTypingAnimation();
  }

  void _initializeAnimations() {
    // Floating animation
    floatingAnimationController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..repeat(reverse: true);

    floatingAnimation = Tween<double>(
      begin: -10.0,
      end: 10.0,
    ).animate(CurvedAnimation(
      parent: floatingAnimationController,
      curve: Curves.easeInOut,
    ));

    // Pulse animation
    pulseAnimationController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat();

    pulseAnimation = Tween<double>(
      begin: 1.0,
      end: 1.2,
    ).animate(CurvedAnimation(
      parent: pulseAnimationController,
      curve: Curves.easeInOut,
    ));
  }

  void _startTypingAnimation() async {
    while (!_isDisposed) {
      final word = typingWords[currentWordIndex.value];

      // Typing effect
      if (_isDisposed) break;
      isTyping.value = true;
      update();
      for (int i = 0; i <= word.length; i++) {
        if (_isDisposed) break;
        currentTypingText.value = word.substring(0, i);
        update();
        await Future.delayed(const Duration(milliseconds: 100));
      }

      // Hold the complete word
      if (_isDisposed) break;
      await Future.delayed(const Duration(seconds: 2));

      // Backspace effect
      for (int i = word.length; i >= 0; i--) {
        if (_isDisposed) break;
        currentTypingText.value = word.substring(0, i);
        update();
        await Future.delayed(const Duration(milliseconds: 50));
      }

      if (_isDisposed) break;
      isTyping.value = false;
      update();
      await Future.delayed(const Duration(milliseconds: 500));

      // Move to next word
      if (_isDisposed) break;
      currentWordIndex.value =
          (currentWordIndex.value + 1) % typingWords.length;
    }
  }

  void updateMousePosition(double x, double y) {
    if (_isDisposed) return;
    mouseX.value = x;
    mouseY.value = y;
    update();
  }

  void updateParallaxOffset(double offset) {
    if (_isDisposed) return;
    parallaxOffset.value = offset;
    update();
  }

  void setShareWorkHovered(bool value) {
    if (_isDisposed) return;
    isShareWorkHovered.value = value;
    update();
  }

  void setEmailHovered(bool value) {
    if (_isDisposed) return;
    isEmailHovered.value = value;
    update();
  }

  void setScrollDownHovered(bool value) {
    if (_isDisposed) return;
    isScrollDownHovered.value = value;
    update();
  }

  @override
  void onClose() {
    _isDisposed = true;
    floatingAnimationController.dispose();
    pulseAnimationController.dispose();
    super.onClose();
  }
}
