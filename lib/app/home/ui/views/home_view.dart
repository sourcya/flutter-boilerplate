part of '../imports/home_imports.dart';

/// home screen widget.
class HomeView extends GetView<HomeController> {
  const HomeView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(title: AppTrans.home.tr),
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
      bottomNavigationBar: const BuildBottomNavigationBar(),
    );
  }
}
