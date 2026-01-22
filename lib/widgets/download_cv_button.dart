import 'package:flutter/material.dart';
import '../constants/colors.dart';
import '../services/cv_service.dart';

class DownloadCvButton extends StatelessWidget {
  const DownloadCvButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => CvService.generateAndDownloadCv(),
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppColors.primary, width: 2),
            boxShadow: [
              BoxShadow(
                color: AppColors.primary.withValues(alpha: 0.1),
                blurRadius: 8,
                spreadRadius: 0,
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'CV',
                style: TextStyle(
                  color: AppColors.primary,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const SizedBox(width: 8),
              CustomPaint(
                size: const Size(20, 20),
                painter: _DownloadIconPainter(color: AppColors.primary),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DownloadIconPainter extends CustomPainter {
  final Color color;

  _DownloadIconPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final path = Path();

    // Draw arrow
    path.moveTo(size.width * 0.5, size.height * 0.2); // Top center
    path.lineTo(size.width * 0.5, size.height * 0.65); // Bottom center

    // Arrowhead
    path.moveTo(size.width * 0.3, size.height * 0.45);
    path.lineTo(size.width * 0.5, size.height * 0.65);
    path.lineTo(size.width * 0.7, size.height * 0.45);

    // Draw tray/bracket
    path.moveTo(size.width * 0.2, size.height * 0.6);
    path.lineTo(size.width * 0.2, size.height * 0.8);
    path.lineTo(size.width * 0.8, size.height * 0.8);
    path.lineTo(size.width * 0.8, size.height * 0.6);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
