

import 'package:groceries/features/orders/domain/entities/order_item_entities.dart';
import 'package:groceries/features/orders/domain/entities/shipping_address_entities.dart';

import '../../../payment/domain/entites/payment_details_entites.dart';

class OrderEntity {
  final int id;
  final int userId;
  final String orderNumber;
  final double subtotal;
  final double shippingCharges;
  final double total;
  final String status;
  final String shippingMethod;
  final int shippingAddressId;
  final String shippingName;
  final String shippingEmail;
  final String shippingPhone;
  final ShippingAddressEntity shippingAddress;
  final String shippingCity;
  final String shippingZipCode;
  final String shippingCountry;
  final String paymentMethod;
  final PaymentDetailsEntity paymentDetails;
  final DateTime createdAt;
  final DateTime updatedAt;
  final List<OrderItemEntity> items;

  OrderEntity({
    required this.id,
    required this.userId,
    required this.orderNumber,
    required this.subtotal,
    required this.shippingCharges,
    required this.total,
    required this.status,
    required this.shippingMethod,
    required this.shippingAddressId,
    required this.shippingName,
    required this.shippingEmail,
    required this.shippingPhone,
    required this.shippingAddress,
    required this.shippingCity,
    required this.shippingZipCode,
    required this.shippingCountry,
    required this.paymentMethod,
    required this.paymentDetails,
    required this.createdAt,
    required this.updatedAt,
    required this.items,
  });
}
