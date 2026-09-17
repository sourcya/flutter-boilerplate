import 'package:flutter_boilerplate/app/products/data/model/api/api_product_page.dart';
import 'package:flutter_boilerplate/core/network/network.dart';
import 'package:playx/playx.dart';

/// Fetches raw product data from the public dummyjson.com API.
///
/// Uses a dedicated [PlayxNetworkClient] pointed at [Endpoints.productsBaseUrl]
/// (see DI registration in `ProductsRepository.registerInstance`) - never the
/// app's own authenticated `ApiClient`, since that would leak the app's
/// Bearer token to a third-party API.
abstract class ProductsDatasource {
  Future<NetworkResult<ApiProductPage>> fetchProducts({
    int limit = 30,
    int skip = 0,
    CancelToken? cancelToken,
  });
}

class ProductsDatasourceImpl implements ProductsDatasource {
  final PlayxNetworkClient client;

  ProductsDatasourceImpl({required this.client});

  @override
  Future<NetworkResult<ApiProductPage>> fetchProducts({
    int limit = 30,
    int skip = 0,
    CancelToken? cancelToken,
  }) {
    return client.get<ApiProductPage>(
      Endpoints.products,
      query: {'limit': limit, 'skip': skip},
      fromJson: ApiProductPage.fromJson,
      cancelToken: cancelToken,
    );
  }
}
