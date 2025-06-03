import 'package:groceries/features/home/domain/entities/product_entites.dart';

class OrderItemEntity {
  final int id;
  final int orderId;
  final int productId;
  final int quantity;
  final double price;
  final double total;
  final DateTime createdAt;
  final DateTime updatedAt;
  final Product product;

  OrderItemEntity({
    required this.id,
    required this.orderId,
    required this.productId,
    required this.quantity,
    required this.price,
    required this.total,
    required this.createdAt,
    required this.updatedAt,
    required this.product,
  });
}
