
import 'package:groceries/features/orders/domain/entities/shipping_address_entities.dart';

class ShippingAddressModel extends ShippingAddressEntity {
  ShippingAddressModel({
    required super.id,
    required super.userId,
    required super.name,
    required super.email,
    required super.phone,
    required super.address,
    required super.city,
    required super.zipCode,
    required super.country,
    required super.isDefault,
    required super.createdAt,
    required super.updatedAt,
  });

  factory ShippingAddressModel.fromJson(Map<String, dynamic> json) {
    return ShippingAddressModel(
      id: json['id'],
      userId: json['user_id'],
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
      address: json['address'],
      city: json['city'],
      zipCode: json['zip_code'],
      country: json['country'],
      isDefault: json['is_default'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'name': name,
      'email': email,
      'phone': phone,
      'address': address,
      'city': city,
      'zip_code': zipCode,
      'country': country,
      'is_default': isDefault,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}
