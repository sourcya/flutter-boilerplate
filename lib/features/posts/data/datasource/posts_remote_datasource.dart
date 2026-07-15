import 'package:boilerplate_ui/features/posts/data/model/api/api_post.dart';
import 'package:dio/dio.dart';

abstract class PostsRemoteDatasource {
  Future<List<ApiPost>> getPosts({CancelToken? cancelToken});
  Future<ApiPost> getPostById(int id, {CancelToken? cancelToken});
}
