import 'package:flutter/material.dart';

import '../models/plant_product.dart';
import '../theme/plant_colors.dart';
import '../theme/plant_text.dart';

class PlantSizeSelector extends StatelessWidget {
  const PlantSizeSelector({super.key, required this.selected, required this.onSelected});

  final PlantSize selected;
  final ValueChanged<PlantSize> onSelected;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        for (final size in PlantSize.values)
          Padding(
            padding: const EdgeInsets.only(bottom: 9),
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () => onSelected(size),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                width: 30,
                height: 30,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: size == selected ? PlantColors.lightGreen : PlantColors.paleGreen,
                ),
                child: Text(
                  size.label,
                  style: PlantText.serif(
                    size: size.label.length > 1 ? 11 : 13,
                    weight: FontWeight.w600,
                    color: size == selected ? PlantColors.darkGreenText : PlantColors.paleGreenText,
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}
