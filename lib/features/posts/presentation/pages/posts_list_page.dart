import 'package:boilerplate_ui/app/di/dependency_injection.dart';
import 'package:boilerplate_ui/core/data_state/data_state.dart';
import 'package:boilerplate_ui/core/widgets/data_state_builder_widget.dart';
import 'package:boilerplate_ui/features/posts/data/model/ui/post.dart';
import 'package:boilerplate_ui/features/posts/presentation/cubit/posts_cubit/posts_cubit.dart';
import 'package:boilerplate_ui/features/posts/presentation/pages/posts_success_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostsListPage extends StatefulWidget {
  const PostsListPage({super.key});

  @override
  State<PostsListPage> createState() => _PostsListPageState();
}

class _PostsListPageState extends State<PostsListPage> {
  late final PostsCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = sl<PostsCubit>()..getPosts();
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
        title: const Text('Posts'),
      ),
      body: BlocBuilder<PostsCubit, PostsState>(
        bloc: _cubit,
        builder: (context, state) {
          return DataStateBuilderWidget<List<Post>>(
            dataState: DataState<List<Post>>(
              state: state,
              data: _cubit.posts,
            ),
            onRefresh: () => _cubit.getPosts(refresh: true),
            onFailure: () => _cubit.getPosts(),
            onSuccess: (posts) => PostsSuccessWidget(posts: posts),
          );
        },
      ),
    );
  }
}
