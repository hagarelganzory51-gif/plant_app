import 'package:flutter/material.dart';

import '../theme/plant_colors.dart';
import '../theme/plant_text.dart';

class MiniQuantityStepper extends StatelessWidget {
  const MiniQuantityStepper({
    super.key,
    required this.quantity,
    required this.onDecrement,
    required this.onIncrement,
    this.diameter = 12,
  });

  final int quantity;
  final VoidCallback onDecrement;
  final VoidCallback onIncrement;
  final double diameter;

  Widget _dot(IconData icon, VoidCallback onTap) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Container(
        width: diameter,
        height: diameter,
        decoration: const BoxDecoration(color: PlantColors.lightGreen, shape: BoxShape.circle),
        child: Icon(icon, size: diameter * 0.75, color: PlantColors.darkGreenText),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _dot(Icons.remove, onDecrement),
        SizedBox(width: diameter * 0.35),
        Text('x$quantity', style: PlantText.serif(size: diameter * 0.9, color: PlantColors.ink)),
        SizedBox(width: diameter * 0.35),
        _dot(Icons.add, onIncrement),
      ],
    );
  }
}

class QuantityActionButton extends StatelessWidget {
  const QuantityActionButton({super.key, required this.icon, required this.onTap, required this.semanticLabel});

  final IconData icon;
  final VoidCallback onTap;
  final String semanticLabel;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: semanticLabel,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: onTap,
        child: SizedBox(
          width: 48,
          height: 48,
          child: Center(child: Icon(icon, size: 36, color: PlantColors.ink)),
        ),
      ),
    );
  }
}
