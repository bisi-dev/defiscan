class ErrorResponse {
  final int statusCode;
  final dynamic body;

  ErrorResponse({required this.statusCode, required this.body});

  Map<String, dynamic> toJson() => {"statusCode": statusCode, "body": body};

  factory ErrorResponse.fromJson(dynamic json) =>
      ErrorResponse(statusCode: json['statusCode'], body: json['body']);

  factory ErrorResponse.genericException(int statusCode, dynamic body) =>
      ErrorResponse(statusCode: statusCode, body: body);

  factory ErrorResponse.socketException() =>
      ErrorResponse(statusCode: 500, body: 'Check your internet connection');

  factory ErrorResponse.handshakeException() =>
      ErrorResponse(statusCode: 500, body: 'Server Down');

  factory ErrorResponse.formatException() => ErrorResponse(
      statusCode: 500, body: 'Service unavailable, please try again later');
}
