class Product {
  final String name;
  final String image; // Asset path
  final String price; // e.g., "$2.22"
  final String unit; // e.g., "1.5 lbs"
  final String description;
  final double rating;
  final int reviewCount;
  final int initialQuantity;
  final bool initialIsLiked;

  Product({
    required this.name,
    required this.image,
    required this.price,
    required this.unit,
    required this.description,
    required this.rating,
    required this.reviewCount,
    required this.initialQuantity,
    required this.initialIsLiked,
  });
}
