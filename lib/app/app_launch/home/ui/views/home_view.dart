part of '../imports/home_imports.dart';

/// home screen widget.
class HomeView extends GetView<HomeController> {
  const HomeView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: controller.handleWillPop,
      child: PlatformTabScaffold(
        itemChanged: (index) {
          controller.currentIndex.value = index;
        },
        tabController: controller.pageController,
        items: [
          BottomNavigationBarItem(
            icon: const Icon(Icons.home),
            label: AppTrans.dashboard.tr,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.favorite_border),
            label: AppTrans.wishlist.tr,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.settings),
            label: AppTrans.settings.tr,
          ),
        ],
        bodyBuilder: (ctx, index) =>
           const [
            BuildFirstTab(),
            BuildSecondTab(),
            BuildThirdTab(),
          ][index],
      ),
    );
  }

  bool isTablet(BuildContext context) => context.mediaQuery.size.width >= 600;
}
