import 'package:boilerplate_ui/core/utils/safe_json_convert.dart';

class ApiPost {
  final int id;
  final int userId;
  final String title;
  final String body;

  const ApiPost({
    required this.id,
    required this.userId,
    required this.title,
    required this.body,
  });

  factory ApiPost.fromJson(dynamic json) {
    return ApiPost(
      id: asIntOr(json, 'id'),
      userId: asIntOr(json, 'userId'),
      title: asStringOr(json, 'title'),
      body: asStringOr(json, 'body'),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'title': title,
      'body': body,
    };
  }
}
