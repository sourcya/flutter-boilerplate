part of '../imports/products_imports.dart';

class ProductsController extends BasePagedController<Product> {
  final ProductsRepository _repository = ProductsRepository.instance;

  /// Grid vs list toggle for this feature's UI - distinct from
  /// [BasePagedController.isTableView], which drives a table-vs-cards axis
  /// this feature does not use.
  final isGridView = true.obs;

  @override
  Future<NetworkResult<DataWrapper<List<Product>>>> fetchPage({
    required int pageKey,
    CancelToken? cancelToken,
  }) {
    return _repository.getPaginatedProducts(
      page: pageKey,
      cancelToken: cancelToken,
    );
  }

  void toggleView() => isGridView.value = !isGridView.value;
}
