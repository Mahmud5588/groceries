import 'package:groceries/features/cart/domain/entites/cart_item_entities.dart';
import 'package:groceries/features/home/data/model/product_model.dart';
import 'package:groceries/features/home/domain/entities/product_entites.dart';

class CartItemModel extends CartItem {
  CartItemModel({
    required int id,
    required int cartId,
    required int productId,
    required int quantity,
    required double price,
    Product? product,
  }) : super(
    id: id,
    cartId: cartId,
    productId: productId,
    quantity: quantity,
    price: price,
    product: _initializeSuperProduct(product),
  );

  static Product? _initializeSuperProduct(Product? productParam) {
    if (productParam == null) return null;

    return productParam;
  }




  factory CartItemModel.fromJson(Map<String, dynamic> json) {
    return CartItemModel(
      id: json['id'] as int? ?? 0,
      cartId: json['cart_id'] as int? ?? 0,
      productId: json['product_id'] as int? ?? 0,
      quantity: json['quantity'] as int? ?? 0,
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
      product: json['product'] != null
          ? ProductModel.fromJson(json['product'] as Map<String, dynamic>)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'cart_id': cartId,
      'product_id': productId,
      'quantity': quantity,
      'price': price,
      'product': product != null && product is ProductModel
          ? (product as ProductModel).toJson()
          : (product != null
          ? ProductModel(
        id: product!.id,
        name: product!.name,
        price: product!.price,
        unit: product!.unit,
        image: product!.image,
        categoryId: product!.categoryId,
        description: product!.description,
        unitValue: product!.unitValue,
        isFeatured: product!.isFeatured,
        isNew: product!.isNew,
        isOrganic: product!.isOrganic,
        discountPercentage: product!.discountPercentage,
        originalPrice: product!.originalPrice,
        stock: product!.stock,
        averageRating: product!.averageRating,
        reviewsCount: product!.reviewsCount,
        isFavorite: product!.isFavorite,
      ).toJson()
          : null),
    };
  }

  static CartItemModel empty() {
    return CartItemModel(
      id: 0,
      cartId: 0,
      productId: 0,
      quantity: 0,
      price: 0.0,
      product: ProductModel.empty(),
    );
  }

  @override
  CartItemModel copyWith({
    int? id,
    int? cartId,
    int? productId,
    int? quantity,
    double? price,
    Product? product,
    bool removeProduct = false,
  }) {
    return CartItemModel(
      id: id ?? this.id,
      cartId: cartId ?? this.cartId,
      productId: productId ?? this.productId,
      quantity: quantity ?? this.quantity,
      price: price ?? this.price,
      product: removeProduct
          ? null
          : (product ?? this.product),
    );
  }

}
