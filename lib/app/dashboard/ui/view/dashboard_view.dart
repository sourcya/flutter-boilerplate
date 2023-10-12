part of '../imports/dashboard_imports.dart';

class DashboardView extends GetView<DashboardController> {
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      hasScrollBody: true,
      appBar: buildAppBar(title: AppTrans.dashboard.tr),
      child: ListView.builder(
          itemCount: 20,
          itemBuilder: (context, index) {
            return CustomCard(
              padding: EdgeInsets.zero,
              child: Column(
                children: <Widget>[
                  const SizedBox(
                    height: 200,
                    width: double.infinity,
                    child: ImageViewer.cachedNetwork(
                        'https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885_1280.jpg',
                    ),
                  ),
                  Padding(
                    padding:  EdgeInsets.symmetric(horizontal: 12.0.w,vertical: 12.h),
                    child: const CustomText(
                      'Lorem ipsum',
                      style: CustomTextStyle.titleMedium,
                    ),
                  ),
                  Padding(
                    padding:  EdgeInsets.only(right: 12.0.w,left:12.w, bottom: 8.h),
                    child:  CustomText(
                      'Lorem ipsum dolor sit amet, consectetur adipiscing elit sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, consectetur adipiscing elit sed diam nonum y eirmod tempor invidunt ut labore et dol',
                      maxLines: 3,
                      color: colorScheme.onBackground,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
    );
  }
}
