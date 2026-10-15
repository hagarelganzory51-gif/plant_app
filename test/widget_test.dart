import 'package:flutter_test/flutter_test.dart';
import 'package:plant_app/main.dart';
import 'package:plant_app/models/plant_detail_controller.dart';
import 'package:plant_app/models/plant_product.dart';

void main() {
  test('quantity starts at 2 and never drops below 1', () {
    final c = PlantDetailController();
    expect(c.quantity, 2);
    c.decrement();
    c.decrement();
    c.decrement();
    expect(c.quantity, 1);
    c.increment();
    expect(c.quantity, 2);
  });

  test('size defaults to M and can be changed', () {
    final c = PlantDetailController();
    expect(c.size, PlantSize.m);
    c.selectSize(PlantSize.xl);
    expect(c.size, PlantSize.xl);
  });

  testWidgets('app builds', (tester) async {
    await tester.pumpWidget(const PlantApp());
    expect(find.text('Strelitzia'), findsWidgets);
  });
}
