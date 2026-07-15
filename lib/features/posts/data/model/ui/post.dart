import 'package:equatable/equatable.dart';

class Post extends Equatable {
  final int id;
  final int userId;
  final String title;
  final String body;

  const Post({
    required this.id,
    required this.userId,
    required this.title,
    required this.body,
  });

  String get truncatedBody {
    if (body.length <= 100) return body;
    return '${body.substring(0, 100)}...';
  }

  @override
  List<Object?> get props => [id, userId, title, body];
}
