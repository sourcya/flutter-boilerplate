part of '../ui.dart';
@immutable
class SliverGroupedGridView<T, E> extends StatefulWidget {
  final List<T> elements;
  final E Function(T element) groupBy;
  final int Function(E value1, E value2)? groupComparator;
  final int Function(T element1, T element2)? itemComparator;
  final Widget Function(E value)? groupSeparatorBuilder;
  final Widget Function(T element)? groupHeaderBuilder;
  final Widget Function(BuildContext context, T element)? itemBuilder;
  final Widget Function(BuildContext context, T element, int index)? indexedItemBuilder;
  final GroupedListOrder order;
  final bool sort;
  final Widget separator;
  final Widget? footer;

  /// The number of children in the cross axis.
  final int crossAxisCount;

  /// The number of logical pixels between each child along the main axis.
  final double mainAxisSpacing;

  /// The number of logical pixels between each child along the cross axis.
  final double crossAxisSpacing;

  const SliverGroupedGridView({
    super.key,
    required this.elements,
    required this.groupBy,
    this.groupComparator,
    this.groupSeparatorBuilder,
    this.groupHeaderBuilder,
    this.itemBuilder,
    this.indexedItemBuilder,
    this.itemComparator,
    this.order = GroupedListOrder.ASC,
    this.sort = true,
    this.separator = const SizedBox.shrink(),
    this.footer,
    this.crossAxisCount = 2,
    this.mainAxisSpacing = 8.0,
    this.crossAxisSpacing = 8.0,
  }) : assert(itemBuilder != null || indexedItemBuilder != null),
       assert(groupSeparatorBuilder != null || groupHeaderBuilder != null);

  @override
  State<SliverGroupedGridView<T, E>> createState() => _SliverGroupedGridViewState<T, E>();
}

class _SliverGroupedGridViewState<T, E> extends State<SliverGroupedGridView<T, E>> {
  final LinkedHashMap<String, GlobalKey> _keys = LinkedHashMap();
  List<T> _sortedElements = [];

  @override
  Widget build(BuildContext context) {
    _sortedElements = _sortElements();

    return MultiSliver(children: buildSlivers());
  }

  List<Widget> buildSlivers() {
    final grouped = _groupElements();
    final slivers = <Widget>[];

    for (final entry in grouped.entries) {
      final groupItems = entry.value;
      final groupKey = widget.groupBy(groupItems.first);

      // Group Header
      slivers.add(
        SliverToBoxAdapter(
          child: _buildGroupSeparator(groupItems.first),
        ),
      );

      // Grid Items
      slivers.add(
        SliverPadding(
          padding: const EdgeInsets.all(8),
          sliver: SliverAlignedGrid.count(
            crossAxisCount: widget.crossAxisCount,
            mainAxisSpacing: widget.mainAxisSpacing,
            crossAxisSpacing: widget.crossAxisSpacing,
            itemCount: groupItems.length,
            itemBuilder: (context, index) => _buildItem(
              context,
              groupItems[index],
              index,
            ),
          ),
        ),
      );

      // Optional Separator Between Groups
      if (widget.separator != const SizedBox.shrink()) {
        slivers.add(SliverToBoxAdapter(child: widget.separator));
      }
    }

    // Optional Footer
    if (widget.footer != null) {
      slivers.add(SliverToBoxAdapter(child: widget.footer));
    }

    return slivers;
  }

  Widget _buildItem(BuildContext context, T element, int index) {
    final key = GlobalKey();
    _keys['$index'] = key;
    return Container(
      key: UniqueKey(),
      child: widget.indexedItemBuilder == null
          ? widget.itemBuilder!(context, element)
          : widget.indexedItemBuilder!(context, element, index),
    );
  }

  List<T> _sortElements() {
    var elements = [...widget.elements];
    if (widget.sort && elements.isNotEmpty) {
      elements.sort((e1, e2) {
        int? compareResult;
        if (widget.groupComparator != null) {
          compareResult = widget.groupComparator!(widget.groupBy(e1), widget.groupBy(e2));
        } else if (widget.groupBy(e1) is Comparable) {
          compareResult = (widget.groupBy(e1) as Comparable).compareTo(
            widget.groupBy(e2) as Comparable,
          );
        }

        if (compareResult == null || compareResult == 0) {
          if (widget.itemComparator != null) {
            compareResult = widget.itemComparator!(e1, e2);
          } else if (e1 is Comparable) {
            compareResult = e1.compareTo(e2);
          }
        }
        return compareResult!;
      });

      if (widget.order == GroupedListOrder.DESC) {
        elements = elements.reversed.toList();
      }
    }
    return elements;
  }

  Map<E, List<T>> _groupElements() {
    final map = <E, List<T>>{};
    for (final e in _sortedElements) {
      final key = widget.groupBy(e);
      map.putIfAbsent(key, () => []).add(e);
    }
    return map;
  }

  Widget _buildGroupSeparator(T element) {
    if (widget.groupHeaderBuilder == null) {
      return widget.groupSeparatorBuilder!(widget.groupBy(element));
    }
    return widget.groupHeaderBuilder!(element);
  }
}
