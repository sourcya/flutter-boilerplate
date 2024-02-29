part of '../imports/home_imports.dart';

/// home screen widget.
class HomeView extends GetView<HomeController> {
  const HomeView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const SizedBox.shrink();
  }

  bool isTablet(BuildContext context) => context.mediaQuery.size.width >= 600;
}
