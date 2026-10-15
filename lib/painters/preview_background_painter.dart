import 'package:flutter/material.dart';

import '../theme/plant_colors.dart';

class PreviewBackgroundPainter extends CustomPainter {
  PreviewBackgroundPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    canvas.drawRect(
      rect,
      Paint()
        ..shader = const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [PlantColors.previewTop, PlantColors.previewMid, PlantColors.previewDark],
          stops: [0.0, 0.55, 1.0],
        ).createShader(rect),
    );
  }

  @override
  bool shouldRepaint(covariant PreviewBackgroundPainter old) => false;
}
