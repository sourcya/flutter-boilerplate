import 'package:boilerplate_ui/features/posts/data/model/ui/post.dart';
import 'package:dio/dio.dart';

abstract class PostsRepository {
  Future<List<Post>> getPosts({CancelToken? cancelToken});
  Future<Post> getPostById(int id, {CancelToken? cancelToken});
}
