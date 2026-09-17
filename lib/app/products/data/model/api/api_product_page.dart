import 'package:flutter_boilerplate/app/products/data/model/api/api_product.dart';
import 'package:playx/playx.dart';

/// Raw envelope for `GET /products` on dummyjson.com:
/// `{"products": [...], "total": N, "skip": Y, "limit": X}`.
///
/// Kept separate from [ApiProduct] since pagination needs `total` from the
/// envelope, not just the `products` array.
class ApiProductPage {
  final List<ApiProduct> products;
  final int total;

  const ApiProductPage({
    this.products = const [],
    this.total = 0,
  });

  factory ApiProductPage.fromJson(dynamic source) {
    final json = source as Map<String, dynamic>;
    final rawProducts = json['products'];
    return ApiProductPage(
      products: rawProducts is List
          ? rawProducts.map(ApiProduct.fromJson).toList()
          : const [],
      total: asIntOrNull(json, 'total') ?? 0,
    );
  }
}
