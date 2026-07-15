import 'package:boilerplate_ui/app/navigation/navigation.dart';
import 'package:boilerplate_ui/features/posts/data/model/ui/post.dart';
import 'package:boilerplate_ui/features/posts/presentation/widgets/post_card_widget.dart';
import 'package:flutter/material.dart';

class PostsSuccessWidget extends StatelessWidget {
  final List<Post> posts;

  const PostsSuccessWidget({super.key, required this.posts});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 8),
      itemCount: posts.length,
      itemBuilder: (context, index) {
        final post = posts[index];
        return PostCardWidget(
          post: post,
          onTap: () {
            AppNavigation.toPostDetails(id: post.id);
          },
        );
      },
    );
  }
}
