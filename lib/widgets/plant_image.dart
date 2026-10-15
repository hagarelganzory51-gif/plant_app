import 'package:flutter/material.dart';

class PlantImage extends StatelessWidget {
  const PlantImage({
    super.key,
    required this.asset,
    this.width,
    this.height,
    this.alignment = Alignment.center,
  });

  final String asset;
  final double? width;
  final double? height;
  final Alignment alignment;

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      asset,
      width: width,
      height: height,
      fit: BoxFit.contain,
      alignment: alignment,
      filterQuality: FilterQuality.medium,
      errorBuilder: (context, error, stack) => SizedBox(
        width: width,
        height: height,
        child: const Icon(Icons.broken_image_outlined, color: Colors.white54),
      ),
    );
  }
}
