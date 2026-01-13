import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/core/ui/ui.dart';
import 'package:playx/playx.dart';

class CustomTableView<T> extends StatelessWidget {
  final List<T> items;
  final List<DataColumn2> columns;
  final DataRow2 Function(int index, T item) rowBuilder;
  final bool isShowIndexColumn;
  final Widget? emptyBuilder;
  final bool wrapInCard;
  final double? checkboxHorizontalMargin;
  final double? minWidth;

  const CustomTableView({
    super.key,
    required this.items,
    required this.columns,
    required this.rowBuilder,
    this.isShowIndexColumn = true,
    this.emptyBuilder,
    this.wrapInCard = true,
    this.checkboxHorizontalMargin,
    this.minWidth,
  });

  @override
  Widget build(BuildContext context) {
    final finalColumns = [
      if (isShowIndexColumn)
        DataColumn2(
          label: const ColumnHeader(label: "#"),
          size: ColumnSize.S,
          fixedWidth: 20.h,
        ),
      ...columns,
    ];

    if (items.isEmpty) {
      return emptyBuilder ??
          Center(
            child: CustomText(
              AppTrans.emptyResponse,
              color: context.colors.error,
            ),
          );
    }

    final rows = <DataRow>[
      for (int i = 0; i < items.length; i++)
        _wrapIndex(
          i: i,
          original: rowBuilder(i, items[i]),
        ),
    ];

    final table = DataTable2(
      columns: finalColumns,
      rows: rows,
      columnSpacing: 10,
      horizontalMargin: 12.5.r,
      minWidth: minWidth,
      checkboxHorizontalMargin: checkboxHorizontalMargin,
      isHorizontalScrollBarVisible: false,
      dataRowHeight: 65.h,
      headingRowHeight: 55.h,
      border: TableBorder(
        bottom: BorderSide(
          color: context.colors.borderColor.withValues(alpha: .7),
        ),
        horizontalInside: BorderSide(
          color: context.colors.borderColor.withValues(alpha: .7),
        ),
      ),
    );

    if (!wrapInCard) return table;

    return Card(
      elevation: 0.0,
      color: context.colors.cardColor,
      margin: EdgeInsets.symmetric(vertical: 4.h, horizontal: 12.h),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24.h),
        side: BorderSide(
          color: context.colors.borderColor.withValues(alpha: .7),
        ),
      ),
      child: table,
    );
  }

  DataRow _wrapIndex({
    required int i,
    required DataRow2 original,
  }) {
    if (!isShowIndexColumn) return original;
    return DataRow(
      key: original.key,
      selected: original.selected,
      onSelectChanged: original.onSelectChanged,
      cells: [
        DataCell(CellText('${i + 1}')),
        ...original.cells,
      ],
    );
  }
}
