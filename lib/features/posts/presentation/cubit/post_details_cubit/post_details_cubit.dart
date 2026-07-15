import 'package:boilerplate_ui/core/data_state/request_state.dart';
import 'package:boilerplate_ui/core/services/request_helper.dart';
import 'package:boilerplate_ui/features/posts/data/model/ui/post.dart';
import 'package:boilerplate_ui/features/posts/data/repository/posts_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'post_details_state.dart';

class PostDetailsCubit extends Cubit<PostDetailsState> {
  final PostsRepository _repository;

  PostDetailsCubit({required PostsRepository repository})
      : _repository = repository,
        super(const PostDetailsInitial());

  Post? post;
  Future<void> getPostById(int id) async {
    await RequestHelper.execute<Post, GetPostDetailsState>(
      emit: emit,
      stateFactory: GetPostDetailsState.new,
      request: () => _repository.getPostById(id,),
      onSuccess: (data) => post = data,
    );
  }

  @override
  Future<void> close() {
    return super.close();
  }
}
