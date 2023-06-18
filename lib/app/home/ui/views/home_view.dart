import 'package:flutter/material.dart';
import 'package:playx/playx.dart';

import '../../../../core/navigation/app_routes.dart';
import '../../../../core/resources/colors/app_color_scheme.dart';
import '../../../../core/widgets/no_data_widget.dart';
import '../../../../core/widgets/rx_data_state_widget.dart';
import '../../../auth/data/repo/google_auth_repository.dart';
import '../controllers/home_controller.dart';

/// home screen widget.
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
          //page1
          ColoredBox(
            color: colorScheme.background,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Center(child: Text('Home')),
                ElevatedButton(
                  onPressed: () {
                    GoogleAuthRepository().signOut();
                    AppTheme.next();
                    Get.toNamed(Routes.LOGIN);
                  },
                  child: const Text('login'),
                ),
                CachedNetworkImage(
                  imageUrl:
                      'https://avatars.githubusercontent.com/u/35397170?s=200&v=4',
                  height: 100,
                ),
              ],
            ),
          ),
          //page2
          ColoredBox(
            color: colorScheme.background,
            child: const NoDataAnimation(),
          ),
          //page3
          RxDataStateWidget(
            rxData: controller.userState,
            onSuccess: (user) {
              return Center(
                child: Text(
                  user.username ?? '',
                  style: TextStyle(color: colorScheme.onBackground),
                ),
              );
            },
            onLoading: (data) => CenterLoading(
              color: colorScheme.secondary,
            ),
            onEmpty: (data) => Container(),
            onNoInternetRetryClicked: () {},
          ),
        ],
      ),
      bottomNavigationBar: GetBuilder<HomeController>(
        builder: (c) {
          return BottomNavigationBar(
            currentIndex: c.tabC.index,
            onTap: c.onTapTab,
            selectedItemColor: colorScheme.secondary,
            unselectedItemColor: colorScheme.onBackground,
            backgroundColor: colorScheme.background,
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
