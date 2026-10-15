import 'package:flutter/material.dart';

import '../theme/plant_colors.dart';

class ActionTabPainter extends CustomPainter {
  ActionTabPainter({this.color = PlantColors.lightGreen});

  final Color color;

  static Path buildPath() {
    const double w = 52;
    return Path()
      ..moveTo(w, 0)
      ..cubicTo(w - 14, 0, w - 18, 8, w - 30, 8)
      ..lineTo(16, 8)
      ..arcToPoint(const Offset(16, 32), radius: const Radius.circular(12), clockwise: false)
      ..lineTo(w - 30, 32)
      ..cubicTo(w - 18, 32, w - 14, 40, w, 40)
      ..close();
  }

  @override
  void paint(Canvas canvas, Size size) {
    canvas.save();
    canvas.scale(size.width / 52, size.height / 40);
    canvas.drawPath(buildPath(), Paint()..color = color..isAntiAlias = true);
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant ActionTabPainter old) => old.color != color;
}
