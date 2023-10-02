part of '../imports/wishlist_imports.dart';

class WishlistView extends GetView<WishlistController> {
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: buildAppBar(title: AppTrans.wishlist.tr),
          mainAxisAlignment: MainAxisAlignment.center,
      child: const Center(
        child: CustomText('Wishlist', style: CustomTextStyle.displayMedium,),
      ),
    );
  }
}
