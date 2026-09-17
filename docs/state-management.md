# State Management

- **Controllers**: `GetxController` subclasses hold all business logic; views only call `controller.method()` or read `.obs`/`Rx` fields via `Obx`/`GetView`.
- **Paginated lists**: extend `BasePagedController<T>` (`lib/core/ui/widgets/view/controller/base_paged_controller.dart`). You implement one method, `fetchPage({required int pageKey, CancelToken? cancelToken})` returning `Future<NetworkResult<DataWrapper<List<T>>>>`; the base class owns the `PagingController<int, T>`, request de-duplication/cancellation, `refreshData()`, and search/filter hooks. `Products` is the minimal example:

  ```dart
  // lib/app/products/ui/controller/products_controller.dart
  class ProductsController extends BasePagedController<Product> {
    final ProductsRepository _repository = ProductsRepository.instance;

    @override
    Future<NetworkResult<DataWrapper<List<Product>>>> fetchPage({
      required int pageKey,
      CancelToken? cancelToken,
    }) {
      return _repository.getPaginatedProducts(page: pageKey, cancelToken: cancelToken);
    }
  }
  ```

  `DataWrapper<T>` (`lib/core/models/src/data_wrapper.dart`) wraps `data` plus an optional `PageInfo` (`page`, `pageSize`, `pageCount`, `total`); `PageInfo.isLastPage` (`page >= pageCount`) tells the paging controller when to stop requesting pages. Render the result with `ResponsivePagedSliverView<int, T>` (`lib/core/ui/widgets/custom_sliver_pagination_list.dart`) inside a `CustomScrollView`'s slivers, as `ProductsView` does.

- **Non-paginated reactive state**: use `DataState<T>` (`lib/core/ui/data_state/models/data_state.dart`) instead of boolean flags. Render it with `DataStateWidget<T>` (`lib/core/ui/data_state/widgets/data_state_widget.dart`), or its reactive wrapper `RxDataStateWidget<T>` (`lib/core/ui/data_state/widgets/rx_data_state_widget.dart`) if you'd rather pass an `Rx<DataState<T>>` directly instead of unwrapping it yourself in an `Obx`. For content living inside a `CustomScrollView`'s slivers, use the sliver counterparts `SliverDataStateWidget<T>` / `RxSliverDataStateWidget<T>` under `lib/core/ui/data_state/sliver/`. See [Error Handling](error-handling.md) for the full API.
- **Global blocking overlays**: `AppController.instance.loadingStatus` (an `Rx<LoadingStatus>`, `lib/app/app_launch/app/ui/controller/app_controller.dart`) drives a full-screen loading overlay for actions that should block all input (login, logout, destructive actions). Always reset it to `LoadingStatus.idle()` in a `finally` block.
- **Cleanup**: dispose text controllers, cancel `Rx` workers, and cancel any `CancelToken`s in `onClose()`. `BasePagedController.onClose()` already disposes its own `pagingController`, `searchController`, and `isLoadingListenable`, and cancels its in-flight `CancelToken` — mirror that pattern in your own controllers.

Continue to [Networking](networking.md) for how `fetchPage`/repositories actually talk to an API.
