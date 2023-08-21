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
      child: Scaffold(
        extendBody: true,
        body: TabBarView(
          controller: controller.pageController,
          physics: const NeverScrollableScrollPhysics(),
          children: const [
            BuildFirstTab(),
            BuildSecondTab(),
            BuildThirdTab(),
          ],
        ),
        bottomNavigationBar: const CustomBottomNavigationBar(),
      ),
    );
  }
}
