import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'dart:ui';
import '../constants/colors.dart';
import '../constants/animations.dart';

class GlassmorphismCard extends StatefulWidget {
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

  const GlassmorphismCard({
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
    this.enableHoverEffect = false,
    this.hoverScale = 1.05,
    this.animationDuration,
    this.animationDelay,
    this.enableAnimation = true,
  });

  @override
  State<GlassmorphismCard> createState() => _GlassmorphismCardState();
}

class _GlassmorphismCardState extends State<GlassmorphismCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _hoverController;
  late Animation<double> _hoverAnimation;
  final RxBool _isHovered = false.obs;

  @override
  void initState() {
    super.initState();
    _hoverController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _hoverAnimation = Tween<double>(
      begin: 1.0,
      end: widget.hoverScale,
    ).animate(CurvedAnimation(
      parent: _hoverController,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _hoverController.dispose();
    super.dispose();
  }

  void _onHover(bool isHovered) {
    if (widget.enableHoverEffect) {
      _isHovered.value = isHovered;
      if (isHovered) {
        _hoverController.forward();
      } else {
        _hoverController.reverse();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget card = Container(
      width: widget.width,
      height: widget.height,
      margin: widget.margin,
      child: ClipRRect(
        borderRadius: widget.borderRadius ?? BorderRadius.circular(20),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: widget.blur, sigmaY: widget.blur),
          child: Container(
            decoration: BoxDecoration(
              color: widget.color ??
                  AppColors.glassBackground
                      .withAlpha((widget.opacity * 255).round()),
              gradient: widget.gradient ?? AppColors.glassGradient,
              borderRadius: widget.borderRadius ?? BorderRadius.circular(20),
              border: widget.border ??
                  Border.all(
                    color: AppColors.glassBorder,
                    width: 1.5,
                  ),
              boxShadow: widget.boxShadow ?? AppColors.glassShadowEffects,
            ),
            padding: widget.padding,
            child: widget.child,
          ),
        ),
      ),
    );

    // Apply hover effect if enabled
    if (widget.enableHoverEffect) {
      card = AnimatedBuilder(
        animation: _hoverAnimation,
        builder: (context, child) {
          return Transform.scale(
            scale: _hoverAnimation.value,
            child: MouseRegion(
              onEnter: (_) => _onHover(true),
              onExit: (_) => _onHover(false),
              child: card,
            ),
          );
        },
      );
    }

    // Apply entrance animation if enabled
    if (widget.enableAnimation) {
      return card
          .animate(
            delay: widget.animationDelay ?? AppAnimations.delayNormal,
          )
          .fadeIn(
            duration: widget.animationDuration ?? AppAnimations.slow,
            curve: Curves.easeOutCubic,
          )
          .slideY(
            begin: 0.1,
            end: 0,
            duration: widget.animationDuration ?? AppAnimations.slow,
            curve: Curves.easeOutCubic,
          );
    }

    return card;
  }
}

class GlassmorphismButton extends StatefulWidget {
  final Widget child;
  final VoidCallback? onPressed;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final double? width;
  final double? height;
  final BorderRadius? borderRadius;
  final LinearGradient? gradient;
  final LinearGradient? hoverGradient;
  final Color? borderColor;
  final double? borderWidth;
  final bool enableAnimation;
  final Duration? animationDuration;
  final Curve? animationCurve;

  const GlassmorphismButton({
    super.key,
    required this.child,
    this.onPressed,
    this.padding,
    this.margin,
    this.width,
    this.height,
    this.borderRadius,
    this.gradient,
    this.hoverGradient,
    this.borderColor,
    this.borderWidth,
    this.enableAnimation = true,
    this.animationDuration,
    this.animationCurve,
  });

  @override
  State<GlassmorphismButton> createState() => _GlassmorphismButtonState();
}

class _GlassmorphismButtonState extends State<GlassmorphismButton>
    with SingleTickerProviderStateMixin {
  bool isPressed = false;
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: widget.animationDuration ?? const Duration(milliseconds: 200),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 0.95,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: widget.animationCurve ?? Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _onTapDown(TapDownDetails details) {
    setState(() {
      isPressed = true;
    });
    _animationController.forward();
  }

  void _onTapUp(TapUpDetails details) {
    setState(() {
      isPressed = false;
    });
    _animationController.reverse();
  }

  void _onTapCancel() {
    setState(() {
      isPressed = false;
    });
    _animationController.reverse();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onPressed,
      onTapDown: _onTapDown,
      onTapUp: _onTapUp,
      onTapCancel: _onTapCancel,
      child: AnimatedContainer(
        duration: widget.animationDuration ?? const Duration(milliseconds: 300),
        curve: widget.animationCurve ?? Curves.easeInOut,
        transform: Matrix4.identity()..scale(_scaleAnimation.value),
        width: widget.width,
        height: widget.height,
        margin: widget.margin,
        padding: widget.padding ??
            const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        decoration: BoxDecoration(
          gradient: isPressed
              ? (widget.hoverGradient ?? AppColors.buttonGradientHover)
              : (widget.gradient ?? AppColors.buttonGradient),
          borderRadius: widget.borderRadius ?? BorderRadius.circular(12),
          border: Border.all(
            color: widget.borderColor ?? AppColors.glassBorder,
            width: widget.borderWidth ?? 1,
          ),
          boxShadow: isPressed
              ? AppColors.glassShadowIntense
              : AppColors.glassShadowEffects,
        ),
        child: widget.enableAnimation
            ? widget.child.animate().fadeIn(
                  duration: widget.animationDuration ?? AppAnimations.fast,
                  delay: AppAnimations.delayFast,
                )
            : widget.child,
      ),
    );
  }
}

class GlassmorphismContainer extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final double? width;
  final double? height;
  final BorderRadius? borderRadius;
  final LinearGradient? gradient;
  final Color? borderColor;
  final double? borderWidth;
  final List<BoxShadow>? boxShadow;
  final bool enableAnimation;
  final Duration? animationDuration;
  final Curve? animationCurve;
  final Offset? animationOffset;

  const GlassmorphismContainer({
    super.key,
    required this.child,
    this.padding,
    this.margin,
    this.width,
    this.height,
    this.borderRadius,
    this.gradient,
    this.borderColor,
    this.borderWidth,
    this.boxShadow,
    this.enableAnimation = true,
    this.animationDuration,
    this.animationCurve,
    this.animationOffset,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      margin: margin,
      padding: padding,
      decoration: BoxDecoration(
        gradient: gradient ?? AppColors.glassGradient,
        borderRadius: borderRadius ?? BorderRadius.circular(16),
        border: Border.all(
          color: borderColor ?? AppColors.glassBorder,
          width: borderWidth ?? 1,
        ),
        boxShadow: boxShadow ?? AppColors.glassShadowLight,
      ),
      child: enableAnimation
          ? child
              .animate()
              .fadeIn(
                duration: animationDuration ?? AppAnimations.normal,
                delay: AppAnimations.delayFast,
              )
              .slideY(
                begin: animationOffset?.dy ?? 0.1,
                end: 0,
                duration: animationDuration ?? AppAnimations.normal,
                curve: animationCurve ?? Curves.easeOutCubic,
              )
          : child,
    );
  }
}
