import 'package:flutter/material.dart';


class PlantDimensions {
  PlantDimensions._();

  static const double phoneWidth = 375;
  static const double phoneHeight = 812;
  static const double phoneRadius = 56;

  static const double previewWidth = 1920;
  static const double previewHeight = 1200;
  static const Offset detailPhoneOrigin = Offset(537, 281);
  static const Offset listingPhoneOrigin = Offset(975, 281);
  static const double wideBreakpoint = 900;

  static const Size plantImageSize = Size(430, 625);
  static const Offset plantImageAnchorPx = Offset(145, 610); 
  static const Offset plantAnchorPreview = Offset(193, 449);
  static const Offset plantAnchorStandalone = Offset(170, 449);

  static const double listCardLeft = 42;
  static const double listCardWidth = 290;
  static const double listCardHeight = 107;
  static const double listCardGap = 27;
  static const double listCardFirstTop = 86;
  static const double listCardPadding = 18; 
  static const double listCardImageWidth = 66;
  static const double listCardContentGap = 12;

  static double listCardTop(int index) =>
      listCardFirstTop + index * (listCardHeight + listCardGap);
}
