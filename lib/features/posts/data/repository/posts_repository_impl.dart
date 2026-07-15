import 'package:boilerplate_ui/features/posts/data/datasource/posts_remote_datasource.dart';
import 'package:boilerplate_ui/features/posts/data/model/mapper/post_mapper.dart';
import 'package:boilerplate_ui/features/posts/data/model/ui/post.dart';
import 'package:boilerplate_ui/features/posts/data/repository/posts_repository.dart';
import 'package:dio/dio.dart';

class PostsRepositoryImpl implements PostsRepository {
  final PostsRemoteDatasource _datasource;

  PostsRepositoryImpl({required PostsRemoteDatasource datasource})
      : _datasource = datasource;

  @override
  Future<List<Post>> getPosts({CancelToken? cancelToken}) async {
    final apiPosts = await _datasource.getPosts(cancelToken: cancelToken);
    return apiPosts.toUi();
  }

  @override
  Future<Post> getPostById(int id, {CancelToken? cancelToken}) async {
    final apiPost = await _datasource.getPostById(id, cancelToken: cancelToken);
    return apiPost.toUi();
  }
}
