part of '../../imports/home_imports.dart';

class CustomNavigationBar extends GetView<HomeController> {
  const CustomNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    return  Obx(
          () {
        return NavigationBar(
          selectedIndex: controller.currentIndex.value,
          onDestinationSelected: controller.updatePage,
          destinations: [
            NavigationDestination(
              icon: const Icon(Icons.home),
              label: AppTrans.dashboard.tr,
            ),
            NavigationDestination(
              icon: const Icon(Icons.favorite_border),
              label: AppTrans.wishlist.tr,
            ),
            NavigationDestination(
              icon: const Icon(Icons.settings),
              label: AppTrans.settings.tr,
            ),
          ],
        );
      },
    );
  }
}
