part of '../imports/products_imports.dart';

/// Reference/demo feature: fetches products from a public API
/// (dummyjson.com) and renders them in a toggleable grid/list view.
///
/// Showcases this boilerplate's own conventions: feature-scoped data/ui
/// layers, [BasePagedController] + [ResponsivePagedSliverView] for paged
/// loading/success/error handling, and the Custom* design system widgets.
class ProductsView extends GetView<ProductsController> {
  const ProductsView({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      title: AppTrans.productsTitle,
      backgroundColor: context.isWideLayout
          ? context.colors.surface
          : context.colors.bgMuted50,
      isWideWeb: context.isWideLayout,
      showWhatsAppSupport: true,
      actions: [
        CustomGirdListSwitch(
          isGridView: controller.isGridView,
          hideOnSmallScreenWidth: false,
        ),
      ],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: context.paddingSymmetric(horizontal: 16, vertical: 16),
            child: CustomText(
              AppTrans.productsSubtitle,
              color: context.colors.mutedForeground,
              fontSize: 13.sp,
            ),
          ),
          Expanded(
            child: Obx(
              () => RefreshIndicator.adaptive(
                onRefresh: controller.refreshData,
                child: CustomScrollView(
                  slivers: [
                    ResponsivePagedSliverView<int, Product>(
                      pagingController: controller.pagingController,
                      emptyDataMessage: AppTrans.emptyResponse,
                      separated: !controller.isGridView.value,
                      responsiveCrossAxisCounts: controller.isGridView.value
                          ? {0: 2, 600: 3, 1080: 4}
                          : {0: 1},
                      itemBuilder: (context, item, index) =>
                          controller.isGridView.value
                          ? ProductGridTileWidget(product: item)
                          : ProductListTileWidget(product: item),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
