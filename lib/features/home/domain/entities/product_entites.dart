import 'package:equatable/equatable.dart';

class Product extends Equatable {
  final int id;
  final String name;
  final String? description;
  final double price;
  final String unit;
  final double? unitValue;
  final String image;
  final bool? isFeatured;
  final bool? isNew;
  final bool? isOrganic;
  final double? discountPercentage;
  final double? originalPrice;
  final int? stock;
  final int categoryId;
  final double? averageRating;
  final int? reviewsCount;
  final bool? isFavorite;

  const Product({
    required this.id,
    required this.name,
    this.description,
    required this.price,
    required this.unit,
    this.unitValue,
    required this.image,
    this.isFeatured,
    this.isNew,
    this.isOrganic,
    this.discountPercentage,
    this.originalPrice,
    this.stock,
    required this.categoryId,
    this.averageRating,
    this.reviewsCount,
    this.isFavorite,
  });

  factory Product.empty() {
    return const Product(
      id: 0,
      name: '',
      description: null,
      price: 0.0,
      unit: '',
      unitValue: null,
      image: 'assets/images/default_product.png',
      isFeatured: false,
      isNew: false,
      isOrganic: false,
      discountPercentage: null,
      originalPrice: null,
      stock: 0,
      categoryId: 0,
      averageRating: 0.0,
      reviewsCount: 0,
      isFavorite: false,
    );
  }

  Product copyWith({
    int? id,
    String? name,
    String? description,
    double? price,
    String? unit,
    double? unitValue,
    String? image,
    bool? isFeatured,
    bool? isNew,
    bool? isOrganic,
    double? discountPercentage,
    double? originalPrice,
    int? stock,
    int? categoryId,
    double? averageRating,
    int? reviewsCount,
    bool? isFavorite,
  }) {
    return Product(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      price: price ?? this.price,
      unit: unit ?? this.unit,
      unitValue: unitValue ?? this.unitValue,
      image: image ?? this.image,
      isFeatured: isFeatured ?? this.isFeatured,
      isNew: isNew ?? this.isNew,
      isOrganic: isOrganic ?? this.isOrganic,
      discountPercentage: discountPercentage ?? this.discountPercentage,
      originalPrice: originalPrice ?? this.originalPrice,
      stock: stock ?? this.stock,
      categoryId: categoryId ?? this.categoryId,
      averageRating: averageRating ?? this.averageRating,
      reviewsCount: reviewsCount ?? this.reviewsCount,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }

  @override
  List<Object?> get props => [
    id,
    name,
    description,
    price,
    unit,
    unitValue,
    image,
    isFeatured,
    isNew,
    isOrganic,
    discountPercentage,
    originalPrice,
    stock,
    categoryId,
    averageRating,
    reviewsCount,
    isFavorite,
  ];
}
