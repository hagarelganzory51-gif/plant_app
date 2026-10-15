import 'package:flutter/material.dart';

import '../models/plant_detail_controller.dart';
import '../painters/preview_background_painter.dart';
import '../theme/plant_colors.dart';
import '../theme/plant_dimensions.dart';
import 'plant_detail_screen.dart';
import 'plant_listing_screen.dart';

enum PreviewMode { detail, listing }

class DesignPreviewScreen extends StatefulWidget {
  const DesignPreviewScreen({super.key});

  @override
  State<DesignPreviewScreen> createState() => _DesignPreviewScreenState();
}

class _DesignPreviewScreenState extends State<DesignPreviewScreen> {
  final PlantDetailController _controller = PlantDetailController();

  PreviewMode _mode = PreviewMode.detail;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Scaffold(
          body: Stack(
            children: [
              Positioned.fill(
                child: CustomPaint(
                  painter: PreviewBackgroundPainter(),
                ),
              ),
              SafeArea(
                child: Column(
                  children: [
                    _ModeBar(
                      mode: _mode,
                      onChanged: (mode) {
                        setState(() => _mode = mode);
                      },
                    ),
                    Expanded(
                      child: _buildBody(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildBody() {
    switch (_mode) {
      case PreviewMode.detail:
        return _fitPhone(
          PlantDetailScreen(controller: _controller),
        );

      case PreviewMode.listing:
        return _fitPhone(
          const PlantListingScreen(),
        );
    }
  }

  Widget _fitPhone(Widget phone) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: SizedBox.expand(
        child: FittedBox(
          fit: BoxFit.contain,
          child: SizedBox(
            width: PlantDimensions.phoneWidth,
            height: PlantDimensions.phoneHeight,
            child: phone,
          ),
        ),
      ),
    );
  }
}

class _ModeBar extends StatelessWidget {
  const _ModeBar({
    required this.mode,
    required this.onChanged,
  });

  final PreviewMode mode;
  final ValueChanged<PreviewMode> onChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 8, 12, 0),
      child: SegmentedButton<PreviewMode>(
        style: SegmentedButton.styleFrom(
          backgroundColor: Colors.black26,
          foregroundColor: Colors.white,
          selectedBackgroundColor: Colors.white,
          selectedForegroundColor: PlantColors.darkGreenText,
        ),
        showSelectedIcon: false,
        segments: const [
          ButtonSegment(
            value: PreviewMode.detail,
            label: Text('Detail'),
          ),
          ButtonSegment(
            value: PreviewMode.listing,
            label: Text('Listing'),
          ),
        ],
        selected: {mode},
        onSelectionChanged: (selection) {
          onChanged(selection.first);
        },
      ),
    );
  }
}