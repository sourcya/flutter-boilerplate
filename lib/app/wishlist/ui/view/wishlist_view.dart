part of '../imports/wishlist_imports.dart';

class WishlistView extends GetView<WishlistController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(title: AppTrans.wishlist.tr),
      body:  OptimizedScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(AppTrans.wishlist.tr),
          ],
        ),
      ),
    );
  }
}
