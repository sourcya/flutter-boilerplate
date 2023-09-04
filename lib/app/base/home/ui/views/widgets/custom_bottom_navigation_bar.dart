part of '../../imports/home_imports.dart';

class CustomBottomNavigationBar extends GetView<HomeController> {
  const CustomBottomNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    return  Container(
      clipBehavior: Clip.hardEdge, //or better look(and cost) using clip.antialias,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(30), topLeft: Radius.circular(30),),
        boxShadow: [
          BoxShadow(color: colorScheme.bottomBarShadowColor!, blurRadius: 10),
        ],
      ),
      child: Obx(
            () {
          return BottomNavigationBar(
            currentIndex: controller.currentIndex.value,
            onTap: controller.updatePage,
            selectedItemColor: colorScheme.onBackground,
            unselectedItemColor: colorScheme.bottomBarUnselectedColor,
            backgroundColor: colorScheme.appBar,
            items: [
              BottomNavigationBarItem(
                icon: IconViewer(
                  icon: Icons.home,
                  iconSize: 11,
                  iconColor: colorScheme.bottomBarUnselectedColor,
                ),
                label: AppTrans.dashboard.tr,
                activeIcon: IconViewer(
                  icon: Icons.home,
                  iconSize: 11,
                  iconColor: colorScheme.onBackground,
                ),
              ),
              BottomNavigationBarItem(
                icon: IconViewer(
                  icon: Icons.favorite_border,
                  iconSize: 11,
                  iconColor: colorScheme.bottomBarUnselectedColor,
                ),
                activeIcon: IconViewer(
                  icon: Icons.favorite_border,
                  iconSize: 11,
                  iconColor: colorScheme.onBackground,
                ),
                label: AppTrans.wishlist.tr,
              ),
              BottomNavigationBarItem(
                icon:   Icon(Icons.settings, color:colorScheme.bottomBarUnselectedColor),
                activeIcon: Icon(Icons.settings, color:colorScheme.onBackground) ,
                label: AppTrans.settings.tr,
              ),
            ],
          );
        },
      ),
    );
  }
}
