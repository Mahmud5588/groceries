
import 'package:groceries/features/payment/domain/entites/payment_details_entites.dart';

class PaymentDetailsModel extends PaymentDetailsEntity {
  PaymentDetailsModel({
    required super.paymentId,
    required super.method,
    required super.cardType,
    required super.maskedCardNumber,
    required super.status,
    required super.timestamp,
  });

  factory PaymentDetailsModel.fromJson(Map<String, dynamic> json) {
    return PaymentDetailsModel(
      paymentId: json['payment_id'],
      method: json['method'],
      cardType: json['card_type'],
      maskedCardNumber: json['masked_card_number'],
      status: json['status'],
      timestamp: DateTime.parse(json['timestamp']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'payment_id': paymentId,
      'method': method,
      'card_type': cardType,
      'masked_card_number': maskedCardNumber,
      'status': status,
      'timestamp': timestamp.toIso8601String(),
    };
  }
}
