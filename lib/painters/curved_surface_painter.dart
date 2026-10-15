import 'package:flutter/material.dart';

import '../theme/plant_dimensions.dart';

class CurvedSurfacePainter extends CustomPainter {
  CurvedSurfacePainter({this.color = Colors.white});

  final Color color;

  static Path buildPath() {
    const double w = PlantDimensions.phoneWidth;
    const double r = PlantDimensions.phoneRadius;
    return Path()
      ..moveTo(0, r)
      ..quadraticBezierTo(0, 0, r, 0)
      ..lineTo(w - r, 0)
      ..quadraticBezierTo(w, 0, w, r)
      ..lineTo(w, 500)
      ..cubicTo(w - 3, 585, w - 80, 655, w / 2, 655)
      ..cubicTo(80, 655, 3, 585, 0, 500)
      ..close();
  }

  @override
  void paint(Canvas canvas, Size size) {
    canvas.save();
    canvas.scale(size.width / PlantDimensions.phoneWidth, size.height / PlantDimensions.phoneHeight);
    final path = buildPath();
    canvas.drawPath(
      path.shift(const Offset(0, 4)),
      Paint()
        ..color = const Color(0x22000000)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 6),
    );
    canvas.drawPath(path, Paint()..color = color..isAntiAlias = true);
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant CurvedSurfacePainter old) => old.color != color;
}
