import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/core/utils/alert.dart';
import 'package:flutter_boilerplate/core/widgets/no_data_widget.dart';
import 'package:flutter_boilerplate/core/widgets/no_internet_widget.dart';
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
          ColoredBox(
            color: AppThemeConfig.getColorScheme(context).background,
            child: NoDataAnimation(),
          ),
          ColoredBox(
            color: AppThemeConfig.getColorScheme(context).background,
            child: NoInternetAnimation(
              onRetryClicked: () {
                Alert.error(message: "Netowrk");
              },
            ),
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
