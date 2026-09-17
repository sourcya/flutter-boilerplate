part of '../../imports/products_imports.dart';

class ProductListTileWidget extends StatelessWidget {
  final Product product;

  const ProductListTileWidget({required this.product, super.key});

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8.r),
            child: ImageViewer.cachedNetwork(
              product.thumbnail,
              width: 64.r,
              height: 64.r,
            ),
          ),
          12.wBox,
          Expanded(
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
              ],
            ),
          ),
          12.wBox,
          CustomText(
            '\$${product.price.toStringAsFixed(2)}',
            isTranslatable: false,
            color: context.colors.primary,
            fontWeight: FontWeight.w600,
          ),
        ],
      ),
    );
  }
}
