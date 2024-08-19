part of '../imports/dashboard_imports.dart';

class DashboardView extends GetView<DashboardController> {
  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      title: AppTrans.dashboard,
      leading: AppBarLeadingType.drawerOrRail,
      child: RxDataStateWidget(
        rxData: controller.dataState,
        onSuccess: (items) => ListView.builder(
          itemCount: items.length,
          itemBuilder: (context, index) {
            final item = items[index];
            return InkWell(
              onTap: () {},
              child: CustomCard(
                padding: EdgeInsets.zero,
                child: Stack(
                  children: [
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        SizedBox(
                          height: 200,
                          width: double.infinity,
                          child: ImageViewer.cachedNetwork(
                            item.imageUrl,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 12.0.w,
                            vertical: 12.h,
                          ),
                          child: CustomText(
                            item.name,
                            style: CustomTextStyle.titleMedium,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            right: 12.0.w,
                            left: 12.w,
                            bottom: 8.h,
                          ),
                          child: CustomText(
                            item.description,
                            maxLines: 3,
                            color: context.colors.onSurface,
                          ),
                        ),
                      ],
                    ),
                    Align(
                      alignment: Alignment.topRight,
                      child: Padding(
                        padding: EdgeInsets.all(8.0.r),
                        child: FloatingActionButton(
                          mini: true,
                          onPressed: null,
                          heroTag: null,
                          backgroundColor:
                              context.colors.surface.withOpacity(.85),
                          child: FavoriteButton(
                            isInFavorite: item.isFavorite,
                            onFavoriteChanged: (isFavorite) {
                              controller.onFavoriteChanged(isFavorite, item);
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
