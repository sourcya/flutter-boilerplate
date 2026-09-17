part of '../../../ui/ui.dart';

class CustomPagingTableView<T> extends StatefulWidget {
  final PagingController<int, T> pagingController;
  final List<DataColumn2> columns;
  final DataRow2 Function(int index, T item) rowBuilder;

  // ── Pagination / layout ──────────────────────────────────────────────────
  final PaginatorController paginatorController;
  final int initialRowsPerPage;
  final List<int> pageSizeOptions;

  /// Hide the built-in paginator bar inside AsyncPaginatedDataTable2.
  /// Default is [true] because [GenericPagedView] provides its own
  /// [_PaginationControlsRow] in [GenericPagedView]. Set to [false] if using
  /// this widget standalone.
  final bool hidePaginator;

  // ── Sorting ──────────────────────────────────────────────────────────────
  final Function(int columnIndex, bool ascending)? onSort;
  final int? sortColumnIndex;
  final bool sortAscending;

  // ── Dimensions ───────────────────────────────────────────────────────────
  final double dataRowHeight;
  final double headingRowHeight;
  final double columnSpacing;
  final double horizontalMargin;
  final double? minWidth;

  // ── Fixed columns/rows ───────────────────────────────────────────────────
  final int fixedLeftColumns;
  final int fixedTopRows;

  // ── Appearance ───────────────────────────────────────────────────────────
  final bool wrapInCard;
  final bool showIndexColumn;
  final bool showCheckboxColumn;
  final int selectedRowCount;
  final RxInterface<dynamic>? selectedRowCountRefresh;
  final int Function()? selectedRowCountBuilder;
  final void Function(bool?)? onSelectAll;
  final TableBorder? border;
  final WidgetStateProperty<Color?>? headingRowColor;
  final WidgetStateProperty<Color?>? dataRowColor;
  final TextStyle? headingTextStyle;
  final TextStyle? dataTextStyle;

  // ── Scroll bars ──────────────────────────────────────────────────────────
  final bool isHorizontalScrollBarVisible;
  final bool isVerticalScrollBarVisible;

  // ── Async states ─────────────────────────────────────────────────────────
  final Widget? loadingWidget;
  final Widget Function(Object? error)? errorBuilder;
  final Widget? emptyBuilder;
  final String? emptyDataMessage;

  // ── Callbacks ────────────────────────────────────────────────────────────
  final void Function(int firstRowIndex)? onPageChanged;
  final void Function(int? rowsPerPage)? onRowsPerPageChanged;
  final EdgeInsetsGeometry? margin;
  final double? cardBorderRadius;
  final Color? cardBorderColor;

  /// When set (e.g. [BasePagedController.totalItemsCount]), the table reports
  /// the exact server-side row total so [PaginatorController] and page counts
  /// stay in sync with the footer. Also sets [PagingTableSource] to treat the
  /// row count as exact (`isRowCountApproximate == false`) when this value is
  /// non-null, avoiding placeholder spinner rows caused by a mismatch between
  /// [initialRowsPerPage] and how many rows were fetched from the API.
  final RxnInt? serverTotalRowCount;

  /// Direct page fetch for table navigation via
  /// [BasePagedController.fetchTablePage]. Used when jumping to pages beyond
  /// what [PagingController.itemList] has already loaded.
  final Future<List<T>> Function(int pageKey)? pageFetcher;

  const CustomPagingTableView({
    super.key,
    required this.pagingController,
    required this.columns,
    required this.rowBuilder,
    // pagination
    required this.paginatorController,
    this.initialRowsPerPage = 25,
    this.pageSizeOptions = const [10, 25, 50, 100],
    this.hidePaginator = true,
    // sorting
    this.onSort,
    this.sortColumnIndex,
    this.sortAscending = true,
    // dimensions
    this.dataRowHeight = 72.0,
    this.headingRowHeight = 48.0,
    this.columnSpacing = 16.0,
    this.horizontalMargin = 24.0,
    this.minWidth,
    // fixed
    this.fixedLeftColumns = 0,
    this.fixedTopRows = 1,
    // appearance
    this.wrapInCard = false,
    this.showIndexColumn = true,
    this.showCheckboxColumn = false,
    this.selectedRowCount = 0,
    this.selectedRowCountRefresh,
    this.selectedRowCountBuilder,
    this.onSelectAll,
    this.border,
    this.headingRowColor,
    this.dataRowColor,
    this.headingTextStyle,
    this.dataTextStyle,
    this.cardBorderRadius = 16.0,
    // scroll bars
    this.isHorizontalScrollBarVisible = false,
    this.isVerticalScrollBarVisible = true,
    // async states
    this.loadingWidget,
    this.errorBuilder,
    this.emptyBuilder,
    this.emptyDataMessage,
    // callbacks
    this.onPageChanged,
    this.onRowsPerPageChanged,
    this.margin,
    this.cardBorderColor,
    this.serverTotalRowCount,
    this.pageFetcher,
  });

  @override
  State<CustomPagingTableView<T>> createState() => _CustomPagingTableViewState<T>();
}

class _CustomPagingTableViewState<T> extends State<CustomPagingTableView<T>> {
  late List<DataColumn2> _columns;
  late PagingTableSource<T> _source;
  late int _rowsPerPage;
  int? _recentRefreshVersion;
  bool _sourceRebuildScheduled = false;

  @override
  void initState() {
    super.initState();
    _rowsPerPage = widget.initialRowsPerPage;
    _setupColumns();
    _source = _setupTableSource(widget.pagingController);
    widget.pagingController.addListener(_handlePagingControllerChanged);
    widget.paginatorController.addListener(_handlePaginatorChanged);
  }

  PagingTableSource<T> _setupTableSource(PagingController<int, T> controller) {
    return PagingTableSource<T>(
      controller: controller,
      rowBuilder: widget.rowBuilder,
      showIndexColumn: widget.showIndexColumn,
      selectedRowCount: widget.selectedRowCount,
      selectedRowCountRefresh: widget.selectedRowCountRefresh,
      selectedRowCountBuilder: widget.selectedRowCountBuilder,
      serverTotalRowCount: widget.serverTotalRowCount,
      pageFetcher: widget.pageFetcher,
      columnCount: _columns.length,
    );
  }

  @override
  void didUpdateWidget(CustomPagingTableView<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.columns != widget.columns ||
        oldWidget.showIndexColumn != widget.showIndexColumn) {
      _setupColumns();
    }

    if (oldWidget.paginatorController != widget.paginatorController) {
      oldWidget.paginatorController.removeListener(_handlePaginatorChanged);
      widget.paginatorController.addListener(_handlePaginatorChanged);
    }

    if (oldWidget.pagingController != widget.pagingController) {
      oldWidget.pagingController.removeListener(_handlePagingControllerChanged);
      widget.pagingController.addListener(_handlePagingControllerChanged);
      _source.dispose();
      _source = _setupTableSource(widget.pagingController);
    } else if (oldWidget.rowBuilder != widget.rowBuilder ||
        oldWidget.showIndexColumn != widget.showIndexColumn ||
        oldWidget.selectedRowCount != widget.selectedRowCount ||
        oldWidget.selectedRowCountRefresh != widget.selectedRowCountRefresh ||
        oldWidget.serverTotalRowCount != widget.serverTotalRowCount ||
        oldWidget.pageFetcher != widget.pageFetcher ||
        oldWidget.columns.length != widget.columns.length) {
      _source.update(
        rowBuilder: widget.rowBuilder,
        showIndexColumn: widget.showIndexColumn,
        selectedRowCount: widget.selectedRowCount,
        selectedRowCountRefresh: widget.selectedRowCountRefresh,
        selectedRowCountBuilder: widget.selectedRowCountBuilder,
        updateSelectedRowCountRefresh: true,
        updateSelectedRowCountBuilder: true,
        serverTotalRowCount: widget.serverTotalRowCount,
        pageFetcher: widget.pageFetcher,
        columnCount: _columns.length,
      );
    }

    if (oldWidget.initialRowsPerPage != widget.initialRowsPerPage &&
        widget.initialRowsPerPage != _rowsPerPage) {
      setState(() => _rowsPerPage = widget.initialRowsPerPage);
    }
  }

  @override
  void dispose() {
    widget.pagingController.removeListener(_handlePagingControllerChanged);
    widget.paginatorController.removeListener(_handlePaginatorChanged);
    _source.dispose();
    super.dispose();
  }

  /// Keep [AsyncPaginatedDataTable2.rowsPerPage] in sync when the Madan footer
  /// changes size via [PaginatorController.setRowsPerPage].
  void _handlePaginatorChanged() {
    if (!widget.paginatorController.isAttached) return;
    final next = widget.paginatorController.rowsPerPage;
    if (next == _rowsPerPage) return;
    _source.clearDirectPageCache();
    if (!mounted) return;
    setState(() => _rowsPerPage = next);
  }

  /// Rebuild source and reset paginator to first page when a refresh clears
  /// the list (avoids the table stuck on a non-first page after reload).
  ///
  /// Source dispose/recreate is deferred to a post-frame callback so we never
  /// add/remove [PagingController] listeners while a notification is still
  /// propagating (avoids re-entrant notifyPageRequestListeners).
  void _handlePagingControllerChanged() {
    final state = widget.pagingController.value;
    final isRefreshingFirstPage =
        state.status == PagingStatus.loadingFirstPage && state.itemList == null;

    if (isRefreshingFirstPage && _recentRefreshVersion != state.version) {
      _recentRefreshVersion = state.version;
      _scheduleSourceRebuild();
    }

    if (!widget.paginatorController.isAttached) return;

    final shouldResetToFirstPage =
        isRefreshingFirstPage && widget.paginatorController.currentRowIndex > 0;

    if (!shouldResetToFirstPage) return;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted || !widget.paginatorController.isAttached) return;
      if (widget.paginatorController.currentRowIndex == 0) return;
      widget.paginatorController.goToFirstPage();
    });
  }

  void _scheduleSourceRebuild() {
    if (_sourceRebuildScheduled) return;
    _sourceRebuildScheduled = true;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _sourceRebuildScheduled = false;
      if (!mounted) return;
      setState(() {
        _source.dispose();
        _source = _setupTableSource(widget.pagingController);
      });
    });
  }

  void _setupColumns() {
    _columns = [
      if (widget.showIndexColumn)
        DataColumn2(
          label: const ColumnHeader(label: '#'),
          size: ColumnSize.S,
          fixedWidth: 40.r,
        ),
      ...widget.columns,
    ];
  }

  // ── Default widgets ──────────────────────────────────────────────────────

  Widget _buildLoadingWidget() =>
      widget.loadingWidget ??
      Center(
        child: SizedBox(
          width: 64.r,
          height: 16.r,
          child: const LinearProgressIndicator(),
        ),
      );

  Widget _buildErrorWidget(Object? error) => widget.errorBuilder != null
      ? widget.errorBuilder!(error)
      : Center(
          child: CustomText(
            error is DataError
                ? error.message
                : error is String
                ? error
                : AppTrans.defaultError,
            color: context.colors.mutedForeground,
          ),
        );

  // ── Build ────────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    return Card(
      color: context.colors.screenCardSurface,
      // antiAlias clips the inner Stack to the rounded shape so the opaque
      // loading overlay doesn't bleed past the card's corners.
      clipBehavior: Clip.antiAlias,
      margin: widget.margin ?? context.paddingSymmetric(),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular((widget.cardBorderRadius ?? 24).r),
        side: BorderSide(
          color: widget.cardBorderColor ?? context.colors.borderColor,
        ),
      ),
      child: Stack(
        fit: StackFit.expand,
        children: [
          _CustomPagingTableBody<T>(
            key: ValueKey(_rowsPerPage),
            view: widget,
            columns: _columns,
            source: _source,
            rowsPerPage: _rowsPerPage,
            errorBuilder: _buildErrorWidget,
          ),
          // Single source of truth for the loading affordance. Opaque so it
          // hides any rows underneath (e.g. page-1 rows during page-2 fetch),
          // and gated on either:
          //   - the paging controller's first-page load, OR
          //   - an in-flight subsequent page fetch (`isFetchingNextPage`).
          // The library's built-in `loading` overlay and the `empty` builder's
          // loading branch are both suppressed below, so this is the only
          // loader the user ever sees.
          //
          // Positioned below the heading row so the column titles (#, ID,
          // Name, …) remain visible while the loader is on screen.
          Positioned(
            top: widget.headingRowHeight.r,
            left: 0,
            right: 0,
            bottom: 0,
            child: ListenableBuilder(
              listenable: _source,
              builder: (ctx, _) {
                final pagingValue = widget.pagingController.value;
                final hasLoadedItems = pagingValue.itemList != null;
                final isFirstPageLoading =
                    pagingValue.status == PagingStatus.loadingFirstPage && !hasLoadedItems;
                final isLoading = isFirstPageLoading || _source.isFetchingNextPage;
                if (!isLoading) {
                  return const SizedBox.shrink();
                }
                return IgnorePointer(
                  child: Container(
                    color: ctx.colors.screenCardSurface,
                    alignment: Alignment.center,
                    child: _buildLoadingWidget(),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _CustomPagingTableBody<T> extends StatelessWidget {
  final CustomPagingTableView<T> view;
  final List<DataColumn2> columns;
  final PagingTableSource<T> source;
  final int rowsPerPage;
  final Widget Function(Object? error) errorBuilder;

  const _CustomPagingTableBody({
    super.key,
    required this.view,
    required this.columns,
    required this.source,
    required this.rowsPerPage,
    required this.errorBuilder,
  });

  @override
  Widget build(BuildContext context) {
    return WebBodySelectionArea(
      child: WebTableSelectionScope(
        child: AsyncPaginatedDataTable2(
          key: ValueKey(rowsPerPage),
          columns: columns,
          source: source,
          controller: view.paginatorController,
          rowsPerPage: rowsPerPage,
          availableRowsPerPage: view.pageSizeOptions,
          hidePaginator: view.hidePaginator,
          onPageChanged: view.onPageChanged,
          onRowsPerPageChanged: view.onRowsPerPageChanged,
          renderEmptyRowsInTheEnd: false,
          sortColumnIndex: view.sortColumnIndex,
          sortAscending: view.sortAscending,
          sortArrowAnimationDuration: const Duration(milliseconds: 200),
          dataRowHeight: view.dataRowHeight.r,
          headingRowHeight: view.headingRowHeight.r,
          columnSpacing: view.columnSpacing,
          horizontalMargin: view.horizontalMargin.r,
          minWidth: view.minWidth ?? (context.width > 800 ? null : context.width * 0.8),
          fixedLeftColumns: view.fixedLeftColumns,
          fixedTopRows: view.fixedTopRows,
          wrapInCard: view.wrapInCard,
          headingCheckboxTheme: CheckboxThemeData(
            fillColor: WidgetStateProperty.resolveWith((states) {
              if (states.contains(WidgetState.selected)) {
                return context.colors.primary;
              }
              return context.colors.screenCardSurface;
            }),
            checkColor: WidgetStatePropertyAll(context.colors.onPrimary),
            side: BorderSide(color: context.colors.primary),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.r)),
          ),
          datarowCheckboxTheme: CheckboxThemeData(
            fillColor: WidgetStateProperty.resolveWith((states) {
              if (states.contains(WidgetState.selected)) {
                return context.colors.primary;
              }
              return context.colors.screenCardSurface;
            }),
            checkColor: WidgetStatePropertyAll(context.colors.onPrimary),
            side: BorderSide(color: context.colors.primary),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.r)),
          ),
          showCheckboxColumn: view.showCheckboxColumn,
          onSelectAll: view.onSelectAll,
          headingRowColor: view.headingRowColor,
          headingTextStyle: view.headingTextStyle,
          dataTextStyle: view.dataTextStyle,
          border:
              view.border ??
              TableBorder(
                bottom: BorderSide(
                  color: context.colors.borderColor.withValues(alpha: .7),
                  width: 1.r,
                ),
                horizontalInside: BorderSide(
                  color: context.colors.borderColor,
                  width: 1.r,
                ),
              ),
          isHorizontalScrollBarVisible: view.isHorizontalScrollBarVisible,
          isVerticalScrollBarVisible: view.isVerticalScrollBarVisible,
          loading: const SizedBox.shrink(),
          errorBuilder: errorBuilder,
          empty: ValueListenableBuilder(
            valueListenable: view.pagingController,
            builder: (context, value, _) {
              final err = value.error;
              final items = value.itemList;
              if (value.status == PagingStatus.loadingFirstPage || (items == null && err == null)) {
                return const SizedBox.shrink();
              }
              if (items != null && items.isEmpty && err == null) {
                return errorBuilder(view.emptyDataMessage ?? AppTrans.emptyResponse);
              }
              return errorBuilder(err);
            },
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// PagingTableSource
// ─────────────────────────────────────────────────────────────────────────────

class PagingTableSource<T> extends AsyncDataTableSource {
  final PagingController<int, T> controller;
  DataRow2 Function(int index, T item) rowBuilder;
  bool showIndexColumn;
  int _selectedRowCount;
  RxInterface<dynamic>? selectedRowCountRefresh;
  int Function()? selectedRowCountBuilder;
  RxnInt? serverTotalRowCount;
  Future<List<T>> Function(int pageKey)? pageFetcher;

  /// Total number of columns the table renders (including the auto-injected
  /// index column when [showIndexColumn] is true). Used to build blank
  /// placeholder rows with the correct cell count for indices not yet
  /// loaded into [PagingController.itemList], so `data_table_2` doesn't fall
  /// back to its per-column `CircularProgressIndicator` row.
  int columnCount;

  // The last page key we've already requested via notifyPageRequestListeners,
  // used to dedupe so we don't fire the same fetch repeatedly. Reset to null
  // when the controller is refreshed (itemList goes from data -> null).
  int? _requestedPageKey;
  // Tracks itemList presence across notifications so we can detect refreshes.
  bool _hadData = false;
  bool _isDisposed = false;
  Worker? _serverTotalWorker;
  StreamSubscription<dynamic>? _selectedRowCountSubscription;
  // Direct-fetched rows for pages beyond [PagingController.itemList].
  // Retains only the page currently in view (cleared before each store and
  // on refresh / page-size change / dispose).
  final Map<int, T> _directPageCache = {};

  // ── In-flight page request tracking ──────────────────────────────────────
  // True between the moment we trigger `notifyPageRequestListeners` and the
  // moment the controller appends new items (or surfaces an error). The
  // build() method overlays a single centered loader while this is true.
  bool _isFetchingNextPage = false;
  bool get isFetchingNextPage => _isFetchingNextPage;
  int _itemCountAtFetchStart = 0;

  PagingTableSource({
    required this.controller,
    required this.rowBuilder,
    required this.showIndexColumn,
    required int selectedRowCount,
    this.selectedRowCountRefresh,
    this.selectedRowCountBuilder,
    required this.columnCount,
    this.serverTotalRowCount,
    this.pageFetcher,
  }) : _selectedRowCount = selectedRowCountBuilder?.call() ?? selectedRowCount {
    _hadData = controller.itemList != null;
    controller.addListener(_onControllerChange);
    _attachServerTotalListener();
    _attachSelectedRowCountListener();
  }

  void _attachServerTotalListener() {
    _serverTotalWorker?.dispose();
    _serverTotalWorker = null;
    final rx = serverTotalRowCount;
    if (rx != null) {
      _serverTotalWorker = ever(rx, (_) => notifyListeners());
    }
  }

  void _attachSelectedRowCountListener() {
    _selectedRowCountSubscription?.cancel();
    _selectedRowCountSubscription = null;
    final rx = selectedRowCountRefresh;
    if (rx != null && selectedRowCountBuilder != null) {
      _selectedRowCountSubscription = rx.listen((_) {
        if (_isDisposed) return;
        _selectedRowCount = selectedRowCountBuilder?.call() ?? _selectedRowCount;
        notifyListeners();
      });
    }
  }

  void clearDirectPageCache() => _directPageCache.clear();

  void _onControllerChange() {
    if (_isDisposed) return;

    final hasDataNow = controller.itemList != null;
    // Detect refresh (e.g. filter change, pull-to-refresh): had items,
    // itemList is now null. Reset the requested-key tracker so the next
    // fetch fires even when the firstPageKey numerically matches the
    // previously-requested key.
    final wasRefreshed = _hadData && !hasDataNow;
    if (wasRefreshed) {
      _requestedPageKey = null;
      _isFetchingNextPage = false;
      clearDirectPageCache();
    }
    _hadData = hasDataNow;

    // End an in-flight page request as soon as the controller's itemList
    // grows past the snapshot taken when we triggered the fetch, or an
    // error surfaces.
    if (controller.error != null) {
      _isFetchingNextPage = false;
    } else if (_isFetchingNextPage) {
      final items = controller.itemList;
      if (items != null) {
        final pageSettled =
            items.length != _itemCountAtFetchStart || controller.nextPageKey == null;
        if (pageSettled) {
          _isFetchingNextPage = false;
        }
      }
    }

    notifyListeners();

    // Safety net: after a refresh, proactively trigger the first page fetch.
    // AsyncPaginatedDataTable2 normally re-calls getRows on source change
    // (and getRows would fire the request itself), but in some lifecycles
    // — e.g. returning from a pushed route, or filter changes that don't
    // re-mount the table state — that re-fetch can be skipped, leaving the
    // table stuck in its loading widget without ever firing a request.
    if (wasRefreshed) {
      if (controller.error != null) {
        controller.error = null;
      }
      _requestNextPageIfNeeded();
    }
  }

  void _requestNextPageIfNeeded() {
    if (_isDisposed) return;
    final nextKey = controller.nextPageKey;
    if (nextKey == null) return;
    if (controller.error != null) return;
    if (_requestedPageKey == nextKey) return;

    _requestedPageKey = nextKey;
    _itemCountAtFetchStart = controller.itemList?.length ?? 0;
    _isFetchingNextPage = true;
    // ignore: invalid_use_of_protected_member
    controller.notifyPageRequestListeners(nextKey);
  }

  @override
  void dispose() {
    _serverTotalWorker?.dispose();
    _selectedRowCountSubscription?.cancel();
    clearDirectPageCache();
    _isDisposed = true;
    controller.removeListener(_onControllerChange);
    super.dispose();
  }

  void update({
    DataRow2 Function(int index, T item)? rowBuilder,
    bool? showIndexColumn,
    int? selectedRowCount,
    RxInterface<dynamic>? selectedRowCountRefresh,
    int Function()? selectedRowCountBuilder,
    bool updateSelectedRowCountRefresh = false,
    bool updateSelectedRowCountBuilder = false,
    RxnInt? serverTotalRowCount,
    Future<List<T>> Function(int pageKey)? pageFetcher,
    int? columnCount,
  }) {
    if (rowBuilder != null) this.rowBuilder = rowBuilder;
    if (showIndexColumn != null) this.showIndexColumn = showIndexColumn;
    final previousSelectedRowCountBuilder = this.selectedRowCountBuilder;
    final selectionListenerChanged =
        updateSelectedRowCountRefresh && selectedRowCountRefresh != this.selectedRowCountRefresh;
    if (updateSelectedRowCountRefresh) {
      this.selectedRowCountRefresh = selectedRowCountRefresh;
    }
    if (updateSelectedRowCountBuilder) {
      this.selectedRowCountBuilder = selectedRowCountBuilder;
    }
    final selectionBuilderChanged =
        updateSelectedRowCountBuilder && selectedRowCountBuilder != previousSelectedRowCountBuilder;
    if (selectionListenerChanged || selectionBuilderChanged) {
      _attachSelectedRowCountListener();
    }
    if (selectedRowCount != null) {
      _selectedRowCount = this.selectedRowCountBuilder?.call() ?? selectedRowCount;
    }
    if (serverTotalRowCount != null) {
      this.serverTotalRowCount = serverTotalRowCount;
      _attachServerTotalListener();
    }
    this.pageFetcher = pageFetcher;
    if (columnCount != null) this.columnCount = columnCount;
    notifyListeners();
  }

  int _effectiveTotalRows() {
    final loaded = controller.itemList?.length ?? 0;
    final server = serverTotalRowCount?.value;
    if (server != null && server > 0) {
      return max(server, loaded);
    }
    return loaded;
  }

  DataRow _dataRow(int index, T item) {
    final originalRow = rowBuilder(index, item);
    if (!showIndexColumn) return originalRow;
    return DataRow(
      key: originalRow.key,
      selected: originalRow.selected,
      onSelectChanged: originalRow.onSelectChanged,
      color: originalRow.color,
      cells: [
        DataCell(CellText((index + 1).toString())),
        ...originalRow.cells,
      ],
    );
  }

  T? _itemAt(int index) {
    if (_directPageCache.containsKey(index)) {
      return _directPageCache[index];
    }
    final items = controller.itemList;
    return items != null && index < items.length ? items[index] : null;
  }

  @override
  DataRow? getRow(int index) {
    final item = _itemAt(index);
    if (item == null) {
      // Returning a blank row (instead of null) prevents data_table_2's
      // PaginatedDataTable2._getRows from injecting its built-in
      // _getProgressIndicatorRowFor row, which puts a CircularProgressIndicator
      // in every non-numeric column. The single centered overlay rendered
      // by [CustomPagingTableView] handles the loading affordance instead.
      return _emptyRow(index);
    }
    return _dataRow(index, item);
  }

  DataRow _emptyRow(int index) {
    return DataRow.byIndex(
      index: index,
      cells: List<DataCell>.generate(columnCount, (_) => DataCell.empty),
    );
  }

  @override
  int get rowCount => _effectiveTotalRows();

  @override
  bool get isRowCountApproximate {
    final server = serverTotalRowCount?.value;
    if (server != null && server > 0) return false;
    return controller.nextPageKey != null;
  }

  @override
  int get selectedRowCount => _selectedRowCount;

  @override
  Future<AsyncRowsResponse> getRows(int startIndex, int count) async {
    final endIndex = startIndex + count;
    final items = controller.itemList;
    final error = controller.error;
    final nextKey = controller.nextPageKey;
    final serverRowCount = serverTotalRowCount?.value;

    // Surface fetch errors to the table when we have no data to fall back on.
    if (error != null && (items == null || items.isEmpty)) {
      throw error is Object ? error : Exception(error.toString());
    }

    // Avoid pageFetcher while first page is loading (keeps overlay in sync).
    final canFetchDirectly =
        pageFetcher != null && serverRowCount != null && controller.itemList != null;
    final requestedEndIndex = serverRowCount == null ? endIndex : min(endIndex, serverRowCount);
    var hasMissingDirectItem = false;
    for (int index = startIndex; index < requestedEndIndex; index++) {
      if (_itemAt(index) == null) {
        hasMissingDirectItem = true;
        break;
      }
    }

    if (canFetchDirectly && hasMissingDirectItem) {
      final pageKey = (startIndex ~/ count) + 1;
      _isFetchingNextPage = true;
      notifyListeners();
      try {
        final pageItems = await pageFetcher!(pageKey);
        // Keep only the page currently in view so paging a large dataset
        // does not accumulate every visited page in memory.
        _directPageCache.clear();
        for (int offset = 0; offset < pageItems.length; offset++) {
          _directPageCache[startIndex + offset] = pageItems[offset];
        }
      } on RequestCanceledException {
        // Stale or disposed fetch — leave cache untouched.
      } catch (e) {
        // Match non-direct fetch: park the error on the controller so listeners
        // and the table error UI stay consistent, then rethrow for
        // AsyncPaginatedDataTable2's errorBuilder.
        controller.error = e;
        rethrow;
      } finally {
        _isFetchingNextPage = false;
      }
    } else {
      // Kick off a fetch if we need more data — but don't await it. When the
      // controller eventually appends a page, our listener fires
      // notifyListeners() on this source and the table calls getRows again
      // to pick up the new rows. This avoids holding open a getRows future
      // that AsyncPaginatedDataTable2 may abandon (e.g. on filter change),
      // which is what caused the "stuck on loading without a request" issue.
      final needsMore =
          items == null || (items.length < endIndex && nextKey != null && error == null);
      if (needsMore && nextKey != null && _requestedPageKey != nextKey) {
        _requestedPageKey = nextKey;
        _itemCountAtFetchStart = items?.length ?? 0;
        _isFetchingNextPage = true;
        // ignore: invalid_use_of_protected_member
        controller.notifyPageRequestListeners(nextKey);
      }
    }

    final rows = <DataRow>[];
    for (int i = startIndex; i < endIndex; i++) {
      final item = _itemAt(i);
      if (item == null) break;
      rows.add(_dataRow(i, item));
    }
    return AsyncRowsResponse(_effectiveTotalRows(), rows);
  }
}
