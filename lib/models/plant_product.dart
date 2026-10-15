class PlantAssets {
  PlantAssets._();
  static const String strelitzia = 'assets/images/plants/strelitzia.png';
  static const String strelitziaCard = 'assets/images/plants/strelitzia_card.png';
  static const String bananaTree = 'assets/images/plants/banana_tree.png';
  static const String peperomia = 'assets/images/plants/peperomia.png';
  static const String sansevieria = 'assets/images/plants/sansevieria.png';
}

enum PlantSize {
  m('M', 1.00, 0.60),
  l('L', 1.06, 0.65),
  xl('XL', 1.12, 0.70);

  const PlantSize(this.label, this.previewScale, this.standaloneScale);
  final String label;
  final double previewScale;
  final double standaloneScale;
}

class PlantProduct {
  const PlantProduct({
    required this.name,
    required this.price,
    required this.imageAsset,
    required this.rating,
    required this.quantity,
    this.subtitle = '',
  });

  final String name;
  final String subtitle;
  final int price;
  final String imageAsset;
  final int rating;
  final int quantity;

  String get priceLabel => '\u00A3$price';

  PlantProduct copyWith({int? quantity}) => PlantProduct(
        name: name,
        subtitle: subtitle,
        price: price,
        imageAsset: imageAsset,
        rating: rating,
        quantity: quantity ?? this.quantity,
      );
}

class PlantCatalog {
  PlantCatalog._();

  static const List<PlantProduct> all = [
    PlantProduct(name: 'Banana tree', price: 78, imageAsset: PlantAssets.bananaTree, rating: 4, quantity: 2),
    PlantProduct(name: 'Peperomia', price: 35, imageAsset: PlantAssets.peperomia, rating: 3, quantity: 0),
    PlantProduct(name: 'Sanseveria', price: 15, imageAsset: PlantAssets.sansevieria, rating: 4, quantity: 1),
    PlantProduct(
      name: 'Strelitzia',
      subtitle: 'BIRD OF PARADISE',
      price: 100,
      imageAsset: PlantAssets.strelitziaCard,
      rating: 3,
      quantity: 6,
    ),
  ];
}
