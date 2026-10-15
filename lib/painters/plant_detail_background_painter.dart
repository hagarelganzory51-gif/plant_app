import 'package:flutter/material.dart';

import '../theme/plant_colors.dart';
import '../theme/plant_dimensions.dart';

class PlantDetailBackgroundPainter extends CustomPainter {
  PlantDetailBackgroundPainter({
    this.top = PlantColors.screenGreen,
    this.bottom = PlantColors.screenGreenDeep,
    this.blob = PlantColors.lightGreen,
  });

  final Color top;
  final Color bottom;
  final Color blob;

  static Path quantityBlob() {
    return Path()
      ..moveTo(135, 628)
      ..cubicTo(150, 655, 113, 665, 113, 695)
      ..cubicTo(113, 718, 135, 726, 188, 726)
      ..cubicTo(241, 726, 263, 718, 263, 695)
      ..cubicTo(263, 665, 226, 655, 241, 628)
      ..close();
  }

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    canvas.drawRect(
      rect,
      Paint()
        ..shader = LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [top, bottom],
        ).createShader(rect),
    );
    canvas.save();
    canvas.scale(size.width / PlantDimensions.phoneWidth, size.height / PlantDimensions.phoneHeight);
    canvas.drawPath(quantityBlob(), Paint()..color = blob..isAntiAlias = true);
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant PlantDetailBackgroundPainter old) =>
      old.top != top || old.bottom != bottom || old.blob != blob;
}
