import 'message.dart';

///api error model that can be received from network response.
///can be updated based on the response.
class ApiError {
  int? statusCode;
  String? error;
  String? message;

  ApiError({
    this.statusCode,
    this.error,
    this.message,
  });

  ApiError.fromJson(dynamic json) {
    statusCode = json['statusCode'] as int?;
    error = json['error'] as String?;
    try {
      message = json['message'] as String?;
      // ignore: avoid_catches_without_on_clauses
    } catch (_) {
      try {
        final apiMessage =
        ApiMessage.fromJson((json['message'] as List).firstOrNull);
        message = apiMessage.messages?.firstOrNull?.message;
        // ignore: avoid_catches_without_on_clauses
      } catch (_) {}
    }
  }
}

