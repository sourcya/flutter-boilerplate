import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/core/ui/ui.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:playx/playx.dart';

class PagingTableSource<T> extends AsyncDataTableSource {
  final PagingController<int, T> controller;
  final DataRow2 Function(int index, T item) rowBuilder;

  final bool showIndexColumn;

  PagingTableSource({
    required this.controller,
    required this.rowBuilder,
    required this.showIndexColumn,
  });

  @override
  DataRow? getRow(int index) {
    if (controller.itemList == null) return null;
    if (index >= controller.itemList!.length) return null;

    final item = controller.itemList![index];

    final originalRow = rowBuilder(index, item);

    if (!showIndexColumn) return originalRow;

    // Prepend index cell
    return DataRow(
      key: originalRow.key,
      selected: originalRow.selected,
      onSelectChanged: originalRow.onSelectChanged,
      cells: [
        DataCell(CellText((index + 1).toString())), // 1-based index
        ...originalRow.cells,
      ],
    );
  }

  @override
  int get rowCount => controller.itemList?.length ?? 0;

  @override
  bool get isRowCountApproximate => controller.nextPageKey != null;

  @override
  int get selectedRowCount => 0;

  @override
  Future<AsyncRowsResponse> getRows(int startIndex, int count) async {
    // Ensure PagingController loads enough items
    // (AsyncPaginatedDataTable asks for data in ranges)
    final endIndex = startIndex + count;

    // If we don't have enough items yet, request another page
    if (controller.itemList == null ||
        controller.itemList!.length < endIndex &&
            controller.nextPageKey != null) {
      await controller.notifyPageRequestListeners(controller.nextPageKey!);
    }

    final items = controller.itemList ?? [];

    final rows = <DataRow>[];

    for (int i = startIndex; i < endIndex; i++) {
      if (i >= items.length) break;
      rows.add(rowBuilder(i, items[i]));
    }

    return AsyncRowsResponse(
      items.length,
      rows,
    );
  }
}

class CustomPagingTableView<T> extends StatefulWidget {
  final PagingController<int, T> pagingController;
  final List<DataColumn2> columns;
  final DataRow2 Function(int index, T item) rowBuilder;
  final PaginatorController? paginatorController;
  final Function(int columnIndex, bool ascending)? onSort;
  final int initialRowsPerPage;
  final bool wrapInCard;
  final Widget? emptyBuilder;

  final bool showIndexColumn;

  const CustomPagingTableView({
    super.key,
    required this.pagingController,
    required this.columns,
    required this.rowBuilder,
    this.paginatorController,
    this.onSort,
    this.initialRowsPerPage = 25,
    this.wrapInCard = false,
    this.showIndexColumn = true,
    this.emptyBuilder,
  });

  @override
  State<CustomPagingTableView<T>> createState() =>
      _CustomPagingTableViewState<T>();
}

class _CustomPagingTableViewState<T> extends State<CustomPagingTableView<T>> {
  late int _rowsPerPage;

  @override
  void initState() {
    super.initState();
    _rowsPerPage = widget.initialRowsPerPage;

    // // Load next page when table scrolls to new area
    // widget.pagingController.addStatusListener((status) {
    //   setState(() {}); // rebuild table on new data/error/loading
    // });
  }

  late List<DataColumn2> finalColumns = [
    if (widget.showIndexColumn)
      DataColumn2(
        label: const ColumnHeader(label: "#"),
        size: ColumnSize.S,
        fixedWidth: 20.r,
      ), // index column header
    ...widget.columns,
  ];

  @override
  Widget build(BuildContext context) {
    return Card(
      color: context.colors.cardColor,
      margin: EdgeInsets.symmetric(vertical: 4.r, horizontal: 12.r),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24.r),
        side: BorderSide(
          color: context.colors.borderColor.withValues(alpha: .7),
        ),
      ),
      child: ValueListenableBuilder(
        valueListenable: widget.pagingController,
        builder: (_, __, ___) {
          final state = widget.pagingController.value;

          if (state.itemList?.isEmpty == true &&
              state.status == PagingStatus.completed) {
            return widget.emptyBuilder ?? const SizedBox();
          }

          return AsyncPaginatedDataTable2(
            wrapInCard: widget.wrapInCard,
            columns: finalColumns,
            rowsPerPage: _rowsPerPage,
            renderEmptyRowsInTheEnd: false,
            source: PagingTableSource<T>(
              controller: widget.pagingController,
              rowBuilder: widget.rowBuilder,
              showIndexColumn: widget.showIndexColumn,
            ),
            onPageChanged: (firstRowIndex) {
              // final key = widget.pagingController.nextPageKey;
              // if (key != null) {
              //   widget.pagingController.notifyPageRequestListeners(key);
              // }
            },
            // Optional external paginator controller
            controller: widget.paginatorController,
            columnSpacing: 12,
            horizontalMargin: 8.0.r,
            minWidth: context.width - 56.r,
            isHorizontalScrollBarVisible: false,
            isVerticalScrollBarVisible: true,
            dataRowHeight: 64.0.r,
            headingRowHeight: 48.0.r,
            // headingRowColor: WidgetStateProperty.all(context.colors.card),
            // dataRowColor: WidgetStateProperty.resolveWith((states) {
            //   if (states.contains(WidgetState.hovered)) {
            //     return context.colors.surfaceContainer.withValues(alpha: 0.5);
            //   }
            //   return null;
            // }),
            border: TableBorder(
              bottom: BorderSide(
                color: context.colors.borderColor.withValues(alpha: .7),
              ),
              horizontalInside: BorderSide(
                color: context.colors.borderColor.withValues(alpha: .7),
              ),
            ),
            // sortColumnIndex: _sortColumnIndex,
            // sortAscending: _sortAscending,
            sortArrowAnimationDuration: const Duration(milliseconds: 200),
            // generic error handling
            empty:
                widget.emptyBuilder ??
                Center(
                  child: CustomText(
                    AppTrans.emptyResponse,
                    color: context.colors.error,
                  ),
                ),
          );
        },
      ),
    );
  }
}
