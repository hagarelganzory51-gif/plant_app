import 'package:flutter/material.dart';

import '../theme/plant_dimensions.dart';

class BottomNavigationPainter extends CustomPainter {
  BottomNavigationPainter({this.color = Colors.white});

  final Color color;

  static Path leftLobe() => Path()
    ..moveTo(0, 636)
    ..cubicTo(24, 664, 60, 668, 60, 692)
    ..cubicTo(60, 716, 26, 728, 0, 744)
    ..close();

  static Path rightLobe() {
    const double w = PlantDimensions.phoneWidth;
    return Path()
      ..moveTo(w, 636)
      ..cubicTo(w - 24, 664, w - 60, 668, w - 60, 692)
      ..cubicTo(w - 60, 716, w - 26, 728, w, 744)
      ..close();
  }

  static Path bagTab() {
    const double c = PlantDimensions.phoneWidth / 2;
    const double b = PlantDimensions.phoneHeight;
    return Path()
      ..moveTo(c - 68, b)
      ..cubicTo(c - 36, b, c - 32, 778, c, 778)
      ..cubicTo(c + 32, 778, c + 36, b, c + 68, b)
      ..close();
  }

  @override
  void paint(Canvas canvas, Size size) {
    canvas.save();
    canvas.scale(size.width / PlantDimensions.phoneWidth, size.height / PlantDimensions.phoneHeight);
    final paint = Paint()..color = color..isAntiAlias = true;
    canvas.drawPath(leftLobe(), paint);
    canvas.drawPath(rightLobe(), paint);
    canvas.drawPath(bagTab(), paint);
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant BottomNavigationPainter old) => old.color != color;
}
