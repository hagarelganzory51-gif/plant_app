import 'package:flutter/material.dart';

import '../theme/plant_colors.dart';

class PlantListingBackgroundPainter extends CustomPainter {
  PlantListingBackgroundPainter({
    this.top = const Color(0xFF14700B),
    this.bottom = PlantColors.screenGreen,
  });

  final Color top;
  final Color bottom;

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
  }

  @override
  bool shouldRepaint(covariant PlantListingBackgroundPainter old) =>
      old.top != top || old.bottom != bottom;
}
