import 'package:groceries/features/home/domain/entities/product_entites.dart';

class ProductModel extends Product {
  const ProductModel({
    required super.id,
    required super.name,
    super.description,
    required super.price,
    required super.unit,
    super.unitValue,
    required super.image,
    super.isFeatured,
    super.isNew,
    super.isOrganic,
    super.discountPercentage,
    super.originalPrice,
    super.stock,
    required super.categoryId,
    super.averageRating,
    super.reviewsCount,
    super.isFavorite,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    double? numToDouble(dynamic v) => v == null ? null : (v as num).toDouble();
    int? numToInt(dynamic v) => v == null ? null : (v as num).toInt();

    return ProductModel(
      id: json['id'] as int? ?? 0,
      name: json['name'] as String? ?? '',
      description: json['description'] as String?,
      price: numToDouble(json['price']) ?? 0.0,
      unit: json['unit'] as String? ?? '',
      unitValue: numToDouble(json['unit_value']),
      image: json['image'] as String? ?? 'assets/images/default_product.png',
      isFeatured: json['is_featured'] == 1 || json['is_featured'] == true,
      isNew: json['is_new'] == 1 || json['is_new'] == true,
      isOrganic: json['is_organic'] == 1 || json['is_organic'] == true,
      discountPercentage: numToDouble(json['discount_percentage']),
      originalPrice: numToDouble(json['original_price']),
      stock: numToInt(json['stock']),
      categoryId: json['category_id'] as int? ?? 0,
      averageRating: numToDouble(json['average_rating']),
      reviewsCount: numToInt(json['reviews_count']),
      isFavorite: json['is_favorited'] as bool? ?? json['is_favorite'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'price': price,
      'unit': unit,
      'unit_value': unitValue,
      'image': image,
      'is_featured': isFeatured,
      'is_new': isNew,
      'is_organic': isOrganic,
      'discount_percentage': discountPercentage,
      'original_price': originalPrice,
      'stock': stock,
      'category_id': categoryId,
      'average_rating': averageRating,
      'reviews_count': reviewsCount,
      'is_favorite': isFavorite,
    };
  }

  static ProductModel empty() {
    return const ProductModel(
      id: 0,
      name: '',
      price: 0.0,
      unit: '',
      image: 'assets/images/default_product.png',
      categoryId: 0,
      description: null,
      unitValue: null,
      isFeatured: false,
      isNew: false,
      isOrganic: false,
      discountPercentage: null,
      originalPrice: null,
      stock: 0,
      averageRating: 0.0,
      reviewsCount: 0,
      isFavorite: false,
    );
  }
}
