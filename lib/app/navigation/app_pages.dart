import 'package:boilerplate_ui/app/navigation/routes.dart';
import 'package:boilerplate_ui/features/posts/presentation/pages/post_details_page.dart';
import 'package:boilerplate_ui/features/posts/presentation/pages/posts_list_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

final GoRouter appRouter = GoRouter(
  navigatorKey: navigatorKey,
  initialLocation: Paths.posts,
  routes: [
    GoRoute(
      path: Paths.posts,
      name: Routes.posts,
      builder: (context, state) => const PostsListPage(),
    ),
    GoRoute(
      path: Paths.postDetails,
      name: Routes.postDetails,
      builder: (context, state) {
        final id = int.parse(state.pathParameters['id']!);
        return PostDetailsPage(postId: id);
      },
    ),
  ],
);
