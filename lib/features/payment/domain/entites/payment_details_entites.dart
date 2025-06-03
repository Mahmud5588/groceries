class PaymentDetailsEntity {
  final String paymentId;
  final String method;
  final String cardType;
  final String maskedCardNumber;
  final String status;
  final DateTime timestamp;

  PaymentDetailsEntity({
    required this.paymentId,
    required this.method,
    required this.cardType,
    required this.maskedCardNumber,
    required this.status,
    required this.timestamp,
  });
}
