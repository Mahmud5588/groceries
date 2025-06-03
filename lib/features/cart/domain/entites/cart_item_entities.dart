import 'package:equatable/equatable.dart';
import 'package:groceries/features/home/domain/entities/product_entites.dart';

class CartItem extends Equatable {
  final int id;
  final int cartId;
  final int productId;
  final int quantity;
  final double price;
  final Product? product;

  const CartItem({
    required this.id,
    required this.cartId,
    required this.productId,
    required this.quantity,
    required this.price,
    this.product,
  });

  factory CartItem.empty() {
    return CartItem(
      id: 0,
      cartId: 0,
      productId: 0,
      quantity: 0,
      price: 0.0,
      product: Product.empty(),
    );
  }

  CartItem copyWith({
    int? id,
    int? cartId,
    int? productId,
    int? quantity,
    double? price,
    Product? product,
    bool removeProduct = false,
  }) {
    return CartItem(
      id: id ?? this.id,
      cartId: cartId ?? this.cartId,
      productId: productId ?? this.productId,
      quantity: quantity ?? this.quantity,
      price: price ?? this.price,
      product: removeProduct ? null : product ?? this.product,
    );
  }

  @override
  List<Object?> get props => [id, cartId, productId, quantity, price, product];
}
