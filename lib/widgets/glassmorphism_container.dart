import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'dart:ui';
import '../constants/colors.dart';
import '../constants/animations.dart';

class AnimatedGlassmorphismContainer extends StatefulWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final double? width;
  final double? height;
  final BorderRadius? borderRadius;
  final Color? color;
  final LinearGradient? gradient;
  final Border? border;
  final List<BoxShadow>? boxShadow;
  final double blur;
  final double opacity;
  final bool enableHoverEffect;
  final double hoverScale;
  final Duration? animationDuration;
  final Duration? animationDelay;
  final bool enableAnimation;

  const AnimatedGlassmorphismContainer({
    super.key,
    required this.child,
    this.padding,
    this.margin,
    this.width,
    this.height,
    this.borderRadius,
    this.color,
    this.gradient,
    this.border,
    this.boxShadow,
    this.blur = 10.0,
    this.opacity = 0.1,
    this.enableHoverEffect = true,
    this.hoverScale = 1.05,
    this.animationDuration,
    this.animationDelay,
    this.enableAnimation = true,
  });

  @override
  State<AnimatedGlassmorphismContainer> createState() =>
      _AnimatedGlassmorphismContainerState();
}

class _AnimatedGlassmorphismContainerState
    extends State<AnimatedGlassmorphismContainer>
    with SingleTickerProviderStateMixin {
  late AnimationController _hoverAnimation;
  bool _isHovered = false;

  @override
  void initState() {
    super.initState();
    _hoverAnimation = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _hoverAnimation.dispose();
    super.dispose();
  }

  void _onHover(bool isHovered) {
    if (widget.enableHoverEffect) {
      setState(() {
        _isHovered = isHovered;
      });
      if (isHovered) {
        _hoverAnimation.forward();
      } else {
        _hoverAnimation.reverse();
      }
    }
  }

  Widget _buildGlassmorphismContainer() {
    return Container(
      width: widget.width,
      height: widget.height,
      margin: widget.margin,
      decoration: BoxDecoration(
        borderRadius: widget.borderRadius,
        border: widget.border ??
            Border.all(
              color: AppColors.glassBorder,
              width: 1,
            ),
        boxShadow: widget.boxShadow ??
            [
              BoxShadow(
                color: AppColors.glassShadow,
                blurRadius: widget.blur,
                spreadRadius: 0,
              ),
            ],
      ),
      child: ClipRRect(
        borderRadius: widget.borderRadius ?? BorderRadius.zero,
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: widget.blur, sigmaY: widget.blur),
          child: Container(
            padding: widget.padding,
            decoration: BoxDecoration(
              color: (widget.color ?? AppColors.glassPrimary)
                  .withValues(alpha: (widget.opacity * 255).round().toDouble()),
              gradient: widget.gradient ?? AppColors.glassGradient,
              borderRadius: widget.borderRadius,
            ),
            child: widget.child,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget container = _buildGlassmorphismContainer();

    // Apply hover effect if enabled
    if (widget.enableHoverEffect) {
      container = MouseRegion(
        onEnter: (_) => _onHover(true),
        onExit: (_) => _onHover(false),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          transform: Matrix4.identity()
            ..scale(_isHovered ? widget.hoverScale : 1.0),
          child: _buildGlassmorphismContainer(),
        ),
      );
    }

    // Apply entrance animation if enabled
    if (widget.enableAnimation) {
      return container
          .animate(
            delay: widget.animationDelay ?? AppAnimations.delayNormal,
          )
          .fadeIn(duration: widget.animationDuration ?? AppAnimations.normal)
          .slideY(
            begin: 0.2,
            end: 0,
            duration: widget.animationDuration ?? AppAnimations.normal,
          );
    }

    return container;
  }
}

class GlassmorphismContainer extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final double? width;
  final double? height;
  final BorderRadius? borderRadius;
  final Color? color;
  final LinearGradient? gradient;
  final Border? border;
  final List<BoxShadow>? boxShadow;
  final double blur;
  final double opacity;

  const GlassmorphismContainer({
    super.key,
    required this.child,
    this.padding,
    this.margin,
    this.width,
    this.height,
    this.borderRadius,
    this.color,
    this.gradient,
    this.border,
    this.boxShadow,
    this.blur = 10.0,
    this.opacity = 0.1,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      margin: margin,
      child: ClipRRect(
        borderRadius: borderRadius ?? BorderRadius.circular(20),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
          child: Container(
            decoration: BoxDecoration(
              color: color ??
                  AppColors.glassBackground.withAlpha((opacity * 255).round()),
              gradient: gradient ?? AppColors.glassGradient,
              borderRadius: borderRadius ?? BorderRadius.circular(20),
              border: border ??
                  Border.all(
                    color: AppColors.glassBorder,
                    width: 1.5,
                  ),
              boxShadow: boxShadow ?? AppColors.glassShadowEffects,
            ),
            padding: padding,
            child: child,
          ),
        ),
      ),
    );
  }
}
