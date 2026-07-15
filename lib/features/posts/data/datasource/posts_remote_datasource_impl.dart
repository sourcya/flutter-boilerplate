import 'package:boilerplate_ui/core/network/endpoints.dart';
import 'package:boilerplate_ui/core/network/network_service.dart';
import 'package:boilerplate_ui/features/posts/data/datasource/posts_remote_datasource.dart';
import 'package:boilerplate_ui/features/posts/data/model/api/api_post.dart';
import 'package:dio/dio.dart';

class PostsRemoteDatasourceImpl implements PostsRemoteDatasource {
  final NetworkService _api;
  PostsRemoteDatasourceImpl({required NetworkService api}) : _api = api;

  @override
  Future<List<ApiPost>> getPosts({CancelToken? cancelToken}) {
    return _api.get(
      endpoint: Endpoints.posts,
      cancelToken: cancelToken,
      mapper: (json) =>
          (json as List).map((item) => ApiPost.fromJson(item)).toList(),
    );
  }

  @override
  Future<ApiPost> getPostById(int id, {CancelToken? cancelToken}) {
    return _api.get(
      endpoint: Endpoints.postById(id),
      cancelToken: cancelToken,
      mapper: ApiPost.fromJson,
    );
  }
}
