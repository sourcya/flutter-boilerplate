import 'package:flutter_boilerplate/app/products/data/model/api/api_product.dart';
import 'package:flutter_boilerplate/app/products/data/model/ui/product.dart';

extension ApiProductMapper on ApiProduct {
  Product toUi() {
    return Product(
      id: id ?? 0,
      title: title ?? '',
      description: description ?? '',
      category: category ?? '',
      price: price?.toDouble() ?? 0,
      rating: rating?.toDouble() ?? 0,
      thumbnail: thumbnail ?? '',
    );
  }
}

extension ApiProductListMapper on List<ApiProduct> {
  List<Product> toUiList() => map((apiProduct) => apiProduct.toUi()).toList();
}
