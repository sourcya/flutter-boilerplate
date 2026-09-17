import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/core/utils/extensions.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:sliver_tools/sliver_tools.dart';

enum GroupedListOrder { asc, desc }

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
    this.order = GroupedListOrder.asc,
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

    return MultiSliver(children: _pageSliverChildren(context));
  }

  List<Widget> _pageSliverChildren(BuildContext context) {
    final grouped = _groupElements();
    final slivers = <Widget>[];

    for (final entry in grouped.entries) {
      final groupItems = entry.value;

      slivers.add(
        SliverToBoxAdapter(
          child: _SliverGroupedGroupHeader<T, E>(
            firstInGroup: groupItems.first,
            groupBy: widget.groupBy,
            groupHeaderBuilder: widget.groupHeaderBuilder,
            groupSeparatorBuilder: widget.groupSeparatorBuilder,
          ),
        ),
      );

      slivers.add(
        SliverPadding(
          padding: context.paddingAll(8),
          sliver: SliverAlignedGrid.count(
            crossAxisCount: widget.crossAxisCount,
            mainAxisSpacing: widget.mainAxisSpacing,
            crossAxisSpacing: widget.crossAxisSpacing,
            itemCount: groupItems.length,
            itemBuilder: (ctx, index) {
              final element = groupItems[index];
              final key = GlobalKey();
              _keys['$index'] = key;
              return _SliverGroupedGridCell<T>(
                element: element,
                index: index,
                itemBuilder: widget.itemBuilder,
                indexedItemBuilder: widget.indexedItemBuilder,
              );
            },
          ),
        ),
      );

      if (widget.separator != const SizedBox.shrink()) {
        slivers.add(SliverToBoxAdapter(child: widget.separator));
      }
    }

    if (widget.footer != null) {
      slivers.add(SliverToBoxAdapter(child: widget.footer));
    }

    return slivers;
  }

  List<T> _sortElements() {
    var elements = [...widget.elements];
    if (widget.sort && elements.isNotEmpty) {
      elements.sort((e1, e2) {
        int? compareResult;
        if (widget.groupComparator != null) {
          compareResult = widget.groupComparator!(
            widget.groupBy(e1),
            widget.groupBy(e2),
          );
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

      if (widget.order == GroupedListOrder.desc) {
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
}

class _SliverGroupedGroupHeader<T, E> extends StatelessWidget {
  final T firstInGroup;
  final E Function(T element) groupBy;
  final Widget Function(T element)? groupHeaderBuilder;
  final Widget Function(E value)? groupSeparatorBuilder;

  const _SliverGroupedGroupHeader({
    required this.firstInGroup,
    required this.groupBy,
    this.groupHeaderBuilder,
    this.groupSeparatorBuilder,
  });

  @override
  Widget build(BuildContext context) {
    if (groupHeaderBuilder == null) {
      return groupSeparatorBuilder!(groupBy(firstInGroup));
    }
    return groupHeaderBuilder!(firstInGroup);
  }
}

class _SliverGroupedGridCell<T> extends StatelessWidget {
  final T element;
  final int index;
  final Widget Function(BuildContext context, T element)? itemBuilder;
  final Widget Function(BuildContext context, T element, int index)? indexedItemBuilder;

  const _SliverGroupedGridCell({
    required this.element,
    required this.index,
    this.itemBuilder,
    this.indexedItemBuilder,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      key: UniqueKey(),
      child: indexedItemBuilder == null
          ? itemBuilder!(context, element)
          : indexedItemBuilder!(context, element, index),
    );
  }
}
