import 'package:flutter/material.dart';

import '../theme/plant_colors.dart';

class ProductRating extends StatelessWidget {
  const ProductRating({super.key, required this.rating, this.starSize = 10, this.max = 5});

  final int rating;
  final double starSize;
  final int max;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        for (int i = 0; i < max; i++)
          Icon(
            Icons.star_rounded,
            size: starSize,
            color: i < rating ? PlantColors.star : PlantColors.starOff,
          ),
      ],
    );
  }
}
