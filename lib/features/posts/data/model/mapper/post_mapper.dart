import 'package:boilerplate_ui/features/posts/data/model/api/api_post.dart';
import 'package:boilerplate_ui/features/posts/data/model/ui/post.dart';

extension ApiPostMapper on ApiPost {
  Post toUi() {
    return Post(
      id: id,
      userId: userId,
      title: title,
      body: body,
    );
  }
}

extension ApiPostListMapper on List<ApiPost> {
  List<Post> toUi() {
    return map((e) => e.toUi()).toList();
  }
}
