part of '../../../ui.dart';

abstract class BasePagedController<T> extends GetxController {
  // -----------------------
  // UI State
  // -----------------------
  final isTableView = false.obs;

  final searchController = TextEditingController();
  final RxString searchQuery = ''.obs;

  // -----------------------
  // Paging
  // -----------------------
  late final PagingController<int, T> pagingController = PagingController(
    firstPageKey: 1,
  );

  CancelToken? _cancelToken;

  // -----------------------
  // Abstract: Child must implement fetching logic
  // -----------------------
  Future<NetworkResult<DataWrapper<List<T>>>> fetchPage({
    required int pageKey,
    CancelToken? cancelToken,
  });

  // -----------------------
  // Init
  // -----------------------
  @override
  void onInit() {
    isTableView.value = ScreenUtil().screenWidth > 900;
    super.onInit();
    pagingController.addPageRequestListener(_handlePageRequest);
  }

  // -----------------------
  // Handle paging
  // -----------------------
  Future<void> _handlePageRequest(int pageKey) async {
    try {
      // cancel previous
      _cancelToken?.cancel("cancelled previous");
      _cancelToken = CancelToken();

      final res = await fetchPage(pageKey: pageKey, cancelToken: _cancelToken);

      res.when(
        success: (data) {
          final items = data.data;
          final isLastPage = data.isLastPage;
          if (items.isEmpty && pageKey == 1 && isLastPage) {
            pagingController.error = const DataError.empty(
              error: AppTrans.emptyResponse,
            );
            return;
          }
          if (isLastPage) {
            pagingController.appendLastPage(items);
          } else {
            pagingController.appendPage(items, pageKey + 1);
          }
        },
        error: (error) {
          if (error is RequestCanceledException) return;
          pagingController.error = error.message;
        },
      );
    } catch (e) {
      if (e is RequestCanceledException) return;
      pagingController.error = e.toString();
    }
  }

  /// default page size
  int get pageSize => 25;

  // -----------------------
  // Refresh
  // -----------------------
  Future<void> refreshData() async {
    pagingController.refresh();
  }

  // -----------------------
  // Search
  // -----------------------
  void updateSearch(String query) {
    searchQuery.value = query;
    refreshData();
  }

  // -----------------------
  // Optional filters hook
  // -----------------------
  void applyFilters() {
    refreshData();
  }

  // -----------------------
  // Dispose
  // -----------------------
  @override
  void onClose() {
    pagingController.dispose();
    _cancelToken?.cancel("controller disposed");
    super.onClose();
  }
}
