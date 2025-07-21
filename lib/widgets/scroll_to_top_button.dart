import 'package:flutter/material.dart';
import '../constants/colors.dart';
import '../constants/animations.dart';

class ScrollToTopButton extends StatefulWidget {
  final ScrollController scrollController;
  final double showThreshold;

  const ScrollToTopButton({
    super.key,
    required this.scrollController,
    this.showThreshold = 300,
  });

  @override
  State<ScrollToTopButton> createState() => _ScrollToTopButtonState();
}

class _ScrollToTopButtonState extends State<ScrollToTopButton> {
  bool _isVisible = false;

  @override
  void initState() {
    super.initState();
    widget.scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    widget.scrollController.removeListener(_onScroll);
    super.dispose();
  }

  void _onScroll() {
    final shouldShow = widget.scrollController.offset > widget.showThreshold;
    if (shouldShow != _isVisible) {
      setState(() {
        _isVisible = shouldShow;
      });
    }
  }

  void _scrollToTop() {
    widget.scrollController.animateTo(
      0,
      duration: AppAnimations.scrollAnimationDuration,
      curve: AppAnimations.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: _isVisible ? 1.0 : 0.0,
      duration: AppAnimations.normal,
      child: Container(
        width: 56,
        height: 56,
        decoration: BoxDecoration(
          color: AppColors.primary.withValues(alpha: 0.9),
          borderRadius: BorderRadius.circular(28),
          boxShadow: const [
            BoxShadow(
              color: AppColors.shadowColor,
              blurRadius: 10,
              offset: Offset(0, 5),
            ),
          ],
        ),
        child: IconButton(
          onPressed: _isVisible ? _scrollToTop : null,
          icon: const Icon(
            Icons.keyboard_arrow_up,
            color: AppColors.textPrimary,
            size: 24,
          ),
        ),
      ),
    );
  }
}

class FloatingActionButton extends StatelessWidget {
  final VoidCallback onPressed;
  final IconData icon;
  final String? tooltip;
  final Color? backgroundColor;
  final Color? foregroundColor;

  const FloatingActionButton({
    super.key,
    required this.onPressed,
    required this.icon,
    this.tooltip,
    this.backgroundColor,
    this.foregroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 56,
      height: 56,
      decoration: BoxDecoration(
        color: (backgroundColor ?? AppColors.primary).withValues(alpha: 0.9),
        borderRadius: BorderRadius.circular(28),
        boxShadow: const [
          BoxShadow(
            color: AppColors.shadowColor,
            blurRadius: 10,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: IconButton(
        onPressed: onPressed,
        icon: Icon(
          icon,
          color: foregroundColor ?? AppColors.textPrimary,
          size: 24,
        ),
        tooltip: tooltip,
      ),
    );
  }
}
