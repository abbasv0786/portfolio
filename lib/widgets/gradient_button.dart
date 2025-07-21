import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../constants/colors.dart';
import '../constants/animations.dart';
import '../constants/typography.dart';

class GradientButton extends StatefulWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final BorderRadius? borderRadius;
  final LinearGradient? gradient;
  final LinearGradient? hoverGradient;
  final Color? borderColor;
  final double? borderWidth;
  final bool enableAnimation;
  final Duration? animationDuration;
  final Curve? animationCurve;

  const GradientButton({
    super.key,
    required this.text,
    this.onPressed,
    this.isLoading = false,
    this.width,
    this.height,
    this.padding,
    this.margin,
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
  State<GradientButton> createState() => _GradientButtonState();
}

class _GradientButtonState extends State<GradientButton>
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
            ? widget.isLoading
                ? _buildLoadingIndicator()
                : Text(
                    widget.text,
                    style: AppTypography.button(context),
                    textAlign: TextAlign.center,
                  ).animate().fadeIn(
                      duration: widget.animationDuration ?? AppAnimations.fast,
                      delay: AppAnimations.delayFast,
                    )
            : widget.isLoading
                ? _buildLoadingIndicator()
                : Text(
                    widget.text,
                    style: AppTypography.button(context),
                    textAlign: TextAlign.center,
                  ),
      ),
    );
  }

  Widget _buildLoadingIndicator() {
    return const SizedBox(
      width: 20,
      height: 20,
      child: CircularProgressIndicator(
        strokeWidth: 2,
        valueColor: AlwaysStoppedAnimation<Color>(AppColors.textPrimary),
      ),
    );
  }
}

class GlassmorphismButton extends StatefulWidget {
  final Widget child;
  final VoidCallback? onPressed;
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final BorderRadius? borderRadius;
  final LinearGradient? gradient;
  final LinearGradient? hoverGradient;
  final Color? borderColor;
  final double? borderWidth;
  final List<BoxShadow>? boxShadow;
  final bool enableAnimation;
  final Duration? animationDuration;
  final Curve? animationCurve;

  const GlassmorphismButton({
    super.key,
    required this.child,
    this.onPressed,
    this.width,
    this.height,
    this.padding,
    this.margin,
    this.borderRadius,
    this.gradient,
    this.hoverGradient,
    this.borderColor,
    this.borderWidth,
    this.boxShadow,
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
        padding: widget.padding,
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
              : (widget.boxShadow ?? AppColors.glassShadowEffects),
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
