import 'package:flutter/material.dart';

class PlantText {
  PlantText._();

  static const List<String> _fallback = ['Noto Serif', 'Georgia', 'Times New Roman'];

  static TextStyle serif({
    required double size,
    FontWeight weight = FontWeight.w500,
    Color color = Colors.black,
    double letterSpacing = 0,
    double? height,
  }) {
    return TextStyle(
      fontFamily: 'serif',
      fontFamilyFallback: _fallback,
      fontSize: size,
      fontWeight: weight,
      color: color,
      letterSpacing: letterSpacing,
      height: height,
      decoration: TextDecoration.none,
    );
  }
}
