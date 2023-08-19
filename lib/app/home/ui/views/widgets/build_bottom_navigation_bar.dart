part of '../../imports/home_imports.dart';

class BuildBottomNavigationBar extends StatelessWidget {
  const BuildBottomNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (c) {
        return BottomNavigationBar(
          currentIndex: c.tabC.index,
          onTap: c.onTapTab,
          selectedItemColor: colorScheme.secondary,
          unselectedItemColor: colorScheme.onBackground,
          backgroundColor: colorScheme.background,
          items:  [
            BottomNavigationBarItem(
              icon: const Icon(Icons.home),
              label: AppTrans.home.tr,
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.notifications),
              label: AppTrans.notifications.tr,
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.settings),
              label: AppTrans.settings.tr,
            ),
          ],
        );
      },
    );
  }
}
