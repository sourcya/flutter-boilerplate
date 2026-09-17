part of '../../imports/products_imports.dart';

class ProductGridTileWidget extends StatelessWidget {
  final Product product;

  const ProductGridTileWidget({required this.product, super.key});

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      padding: EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(8.r)),
            child: AspectRatio(
              aspectRatio: 1.4,
              child: ImageViewer.cachedNetwork(
                product.thumbnail,
                width: double.infinity,
              ),
            ),
          ),
          Padding(
            padding: context.paddingAll(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  product.title,
                  isTranslatable: false,
                  fontWeight: FontWeight.w600,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                4.hBox,
                FeatureChip(
                  label: product.category,
                  isLabelTranslatable: false,
                  defaultVerticalPadding: 4,
                ),
                4.hBox,
                CustomText(
                  '\$${product.price.toStringAsFixed(2)}',
                  isTranslatable: false,
                  color: context.colors.primary,
                  fontWeight: FontWeight.w600,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
