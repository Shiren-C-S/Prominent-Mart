class Product {
  final String id;
  final String title;
  final String imageAsset;
  final double price;
  final String description; 
  bool isFavourite;

  Product({
    required this.id,
    required this.title,
    required this.imageAsset,
    required this.price,
    required this.description,
    this.isFavourite = false,
  });
}
