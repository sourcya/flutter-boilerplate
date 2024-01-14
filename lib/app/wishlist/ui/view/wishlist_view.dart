part of '../imports/wishlist_imports.dart';

class WishlistView extends GetView<WishlistController> {
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: buildAppBar(title: AppTrans.wishlist.tr),
      mainAxisAlignment: MainAxisAlignment.center,
      child: Center(
        child: FutureBuilder(
          future: EnvManger.instance.testWishlistEnv,
          builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
            return CustomText(
              snapshot.hasData
                  ? snapshot.data!
                  : 'Wishlist',
              style: CustomTextStyle.displayMedium,

            );
          },
        ),
      ),
    );
  }
}
