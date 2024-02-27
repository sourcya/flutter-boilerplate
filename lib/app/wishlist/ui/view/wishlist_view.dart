part of '../imports/wishlist_imports.dart';

class WishlistView extends GetView<WishlistController> {
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: buildAppBar(title: AppTrans.wishlist.tr),
      mainAxisAlignment: MainAxisAlignment.center,
      hasScrollBody: true,
      child: Center(
        child: RxDataStateWidget(
          rxData: controller.dataState,
          onSuccess: (data) {
            return CustomText(
              data,
              style: CustomTextStyle.displayMedium,
            );
          },
        ),
      ),
    );
  }
}
