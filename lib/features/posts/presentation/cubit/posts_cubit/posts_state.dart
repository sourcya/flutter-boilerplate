part of 'posts_cubit.dart';

sealed class PostsState extends RequestState {
  const PostsState({
    super.status,
    super.message,
  });
}

class PostsInitial extends PostsState {
  const PostsInitial();
}

class GetPostsState extends PostsState {
  const GetPostsState({
    required super.status,
    super.message,
  });
}
