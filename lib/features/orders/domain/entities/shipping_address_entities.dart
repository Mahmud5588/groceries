class ShippingAddressEntity {
  final int id;
  final int userId;
  final String name;
  final String email;
  final String phone;
  final String address;
  final String city;
  final String zipCode;
  final String country;
  final bool isDefault;
  final DateTime createdAt;
  final DateTime updatedAt;

  ShippingAddressEntity({
    required this.id,
    required this.userId,
    required this.name,
    required this.email,
    required this.phone,
    required this.address,
    required this.city,
    required this.zipCode,
    required this.country,
    required this.isDefault,
    required this.createdAt,
    required this.updatedAt,
  });
}
