import 'package:flutter/material.dart';

import '../models/plant_product.dart';
import '../painters/bottom_navigation_painter.dart';
import '../painters/plant_listing_background_painter.dart';
import '../theme/plant_colors.dart';
import '../theme/plant_dimensions.dart';
import '../theme/plant_text.dart';
import '../widgets/plant_product_card.dart';

class PlantListingScreen extends StatefulWidget {
  const PlantListingScreen({super.key, this.preview = false});

  final bool preview;

  @override
  State<PlantListingScreen> createState() => _PlantListingScreenState();
}

class _PlantListingScreenState extends State<PlantListingScreen> {
  late final List<PlantProduct> _products = List<PlantProduct>.of(PlantCatalog.all);

  void _change(int index, int delta) {
    final int q = _products[index].quantity + delta;
    if (q < 0 || q > 99) return;
    setState(() => _products[index] = _products[index].copyWith(quantity: q));
  }

  @override
  Widget build(BuildContext context) {
    Widget content = SizedBox(
      width: PlantDimensions.phoneWidth,
      height: PlantDimensions.phoneHeight,
      child: _buildBase(),
    );

    if (!widget.preview) {
      content = ClipRRect(
        borderRadius: BorderRadius.circular(PlantDimensions.phoneRadius),
        child: content,
      );
    }
    return content;
  }

  Widget _buildBase() {
    final body = Stack(
      children: [
        Positioned.fill(child: CustomPaint(painter: PlantListingBackgroundPainter())),
        Positioned.fill(child: CustomPaint(painter: BottomNavigationPainter())),
        const Positioned(left: 28, top: 31, child: Icon(Icons.chevron_left, size: 30, color: Colors.white70)),
        Positioned(
          top: 30,
          left: 0,
          right: 0,
          child: Center(
            child: Text(
              'Decorative flowers',
              style: PlantText.serif(size: 22, color: Colors.white, letterSpacing: 0.3),
            ),
          ),
        ),
        const Positioned(right: 41, top: 36, child: _MenuIcon()),
        for (int i = 0; i < _products.length; i++)
          Positioned(
            left: PlantDimensions.listCardLeft,
            top: PlantDimensions.listCardTop(i),
            child: PlantProductCard(
              product: _products[i],
              onIncrement: () => _change(i, 1),
              onDecrement: () => _change(i, -1),
            ),
          ),
        const Positioned(left: 10, top: 669, child: Icon(Icons.chevron_left, size: 30, color: PlantColors.chevronGrey)),
        const Positioned(left: 333, top: 669, child: Icon(Icons.chevron_right, size: 30, color: PlantColors.ink)),
        const Positioned(left: 176, top: 783, child: Icon(Icons.shopping_bag, size: 22, color: PlantColors.ink)),
      ],
    );

    final clipped = ClipRRect(
      borderRadius: BorderRadius.circular(PlantDimensions.phoneRadius),
      child: body,
    );
    if (!widget.preview) return clipped;
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

class _MenuIcon extends StatelessWidget {
  const _MenuIcon();

  Widget _line(double width) => Container(
        width: width,
        height: 2,
        margin: const EdgeInsets.symmetric(vertical: 3),
        color: Colors.white70,
      );

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [_line(28), _line(20), _line(28)],
    );
  }
}
