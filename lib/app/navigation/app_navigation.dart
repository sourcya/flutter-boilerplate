import 'package:boilerplate_ui/app/navigation/app_pages.dart';
import 'package:boilerplate_ui/app/navigation/routes.dart';

abstract final class AppNavigation {
  static void toPosts() {
    appRouter.goNamed(Routes.posts);
  }

  static void toPostDetails({required int id}) {
    appRouter.pushNamed(
      Routes.postDetails,
      pathParameters: {'id': id.toString()},
    );
  }

  static void pop() {
    appRouter.pop();
  }
}
