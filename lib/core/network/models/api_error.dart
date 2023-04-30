import 'message.dart';

///api error model that can be received from network response.
///can be updated based on the response.
class ApiError {
  int? statusCode;
  String? error;
  List<ApiMessage>? message;

  ApiError({
    this.statusCode,
    this.error,
    this.message,
  });

  ApiError.fromJson(dynamic json) {
    statusCode = json['statusCode'] as int?;
    error = json['error'] as String?;
    if (json['message'] != null) {
      message = [];
      json['message'].forEach((v) {
        message?.add(ApiMessage.fromJson(v));
      });
    }
  }
}
