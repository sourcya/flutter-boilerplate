import 'package:flutter_boilerplate/app/products/data/datasource/products_datasource.dart';
import 'package:flutter_boilerplate/app/products/data/model/mapper/product_mapper.dart';
import 'package:flutter_boilerplate/app/products/data/model/ui/product.dart';
import 'package:flutter_boilerplate/core/models/models.dart';
import 'package:flutter_boilerplate/core/network/network.dart';
import 'package:playx/playx.dart';

/// Fixed page size used when paginating dummyjson.com's `/products` endpoint.
const int _kProductsPageSize = 20;

abstract class ProductsRepository {
  static ProductsRepository get instance => getIt<ProductsRepository>();

  /// Registers this feature's datasource/repository, lazily and idempotently.
  ///
  /// Called from `ProductsBinding.onInitApp()` so it happens once, before the
  /// route's `onEnter` puts the controller - never in `AppConfig.bootDependencies`
  /// (this is a feature-scoped, route-owned dependency, not an app-wide one).
  static void registerInstance() {
    if (!getIt.isRegistered<ProductsDatasource>()) {
      // Extension point: Products is a reference/demo feature that fetches
      // from a public third-party API (dummyjson.com). It intentionally uses
      // its own [PlayxNetworkClient] instance instead of `ApiClient.client`
      // so the app's Bearer auth token is never sent to a third-party API.
      final productsClient = PlayxNetworkClient(
        dio: PlayxNetworkClient.createDefaultDioClient(
          baseUrl: Endpoints.productsBaseUrl,
        ),
      );
      getIt.registerLazySingleton<ProductsDatasource>(
        () => ProductsDatasourceImpl(client: productsClient),
      );
    }
    if (!getIt.isRegistered<ProductsRepository>()) {
      getIt.registerLazySingleton<ProductsRepository>(
        () => ProductsRepositoryImpl(dataSource: getIt<ProductsDatasource>()),
      );
    }
  }

  Future<NetworkResult<DataWrapper<List<Product>>>> getPaginatedProducts({
    required int page,
    CancelToken? cancelToken,
  });
}

class ProductsRepositoryImpl implements ProductsRepository {
  final ProductsDatasource _dataSource;

  ProductsRepositoryImpl({
    required ProductsDatasource dataSource,
  }) : _dataSource = dataSource;

  @override
  Future<NetworkResult<DataWrapper<List<Product>>>> getPaginatedProducts({
    required int page,
    CancelToken? cancelToken,
  }) {
    final skip = (page - 1) * _kProductsPageSize;
    return _dataSource
        .fetchProducts(
      limit: _kProductsPageSize,
      skip: skip,
      cancelToken: cancelToken,
    )
        .then((res) {
      return res.mapDataAsyncInIsolate(
        mapper: (apiPage) => Future.value(
          NetworkResult.success(
            DataWrapper<List<Product>>(
              data: apiPage.products.toUiList(),
              pagination: PageInfo(
                page: page,
                pageSize: _kProductsPageSize,
                pageCount: apiPage.total == 0
                    ? 1
                    : (apiPage.total / _kProductsPageSize).ceil(),
                total: apiPage.total,
              ),
            ),
          ),
        ),
      );
    });
  }
}
