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

  final RxnInt totalItemsCount = RxnInt();
  final RxnInt totalPagesCount = RxnInt();

  CancelToken? _cancelToken;

  final isLoadingListenable = ValueNotifier(false);

  /// Latest request sequence; stale completions are ignored.
  int _seq = 0;

  /// Set by [updatePageSize] for table row-size changes.
  int? _currentPageSize;

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
    isTableView.value = PlayxNavigation.navigationContext?.isAppLandscape ?? false;
    super.onInit();
    pagingController.addPageRequestListener(_handlePageRequest);
  }

  // -----------------------
  // Handle paging
  // -----------------------
  Future<void> _handlePageRequest(int pageKey) async {
    final id = ++_seq;
    isLoadingListenable.value = true;
    try {
      // Cancel previous in-flight network call (CancelToken). Package-level
      // CancelableOperation from notifyPageRequestListeners is also cancelled
      // by [PagingController.refresh], but does not stop this handler body.
      _cancelToken?.cancel("cancelled previous");
      _cancelToken = CancelToken();

      final res = await fetchPage(pageKey: pageKey, cancelToken: _cancelToken);

      // Stale after a newer refresh/page request — do not touch controller.
      if (id != _seq) return;

      res.when(
        success: (data) {
          final items = data.data;
          final isLastPage = data.isLastPage;

          totalItemsCount.value = data.pagination?.total;
          totalPagesCount.value = data.pagination?.pageCount;

          if (items.isEmpty && pageKey == 1 && isLastPage) {
            pagingController.error = const DataError.empty(
              error: AppTrans.emptyResponse,
            );
            return;
          }
          final pageItems = _visiblePageItems(items);
          if (isLastPage) {
            pagingController.appendLastPage(pageItems);
          } else {
            pagingController.appendPage(pageItems, pageKey + 1);
          }
        },
        error: (error) {
          if (error is RequestCanceledException) return;
          pagingController.error = error.message;
        },
      );
    } catch (error) {
      if (id != _seq) return;
      if (error is RequestCanceledException) return;
      pagingController.error = error.toString();
    } finally {
      // Only the current fetch owns the loading flag.
      if (id == _seq) {
        isLoadingListenable.value = false;
      }
    }
  }

  /// default page size
  int get pageSize => _currentPageSize ?? 25;

  List<T> _visiblePageItems(List<T> items) {
    final existing = pagingController.itemList ?? const [];
    final unique = <T>[];
    for (final item in items) {
      if (existing.contains(item) || unique.contains(item)) continue;
      unique.add(item);
    }
    return unique;
  }

  List<T> get items => pagingController.itemList ?? const [];

  bool get hasMore => pagingController.nextPageKey != null;

  bool get isLoadingMore => isLoadingListenable.value;

  Future<void> ensureInitialized() async {
    if (pagingController.itemList != null) return;
    if (isLoadingListenable.value) return;

    await pagingController.notifyPageRequestListeners(pagingController.firstPageKey);
  }

  Future<void> fetchNextPage() async {
    final nextKey = pagingController.nextPageKey;
    if (nextKey == null || isLoadingListenable.value) return;
    await pagingController.notifyPageRequestListeners(nextKey);
  }

  void ensureItem(T item, bool Function(T a, T b) compareFn) {
    final currentItems = pagingController.itemList;
    if (currentItems == null) {
      pagingController.itemList = [item];
      return;
    }
    if (currentItems.any((existing) => compareFn(existing, item))) return;
    pagingController.itemList = [item, ...currentItems];
  }

  T? matchItem(T? item, bool Function(T a, T b) compareFn) {
    if (item == null) return null;
    return items.firstWhereOrNull((existing) => compareFn(existing, item)) ?? item;
  }

  Future<void> updatePageSize(int newSize) async {
    if (newSize <= 0 || pageSize == newSize) return;
    _currentPageSize = newSize;
    await refreshData();
  }

  Future<List<T>> fetchTablePage(int pageKey) async {
    _cancelToken?.cancel("new table page fetch");
    final token = CancelToken();
    _cancelToken = token;
    final result = await fetchPage(pageKey: pageKey, cancelToken: token);

    return result.map<List<T>>(
      success: (success) {
        final data = success.data;
        totalItemsCount.value = data.pagination?.total;
        totalPagesCount.value = data.pagination?.pageCount;
        return data.data;
      },
      error: (error) => throw error.error,
    );
  }

  // -----------------------
  // Refresh
  // -----------------------
  Future<void> refreshData() async {
    // Always start a new first page (do not gate on isLoadingListenable).
    //
    // [PagingController.refresh] is safe under rapid re-entry: it cancels the
    // package CancelableOperation, clears internal in-flight page keys, and
    // resets itemList/nextPageKey. A subsequent notify then arms a new
    // first-page request. Stale [_handlePageRequest] bodies are ignored via
    // [_seq] after CancelToken cancellation of the network.
    pagingController.refresh();
    await pagingController
        .notifyPageRequestListeners(pagingController.firstPageKey);
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
    isLoadingListenable.dispose();
    searchController.dispose();
    pagingController.dispose();
    _cancelToken?.cancel("controller disposed");
    super.onClose();
  }
}
