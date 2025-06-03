import 'package:groceries/features/cart/data/model/cart_item_model.dart';
import 'package:groceries/features/cart/domain/entites/cart_entites.dart';

class CartModel extends Cart {
  const CartModel({
    required super.id,
    required super.userId,
    super.createdAt,
    super.updatedAt,
    required super.items,
    required super.subtotal,
    required super.shippingCharges,
    required super.total,
  });

  factory CartModel.fromJson(Map<String, dynamic> jsonMap) {
    final Map<String, dynamic> json;
    if (jsonMap.containsKey('data') && jsonMap['data'] is Map && jsonMap['data'].containsKey('cart') && jsonMap['data']['cart'] is Map) {
      json = jsonMap['data']['cart'] as Map<String, dynamic>;
    } else if (jsonMap.containsKey('cart') && jsonMap['cart'] is Map) {
      json = jsonMap['cart'] as Map<String, dynamic>;
    } else {
      json = jsonMap;
    }

    return CartModel(
      id: json['id'] as int? ?? 0,
      userId: json['user_id'] as int? ?? 0,
      createdAt: json['created_at'] == null ? null : DateTime.tryParse(json['created_at'] as String),
      updatedAt: json['updated_at'] == null ? null : DateTime.tryParse(json['updated_at'] as String),
      items: (json['items'] as List<dynamic>? ?? [])
          .map((item) => CartItemModel.fromJson(item as Map<String, dynamic>))
          .toList(),
      subtotal: (json['subtotal'] as num?)?.toDouble() ?? 0.0,
      shippingCharges: (json['shipping_charges'] as num?)?.toDouble() ?? 0.0,
      total: (json['total'] as num?)?.toDouble() ?? 0.0,
    );
  }
}
