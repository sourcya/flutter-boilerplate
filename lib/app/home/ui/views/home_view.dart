import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:playx/exports.dart';

import '../../../../../core/config/theme.dart';
import '../../../../core/navigation/app_routes.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        centerTitle: true,
      ),
      body: TabBarView(
        physics: const NeverScrollableScrollPhysics(),
        controller: controller.tabC,
        children: [
          ColoredBox(
            color: Colors.green,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Center(child: Text('Home')),
                ElevatedButton(
                  onPressed: () {
                    Get.toNamed(Routes.LOGIN);
                    AppTheme.next();
                  },
                  child: const Text('login'),
                ),
              ],
            ),
          ),
          const ColoredBox(
            color: Colors.red,
            child: Center(child: Text('notifications')),
          ),
          const ColoredBox(
            color: Colors.amber,
            child: Center(child: Text('settings')),
          ),
        ],
      ),
      bottomNavigationBar: GetBuilder<HomeController>(
        builder: (c) {
          return BottomNavigationBar(
            currentIndex: c.tabC.index,
            onTap: c.onTapTab,
            selectedItemColor: AppThemeConfig.getColorScheme(context).secondary,
            unselectedItemColor:
                AppThemeConfig.getColorScheme(context).onBackground,
            backgroundColor: AppThemeConfig.getColorScheme(context).background,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.notifications),
                label: 'notifications',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.settings),
                label: 'settings',
              ),
            ],
          );
        },
      ),
    );
  }
}
