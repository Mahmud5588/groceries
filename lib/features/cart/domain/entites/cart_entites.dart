import 'package:equatable/equatable.dart';
import 'package:groceries/features/cart/domain/entites/cart_item_entities.dart';

import 'package:equatable/equatable.dart';
import 'package:groceries/features/cart/domain/entites/cart_item_entities.dart';

class Cart extends Equatable {
  final int id;
  final int userId;
  final DateTime? createdAt; // Nullable
  final DateTime? updatedAt; // Nullable
  final List<CartItem> items;
  final double subtotal;
  final double shippingCharges;
  final double total;

  const Cart({
    required this.id,
    required this.userId,
    this.createdAt,
    this.updatedAt,
    required this.items,
    required this.subtotal,
    required this.shippingCharges,
    required this.total,
  });
  @override
  List<Object?> get props => [
    id,
    userId,
    createdAt,
    updatedAt,
    items,
    subtotal,
    shippingCharges,
    total,
  ];
}
