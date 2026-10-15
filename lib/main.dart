import 'package:flutter/material.dart';

import 'screens/design_preview_screen.dart';
import 'theme/plant_colors.dart';

void main() => runApp(const PlantApp());

class PlantApp extends StatelessWidget {
  const PlantApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Plant App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: PlantColors.screenGreen,
        scaffoldBackgroundColor: PlantColors.previewDark,
      ),
      home: const DesignPreviewScreen(),
    );
  }
}
