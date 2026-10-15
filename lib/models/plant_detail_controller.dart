import 'package:flutter/foundation.dart';

import 'plant_product.dart';

class PlantDetailController extends ChangeNotifier {
  PlantSize _size = PlantSize.m;
  int _quantity = 2;

  PlantSize get size => _size;
  int get quantity => _quantity;

  void selectSize(PlantSize value) {
    if (value == _size) return;
    _size = value;
    notifyListeners();
  }

  void cycleSize() {
    const values = PlantSize.values;
    selectSize(values[(values.indexOf(_size) + 1) % values.length]);
  }

  void increment() {
    _quantity++;
    notifyListeners();
  }

  void decrement() {
    if (_quantity <= 1) return;
    _quantity--;
    notifyListeners();
  }
}
