part of 'post_details_cubit.dart';

sealed class PostDetailsState extends RequestState {
  const PostDetailsState({
    super.status,
    super.message,
  });
}

class PostDetailsInitial extends PostDetailsState {
  const PostDetailsInitial();
}

class GetPostDetailsState extends PostDetailsState {
  const GetPostDetailsState({
    required super.status,
    super.message,
  });
}