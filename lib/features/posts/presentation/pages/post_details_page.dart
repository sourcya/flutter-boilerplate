import 'package:boilerplate_ui/app/di/dependency_injection.dart';
import 'package:boilerplate_ui/core/data_state/data_state.dart';
import 'package:boilerplate_ui/core/widgets/data_state_builder_widget.dart';
import 'package:boilerplate_ui/features/posts/data/model/ui/post.dart';
import 'package:boilerplate_ui/features/posts/presentation/cubit/post_details_cubit/post_details_cubit.dart';
import 'package:boilerplate_ui/features/posts/presentation/pages/post_details_success_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostDetailsPage extends StatefulWidget {
  final int postId;

  const PostDetailsPage({super.key, required this.postId});

  @override
  State<PostDetailsPage> createState() => _PostDetailsPageState();
}

class _PostDetailsPageState extends State<PostDetailsPage> {
  late final PostDetailsCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = sl<PostDetailsCubit>()..getPostById(widget.postId);
  }

  @override
  void dispose() {
    _cubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Post Details'),
      ),
      body: BlocBuilder<PostDetailsCubit, PostDetailsState>(
        bloc: _cubit,
        builder: (context, state) {
          return DataStateBuilderWidget<Post>(
            dataState: DataState<Post>(
              state: state,
              data: _cubit.post,
            ),
            onFailure: () => _cubit.getPostById(widget.postId),
            onSuccess: (post) => PostDetailsSuccessWidget(post: post),
          );
        },
      ),
    );
  }
}
