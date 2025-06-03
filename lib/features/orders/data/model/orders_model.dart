import 'package:groceries/features/orders/data/model/order_item_model.dart';
import 'package:groceries/features/orders/data/model/shipping_address_model.dart';
import 'package:groceries/features/orders/domain/entities/order_entittes.dart';
import 'package:groceries/features/payment/data/model/payment_details_model.dart';

class OrderModel extends OrderEntity {
  OrderModel({
    required super.id,
    required super.userId,
    required super.orderNumber,
    required super.subtotal,
    required super.shippingCharges,
    required super.total,
    required super.status,
    required super.shippingMethod,
    required super.shippingAddressId,
    required super.shippingName,
    required super.shippingEmail,
    required super.shippingPhone,
    required super.shippingAddress,
    required super.shippingCity,
    required super.shippingZipCode,
    required super.shippingCountry,
    required super.paymentMethod,
    required super.paymentDetails,
    required super.createdAt,
    required super.updatedAt,
    required super.items,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      id: json['id'],
      userId: json['user_id'],
      orderNumber: json['order_number'],
      subtotal: json['subtotal'].toDouble(),
      shippingCharges: json['shipping_charges'].toDouble(),
      total: json['total'].toDouble(),
      status: json['status'],
      shippingMethod: json['shipping_method'],
      shippingAddressId: json['shipping_address_id'],
      shippingName: json['shipping_name'],
      shippingEmail: json['shipping_email'],
      shippingPhone: json['shipping_phone'],
      shippingAddress: ShippingAddressModel.fromJson(json['shipping_address']),
      shippingCity: json['shipping_city'],
      shippingZipCode: json['shipping_zip_code'],
      shippingCountry: json['shipping_country'],
      paymentMethod: json['payment_method'],
      paymentDetails: PaymentDetailsModel.fromJson(json['payment_details']),
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      items: List<OrderItemModel>.from(
        json['items'].map((item) => OrderItemModel.fromJson(item)),
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'order_number': orderNumber,
      'subtotal': subtotal,
      'shipping_charges': shippingCharges,
      'total': total,
      'status': status,
      'shipping_method': shippingMethod,
      'shipping_address_id': shippingAddressId,
      'shipping_name': shippingName,
      'shipping_email': shippingEmail,
      'shipping_phone': shippingPhone,
      'shipping_address': (shippingAddress as ShippingAddressModel).toJson(),
      'shipping_city': shippingCity,
      'shipping_zip_code': shippingZipCode,
      'shipping_country': shippingCountry,
      'payment_method': paymentMethod,
      'payment_details': (paymentDetails as PaymentDetailsModel).toJson(),
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'items': (items as List<OrderItemModel>).map((e) => e.toJson()).toList(),
    };
  }
}
