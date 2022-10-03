import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/app/modules/home/controllers/home_controller.dart';
import 'package:flutter_boilerplate/app/routes/app_pages.dart';
import 'package:get/get.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HomeView'),
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
                    Get.toNamed(Routes.SIGN_IN);
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
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          // sets the background color of the `BottomNavigationBar`
          canvasColor: const Color(0xFF00354f),
        ), //
        child: GetBuilder<HomeController>(
          builder: (c) {
            return BottomNavigationBar(
              currentIndex: c.tabC.index,
              onTap: c.onTapTab,
              selectedItemColor: context.theme.colorScheme.secondary,
              unselectedItemColor: Colors.white,
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
      ),
    );
  }
}
