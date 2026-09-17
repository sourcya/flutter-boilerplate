part of '../../../ui/ui.dart';

class CustomTableView<T> extends StatelessWidget {
  final List<T> items;
  final List<DataColumn2> columns;
  final DataRow2 Function(int index, T item) rowBuilder;
  final bool isShowIndexColumn;
  final Widget? emptyBuilder;
  final bool wrapInCard;
  final double? checkboxHorizontalMargin;
  final double? minWidth;
  final double horizontalMargin;
  final EdgeInsets? margin;

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
    this.horizontalMargin = 16,
    this.margin,
  });

  @override
  Widget build(BuildContext context) {
    final finalColumns = [
      if (isShowIndexColumn)
        DataColumn2(
          label: const ColumnHeader.start(label: "#"),
          size: ColumnSize.S,
          fixedWidth: 20.r,
        ),
      ...columns,
    ];

    if (items.isEmpty) {
      return emptyBuilder ??
          const EmptyDataWidget(
            error: AppTrans.emptyResponse,
            // animationHeight: context.height * .15,
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
      columnSpacing: 16,
      horizontalMargin: horizontalMargin.r,
      minWidth: minWidth,
      checkboxHorizontalMargin: checkboxHorizontalMargin,
      isHorizontalScrollBarVisible: false,
      dataRowHeight: 72.r,
      headingRowHeight: 48.r,
      dataRowColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return context.colors.primary.withValues(alpha: 0.08);
        }
        if (states.contains(WidgetState.hovered)) {
          return context.colors.primary.withValues(alpha: 0.04);
        }
        return AppColors.transparent;
      }),
      border: TableBorder(
        bottom: BorderSide(
          color: context.colors.borderColor.withValues(alpha: .7),
          width: 1.r,
        ),
        horizontalInside: BorderSide(
          color: context.colors.borderColor,
          width: 1.r,
        ),
      ),
    );

    final selectableTable = WebBodySelectionArea(
      child: WebTableSelectionScope(child: table),
    );

    if (!wrapInCard) return selectableTable;

    return Card(
      elevation: 0.0,
      color: context.colors.screenCardSurface,
      margin: margin ?? context.paddingSymmetric(vertical: 4, horizontal: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24.r),
        side: BorderSide(color: context.colors.borderColor),
      ),
      child: selectableTable,
    );
  }

  DataRow _wrapIndex({
    required int i,
    required DataRow2 original,
  }) {
    if (!isShowIndexColumn) return original;
    return DataRow2(
      key: original.key,
      selected: original.selected,
      onSelectChanged: original.onSelectChanged,
      onTap: original.onTap,
      onDoubleTap: original.onDoubleTap,
      onLongPress: original.onLongPress,
      color: original.color,
      cells: [
        DataCell(CellText.start('${i + 1}')),
        ...original.cells,
      ],
    );
  }
}
