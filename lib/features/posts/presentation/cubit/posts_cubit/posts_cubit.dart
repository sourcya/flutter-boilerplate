import 'package:boilerplate_ui/core/data_state/request_state.dart';
import 'package:boilerplate_ui/core/services/request_helper.dart';
import 'package:boilerplate_ui/features/posts/data/model/ui/post.dart';
import 'package:boilerplate_ui/features/posts/data/repository/posts_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'posts_state.dart';

class PostsCubit extends Cubit<PostsState> {
  final PostsRepository _repository;

  PostsCubit({required PostsRepository repository})
      : _repository = repository,
        super(const PostsInitial());

  List<Post>? posts;

  Future<void> getPosts({bool refresh = false}) async {
    await RequestHelper.execute<List<Post>, GetPostsState>(
      emit: emit,
      stateFactory: GetPostsState.new,
      request: () => _repository.getPosts(),
      onSuccess: (data) => posts = data,
      refresh: refresh,
    );
  }

  @override
  Future<void> close() {
    return super.close();
  }
}
