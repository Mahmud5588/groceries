class ErrorResponse {
  final int statusCode;
  final String message;

  ErrorResponse({
    required this.statusCode,
    required this.message,
  });

  factory ErrorResponse.fromJson(Map<String, dynamic> json, int statusCode) =>
      ErrorResponse(
        statusCode: statusCode,
        message: json['message'] ?? 'Unknown error',
      );
}
