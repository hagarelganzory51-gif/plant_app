import 'dart:ui' show lerpDouble;

import 'package:flutter/material.dart';

import '../models/plant_product.dart';
import '../painters/action_tab_painter.dart';
import '../theme/plant_colors.dart';
import '../theme/plant_dimensions.dart';
import '../theme/plant_text.dart';
import 'plant_image.dart';
import 'product_rating.dart';
import 'quantity_control.dart';


class PlantProductCard extends StatefulWidget {
  const PlantProductCard({
    super.key,
    required this.product,
    required this.onIncrement,
    required this.onDecrement,
    this.width = PlantDimensions.listCardWidth,
    this.height = PlantDimensions.listCardHeight,
  });

  final PlantProduct product;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;
  final double width;
  final double height;

  @override
  State<PlantProductCard> createState() => _PlantProductCardState();
}

class _PlantProductCardState extends State<PlantProductCard>
    with SingleTickerProviderStateMixin {
  static const double _dragRangeFraction = 0.55;
  static const double _cardShiftFraction = 0.02;
  static const double _plantRevealOffsetFraction = 0.45;
  static const double _plantRevealScale = 1.3;
  static const double _clipExtendBottomFraction = 0.45;
  static const double _settleThreshold = 0.4;
  static const double _flingVelocity = 500;

  late final AnimationController _progress = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 360),
  );

  double get _dragRange => widget.width * _dragRangeFraction;

  @override
  void dispose() {
    _progress.dispose();
    super.dispose();
  }

  void _onDragStart(DragStartDetails details) {
    _progress.stop();
  }

  void _onDragUpdate(DragUpdateDetails details) {
    final double delta = (details.primaryDelta ?? 0) / _dragRange;

    _progress.value =
        (_progress.value + delta).clamp(0.0, 1.0).toDouble();
  }

  void _onDragEnd(DragEndDetails details) {
    final double velocity = details.primaryVelocity ?? 0;

    final bool reveal;

    if (velocity > _flingVelocity) {
      reveal = true;
    } else if (velocity < -_flingVelocity) {
      reveal = false;
    } else {
      reveal = _progress.value > _settleThreshold;
    }

    _progress.animateTo(
      reveal ? 1.0 : 0.0,
      curve: Curves.easeOutCubic,
    );
  }

  @override
  Widget build(BuildContext context) {
    final double width = widget.width;
    final double height = widget.height;
    final double radius = height * 0.46;

    return GestureDetector(
      onHorizontalDragStart: _onDragStart,
      onHorizontalDragUpdate: _onDragUpdate,
      onHorizontalDragEnd: _onDragEnd,
      child: SizedBox(
        width: width,
        height: height,
        child: AnimatedBuilder(
          animation: _progress,
          child: _buildForeground(radius),
          builder: (context, foreground) {
            final double progress = _progress.value;
            final double easedProgress =
            Curves.easeOutCubic.transform(progress);

            return Transform.translate(
              offset: Offset(
                progress * width * _cardShiftFraction,
                0,
              ),
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Positioned.fill(
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(radius),
                        boxShadow: const [
                          BoxShadow(
                            color: PlantColors.cardShadow,
                            blurRadius: 14,
                            offset: Offset(0, 6),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned.fill(
                    child: ClipPath(
                      clipper: _RevealClipper(
                        t: easedProgress,
                        radius: radius,
                        extendBottom:
                        height * _clipExtendBottomFraction,
                      ),
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          _buildPlant(
                            easedProgress,
                            width,
                            height,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned.fill(
                    child: foreground!,
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildPlant(
      double progress,
      double width,
      double height,
      ) {
    const double padding = PlantDimensions.listCardPadding;
    const double imageWidth = PlantDimensions.listCardImageWidth;
    const double inset = 8;

    return Positioned(
      left: padding,
      top: inset,
      width: imageWidth,
      height: height - inset * 2,
      child: IgnorePointer(
        child: Transform.translate(
          offset: Offset(
            0,
            height * _plantRevealOffsetFraction * progress,
          ),
          child: Transform.scale(
            scale: lerpDouble(
              1.0,
              _plantRevealScale,
              progress,
            )!,
            alignment: Alignment.topCenter,
            child: PlantImage(
              asset: widget.product.imageAsset,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildForeground(double radius) {
    const double padding = PlantDimensions.listCardPadding;

    const double contentLeft = padding +
        PlantDimensions.listCardImageWidth +
        PlantDimensions.listCardContentGap;

    const double tabWidth = 52;
    const double tabHeight = 40;

    final PlantProduct product = widget.product;

    return ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: Stack(
        children: [
          Positioned(
            left: contentLeft,
            top: 0,
            bottom: 0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ProductRating(
                  rating: product.rating,
                  starSize: 9,
                ),
                Text(
                  product.name,
                  style: PlantText.serif(
                    size: 21,
                    color: PlantColors.ink,
                  ),
                ),
                Text(
                  product.priceLabel,
                  style: PlantText.serif(
                    size: 14,
                    color: PlantColors.priceGreen,
                  ),
                ),
                const SizedBox(height: 3),
                MiniQuantityStepper(
                  quantity: product.quantity,
                  onDecrement: widget.onDecrement,
                  onIncrement: widget.onIncrement,
                  diameter: 12,
                ),
              ],
            ),
          ),
          Positioned(
            right: 0,
            top: (widget.height - tabHeight) / 2,
            width: tabWidth,
            height: tabHeight,
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: widget.onIncrement,
              child: Stack(
                children: [
                  Positioned.fill(
                    child: CustomPaint(
                      painter: ActionTabPainter(),
                    ),
                  ),
                  const Positioned(
                    left: 15,
                    top: tabHeight / 2 - 8,
                    child: Icon(
                      Icons.shopping_bag,
                      size: 15,
                      color: PlantColors.ink,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _RevealClipper extends CustomClipper<Path> {
  _RevealClipper({
    required this.t,
    required this.radius,
    required this.extendBottom,
  });

  final double t;
  final double radius;
  final double extendBottom;

  @override
  Path getClip(Size size) {
    final Rect rect = Rect.fromLTRB(
      0,
      0,
      size.width,
      size.height + extendBottom * t,
    );

    final double currentRadius = lerpDouble(
      radius,
      radius * 0.6,
      t,
    )!;

    return Path()
      ..addRRect(
        RRect.fromRectAndRadius(
          rect,
          Radius.circular(currentRadius),
        ),
      );
  }

  @override
  bool shouldReclip(covariant _RevealClipper old) {
    return old.t != t ||
        old.radius != radius ||
        old.extendBottom != extendBottom;
  }
}