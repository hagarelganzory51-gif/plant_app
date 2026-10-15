import 'package:flutter/material.dart';

import '../models/plant_detail_controller.dart';
import '../models/plant_product.dart';
import '../painters/bottom_navigation_painter.dart';
import '../painters/curved_surface_painter.dart';
import '../painters/plant_detail_background_painter.dart';
import '../theme/plant_colors.dart';
import '../theme/plant_dimensions.dart';
import '../theme/plant_text.dart';
import '../widgets/plant_image.dart';
import '../widgets/plant_size_selector.dart';
import '../widgets/quantity_control.dart';


class PlantDetailScreen extends StatelessWidget {
  const PlantDetailScreen({super.key, required this.controller, this.preview = false});

  final PlantDetailController controller;
  final bool preview;

  @override
  Widget build(BuildContext context) {
    final Offset anchor = preview ? PlantDimensions.plantAnchorPreview : PlantDimensions.plantAnchorStandalone;
    const Offset imgAnchor = PlantDimensions.plantImageAnchorPx;
    const Size imgSize = PlantDimensions.plantImageSize;

    Widget content = SizedBox(
      width: PlantDimensions.phoneWidth,
      height: PlantDimensions.phoneHeight,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned.fill(child: _DetailBase(controller: controller, preview: preview)),
          Positioned(
            left: anchor.dx - imgAnchor.dx,
            top: anchor.dy - imgAnchor.dy,
            width: imgSize.width,
            height: imgSize.height,
            child: IgnorePointer(child: _PlantLayer(controller: controller, preview: preview)),
          ),
          Positioned(
            left: 17,
            top: 349,
            child: ListenableBuilder(
              listenable: controller,
              builder: (context, _) => PlantSizeSelector(
                selected: controller.size,
                onSelected: controller.selectSize,
              ),
            ),
          ),
          Positioned(
            left: 238,
            top: 364,
            width: 54,
            height: 54,
            child: Semantics(
              button: true,
              label: 'Next size',
              child: GestureDetector(
                onTap: controller.cycleSize,
                child: Container(
                  decoration: const BoxDecoration(color: PlantColors.mediumGreen, shape: BoxShape.circle),
                  child: const Icon(Icons.chevron_right, color: Colors.white70, size: 34),
                ),
              ),
            ),
          ),
        ],
      ),
    );

    if (!preview) {
      content = ClipRRect(
        borderRadius: BorderRadius.circular(PlantDimensions.phoneRadius),
        child: content,
      );
    }
    return content;
  }
}

class _PlantLayer extends StatelessWidget {
  const _PlantLayer({required this.controller, required this.preview});

  final PlantDetailController controller;
  final bool preview;

  @override
  Widget build(BuildContext context) {
    const Offset a = PlantDimensions.plantImageAnchorPx;
    const Size s = PlantDimensions.plantImageSize;
    final Alignment alignment = Alignment(a.dx / s.width * 2 - 1, a.dy / s.height * 2 - 1);

    return ListenableBuilder(
      listenable: controller,
      builder: (context, _) {
        final double target = preview ? controller.size.previewScale : controller.size.standaloneScale;
        return TweenAnimationBuilder<double>(
          tween: Tween<double>(end: target),
          duration: const Duration(milliseconds: 380),
          curve: Curves.easeOutCubic,
          builder: (context, scale, child) => Transform.scale(
            scale: scale,
            alignment: alignment,
            child: child,
          ),
          child: const PlantImage(
            asset: PlantAssets.strelitzia,
            width: 430,
            height: 625,
          ),
        );
      },
    );
  }
}

class _DetailBase extends StatelessWidget {
  const _DetailBase({required this.controller, required this.preview});

  final PlantDetailController controller;
  final bool preview;

  @override
  Widget build(BuildContext context) {
    final body = Stack(
      children: [
        Positioned.fill(child: CustomPaint(painter: PlantDetailBackgroundPainter())),
        Positioned.fill(child: CustomPaint(painter: CurvedSurfacePainter())),
        Positioned.fill(child: CustomPaint(painter: BottomNavigationPainter())),
        Positioned(
          top: 516,
          left: 0,
          right: 0,
          child: Center(
            child: Text('Strelitzia', style: PlantText.serif(size: 35, weight: FontWeight.w600, color: PlantColors.ink)),
          ),
        ),
        Positioned(
          top: 559,
          left: 0,
          right: 0,
          child: Center(
            child: Text(
              'BIRD OF PARADISE',
              style: PlantText.serif(size: 10, color: PlantColors.subtitle, letterSpacing: 0.4),
            ),
          ),
        ),
        Positioned(
          top: 588,
          left: 0,
          right: 0,
          child: Center(
            child: Text('\u00A3100', style: PlantText.serif(size: 34, weight: FontWeight.w600, color: PlantColors.ink)),
          ),
        ),
        Positioned(
          top: 660,
          left: 113,
          width: 150,
          child: Center(
            child: ListenableBuilder(
              listenable: controller,
              builder: (context, _) => Text(
                'x${controller.quantity}',
                style: PlantText.serif(size: 38, color: PlantColors.ink),
              ),
            ),
          ),
        ),
        Positioned(
          left: 46,
          top: 732,
          child: QuantityActionButton(icon: Icons.add, onTap: controller.increment, semanticLabel: 'Increase quantity'),
        ),
        Positioned(
          left: 276,
          top: 732,
          child: QuantityActionButton(icon: Icons.remove, onTap: controller.decrement, semanticLabel: 'Decrease quantity'),
        ),
        const Positioned(left: 11, top: 670, child: Icon(Icons.person, size: 30, color: PlantColors.ink)),
        const Positioned(left: 332, top: 670, child: Icon(Icons.home_rounded, size: 30, color: PlantColors.ink)),
        const Positioned(left: 176, top: 783, child: Icon(Icons.shopping_bag, size: 22, color: PlantColors.ink)),
      ],
    );

    final clipped = ClipRRect(
      borderRadius: BorderRadius.circular(PlantDimensions.phoneRadius),
      child: body,
    );
    if (!preview) return clipped;
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(PlantDimensions.phoneRadius),
        boxShadow: const [
          BoxShadow(color: PlantColors.phoneShadow, blurRadius: 90, spreadRadius: 10, offset: Offset(0, 30)),
        ],
      ),
      child: clipped,
    );
  }
}
