part of '../imports/wishlist_imports.dart';

class WishlistView extends GetView<WishlistController> {
  @override
  Widget build(BuildContext context) {
    return RxDataStateWidget(
      rxData: controller.dataState,
      onSuccess: (data) {
        return ListView.builder(
          itemCount: data.length,
          itemBuilder: (context, index) {
            final item = data[index];
            return CustomCard(
              padding: EdgeInsets.zero,
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 200,
                    width: double.infinity,
                    child: ImageViewer.cachedNetwork(
                      item.imageUrl ??
                          'https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885_1280.jpg',
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 12.0.w,
                      vertical: 12.h,
                    ),
                    child: CustomText(
                      item.name ?? "Lorem ipsum",
                      style: CustomTextStyle.titleMedium,
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
