import 'package:flutter/material.dart';

class AppAnimations {
  // Prevent instantiation
  AppAnimations._();

  // Duration constants
  static const Duration veryFast = Duration(milliseconds: 150);
  static const Duration fast = Duration(milliseconds: 300);
  static const Duration normal = Duration(milliseconds: 500);
  static const Duration slow = Duration(milliseconds: 800);
  static const Duration verySlow = Duration(milliseconds: 1200);

  // Delay constants
  static const Duration delayFast = Duration(milliseconds: 100);
  static const Duration delayNormal = Duration(milliseconds: 200);
  static const Duration delaySlow = Duration(milliseconds: 400);
  static const Duration delayVerySlow = Duration(milliseconds: 600);

  // Hover animation duration
  static const Duration hoverDuration = Duration(milliseconds: 200);

  // Card animation duration
  static const Duration cardAnimationDuration = Duration(milliseconds: 600);

  // Card expand duration
  static const Duration cardExpandDuration = Duration(milliseconds: 400);

  // Typing animation speed
  static const Duration typingSpeed = Duration(milliseconds: 100);

  // Particle animation duration
  static const Duration particleAnimationDuration =
      Duration(milliseconds: 3000);

  // Scroll animation duration
  static const Duration scrollAnimationDuration = Duration(milliseconds: 800);

  // Form animation duration
  static const Duration formAnimationDuration = Duration(milliseconds: 400);

  // Loading animation duration
  static const Duration loadingAnimationDuration = Duration(milliseconds: 1500);

  // Success/Error animation duration
  static const Duration feedbackAnimationDuration = Duration(milliseconds: 300);

  // Navigation animation duration
  static const Duration navigationAnimationDuration =
      Duration(milliseconds: 250);

  // Stagger animation delays
  static const List<Duration> staggerDelays = [
    Duration(milliseconds: 0),
    Duration(milliseconds: 100),
    Duration(milliseconds: 200),
    Duration(milliseconds: 300),
    Duration(milliseconds: 400),
  ];

  // Curves
  static const Curve easeInOut = Curves.easeInOut;
  static const Curve easeOut = Curves.easeOut;
  static const Curve easeIn = Curves.easeIn;
  static const Curve elasticOut = Curves.elasticOut;
  static const Curve bounceOut = Curves.bounceOut;
  static const Curve fastOutSlowIn = Curves.fastOutSlowIn;
}
