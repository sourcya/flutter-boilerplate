import 'package:flutter/material.dart';
import 'package:playx/playx.dart';

import '../../../../core/data_state/widgets/rx_data_state_widget.dart';
import '../../../../core/navigation/app_routes.dart';
import '../../../../core/resources/colors/app_color_scheme.dart';
import '../../../../core/resources/translation/app_translations.dart';
import '../../../../core/widgets/no_data_widget.dart';
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
        title:  Text(AppTrans.home.tr),
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
                  Center(child: Text(AppTrans.home.tr)),
                ElevatedButton(
                  onPressed: () {
                    GoogleAuthRepository().signOut();
                    AppTheme.next();
                    Get.toNamed(Routes.LOGIN);
                  },
                  child:  Text(AppTrans.loginText.tr),
                ),
                CachedNetworkImage(
                  imageUrl:
                      'https://avatars.githubusercontent.com/u/35397170?s=200&v=4',
                  height: 100.h,
                ),
                ElevatedButton(
                  onPressed: () {
                    Get.toNamed(Routes.Settings);
                  },
                  child: Text(AppTrans.settings.tr),
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
                  user.username ?? 'not found',
                  style: TextStyle(
                      color: colorScheme.onBackground, fontSize: 14.sp),
                ),
              );
            },
            onLoading: (data) => CenterLoading(
              color: colorScheme.secondary,
            ),
            onEmpty: (e) => Center(
                child: Text(e, style: const TextStyle(color: Colors.red))),
            onError: (e) => Center(
                child: Text(e, style: const TextStyle(color: Colors.red))),
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
            items:  [
              BottomNavigationBarItem(
                icon: const Icon(Icons.home),
                label: AppTrans.home.tr,
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.notifications),
                label: AppTrans.notifications.tr,
              ),
              BottomNavigationBarItem(
                icon: const Icon(Icons.settings),
                label: AppTrans.settings.tr,
              ),
            ],
          );
        },
      ),
    );
  }
}
