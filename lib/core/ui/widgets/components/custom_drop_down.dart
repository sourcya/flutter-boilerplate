part of '../../ui.dart';

class AsyncDropdownState {
  const AsyncDropdownState._({
    required this.isInitial,
    required this.isLoading,
    required this.isEmpty,
    required this.isError,
    this.errorMessage,
    this.emptyMessage,
    this.onRetry,
    this.isInteractiveWhenEmpty = false,
  });

  const AsyncDropdownState.success()
    : this._(
        isInitial: false,
        isLoading: false,
        isEmpty: false,
        isError: false,
      );

  const AsyncDropdownState.initial()
    : this._(isInitial: true, isLoading: false, isEmpty: false, isError: false);

  const AsyncDropdownState.loading()
    : this._(isInitial: false, isLoading: true, isEmpty: false, isError: false);

  const AsyncDropdownState.error(String? errorMessage, {VoidCallback? onRetry})
    : this._(
        isInitial: false,
        isLoading: false,
        isEmpty: false,
        isError: true,
        errorMessage: errorMessage,
        onRetry: onRetry,
      );

  const AsyncDropdownState.empty(
    String? emptyMessage, {
    VoidCallback? onRetry,
    bool isInteractiveWhenEmpty = false,
  }) : this._(
         isInitial: false,
         isLoading: false,
         isEmpty: true,
         isError: false,
         emptyMessage: emptyMessage,
         onRetry: onRetry,
         isInteractiveWhenEmpty: isInteractiveWhenEmpty,
       );

  final bool isInitial;
  final bool isLoading;
  final bool isEmpty;
  final bool isError;
  final String? errorMessage;
  final String? emptyMessage;
  final VoidCallback? onRetry;
  final bool isInteractiveWhenEmpty;

  bool get hasError => isError || errorMessage?.trim().isNotEmpty == true;

  /// Field is tappable / editable (success, initial, or empty when allowed).
  bool get isInteractive =>
      !isInitial &&
      !isLoading &&
      !hasError &&
      (!isEmpty || isInteractiveWhenEmpty);

  factory AsyncDropdownState.fromDataState(
    DataState<dynamic> state, {
    VoidCallback? onRetry,
    String? emptyMessage,
    bool isInteractiveWhenEmpty = false,
  }) {
    if (state.isInitial) {
      return const AsyncDropdownState.initial();
    }
    if (state.isLoading) {
      return const AsyncDropdownState.loading();
    }
    if (state.isError) {
      return AsyncDropdownState.error(state.error?.message, onRetry: onRetry);
    }
    if (_isEmpty(state.data)) {
      return AsyncDropdownState.empty(
        emptyMessage,
        onRetry: onRetry,
        isInteractiveWhenEmpty: isInteractiveWhenEmpty,
      );
    }
    return const AsyncDropdownState.success();
  }

  /// Maps first-page load/error of a [BasePagedController] into field status.
  /// Success (incl. empty lists without error) stays interactive so the hint shows.
  factory AsyncDropdownState.fromPagedController(
    BasePagedController paged, {
    VoidCallback? onRetry,
    String? emptyMessage,
  }) {
    final items = paged.items;
    final isLoading = paged.isLoadingMore;
    final error = paged.pagingController.error;

    if (isLoading && items.isEmpty) {
      return const AsyncDropdownState.loading();
    }

    if (error != null && items.isEmpty) {
      if (error is EmptyDataError) {
        return AsyncDropdownState.empty(
          emptyMessage ?? error.message,
          onRetry: onRetry,
        );
      }
      final message = error is DataError ? error.message : error.toString();
      return AsyncDropdownState.error(message, onRetry: onRetry);
    }

    return const AsyncDropdownState.success();
  }

  /// Prefer explicit loading/error/empty; otherwise map from paged controller.
  factory AsyncDropdownState.of({
    required AsyncDropdownState explicit,
    BasePagedController? paged,
    VoidCallback? onPagedRetry,
  }) {
    if (explicit.isLoading || explicit.hasError || explicit.isEmpty) {
      return explicit;
    }
    if (paged == null) {
      return explicit;
    }
    return AsyncDropdownState.fromPagedController(paged, onRetry: onPagedRetry);
  }

  static bool _isEmpty(dynamic data) {
    if (data is Iterable) return data.isEmpty;
    if (data is Map) return data.isEmpty;
    if (data is String) return data.trim().isEmpty;
    return false;
  }
}

/// Shared loading / empty / error content for dropdown & autocomplete fields.
class _AsyncDropdownStateContent extends StatelessWidget {
  const _AsyncDropdownStateContent({
    required this.state,
    required this.hintStyle,
    required this.textColor,
  });

  final AsyncDropdownState state;
  final TextStyle hintStyle;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    if (state.isInitial) {
      return const SizedBox.shrink();
    }

    if (state.isLoading) {
      return Row(
        children: [
          SizedBox(
            width: 16.r,
            height: 16.r,
            child: const CenterLoading.adaptive(),
          ),
          8.0.wBox,
          Expanded(
            child: CustomText(
              AppTrans.loadingStatusLoading,
              textStyle: hintStyle.copyWith(color: textColor),
            ),
          ),
        ],
      );
    }

    if (state.isEmpty) {
      return _AsyncDropdownMessageRow(
        message: state.emptyMessage ?? AppTrans.noDataMessage,
        messageStyle: hintStyle.copyWith(color: textColor),
        onRetry: state.onRetry,
      );
    }

    return _AsyncDropdownMessageRow(
      message: state.errorMessage ?? AppTrans.unexpectedError,
      messageStyle: hintStyle.copyWith(color: context.colors.error),
      onRetry: state.onRetry,
    );
  }
}

class _AsyncDropdownMessageRow extends StatelessWidget {
  const _AsyncDropdownMessageRow({
    required this.message,
    required this.messageStyle,
    this.onRetry,
  });

  final String message;
  final TextStyle messageStyle;
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: CustomText(
            message.tr(context: context),
            textStyle: messageStyle,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            isTranslatable: false,
          ),
        ),
        if (onRetry != null) ...[
          8.0.wBox,
          GestureDetector(
            onTap: onRetry,
            behavior: HitTestBehavior.opaque,
            child: CustomText(
              AppTrans.retryText,
              textStyle: context.labelMediumTS.copyWith(
                color: context.colors.primary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ],
    );
  }
}

/// A reusable dropdown that builds menu items from a list of values.
/// Keeps sizing and hint style consistent with `CustomTextField`.
class CustomDropDown<T> extends StatefulWidget {
  const CustomDropDown({
    super.key,
    this.title,
    this.hint,
    this.hintWidget,
    this.isShowSearchIcon = false,
    this.items = const [],
    this.pagedController,
    this.selectedItem,
    this.onSelected,
    this.itemBuilder,
    this.labelBuilder,
    this.subtitleBuilder,
    this.bottomWidget,
    this.onBottomWidgetTap,
    this.child,
    this.contentPadding,
    this.offset,
    this.color,
    this.backgroundColor,
    this.borderRadius,
    this.icon,
    this.iconUrlBuilder,
    this.showCancel = false,
    this.showClearButton = false,
    this.isSearchable = false,
    this.searchHint,
    this.isShowArrowIcon = true,
    this.onSearch,
    this.selectedTextStyle,
    this.arrowColor,
    this.asyncState = const AsyncDropdownState.success(),
    this.onLoadMore,
    this.hasMore = false,
    this.isLoadingMore = false,
  });

  final String? title;
  final String? hint;
  final Widget? hintWidget;
  final bool isShowSearchIcon;
  final List<T> items;

  /// When set, items and load-more come from this paged controller.
  final BasePagedController<T>? pagedController;

  final T? selectedItem;
  final void Function(T?)? onSelected;
  final Widget Function(T)? itemBuilder;
  final String Function(T)? labelBuilder;
  final String Function(T)? subtitleBuilder;
  final Widget? bottomWidget;
  final VoidCallback? onBottomWidgetTap;
  final Widget? child;
  final EdgeInsetsGeometry? contentPadding;
  final Offset? offset;
  final Color? color;
  final Color? backgroundColor;
  final double? borderRadius;
  final Widget? icon;
  final String Function(T)? iconUrlBuilder;
  final bool showCancel;

  /// Show a clear button next to the dropdown arrow to clear selection
  final bool showClearButton;

  /// Enable autocomplete - main field becomes editable text field
  final bool isSearchable;

  /// Hint text for the search field
  final String? searchHint;

  /// Show/hide the arrow dropdown icon
  final bool isShowArrowIcon;

  /// Called when the search text changes — use for server-side searching.
  /// When provided, items filtering is skipped (API already filtered results).
  final void Function(String)? onSearch;

  /// Custom text style for the selected item
  final TextStyle? selectedTextStyle;

  /// Custom color for the dropdown arrow icon
  final Color? arrowColor;
  final AsyncDropdownState asyncState;

  /// Fallback load-more when [pagedController] is not used (e.g. mapped options).
  final VoidCallback? onLoadMore;
  final bool hasMore;
  final bool isLoadingMore;

  @override
  State<CustomDropDown<T>> createState() => _CustomDropDownState<T>();
}

class _CustomDropDownState<T> extends State<CustomDropDown<T>> {
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  final ValueNotifier<Object?> _openDropdownListenable = ValueNotifier<Object?>(
    null,
  );
  late final ValueNotifier<T?> _selectedValueNotifier;
  String _searchText = '';
  bool _isDropdownOpen = false;

  @override
  void initState() {
    super.initState();
    _selectedValueNotifier = ValueNotifier<T?>(widget.selectedItem);
    if (widget.isSearchable && widget.selectedItem != null) {
      _searchController.text = _getLabel(widget.selectedItem as T);
    }
    _focusNode.addListener(_onFocusChange);
    _searchController.addListener(_onSearchChanged);
  }

  void _onSearchChanged() {
    if (_searchText != _searchController.text) {
      setState(() {
        _searchText = _searchController.text;
      });
      widget.onSearch?.call(_searchController.text);
    }
  }

  void _onFocusChange() {
    if (_focusNode.hasFocus && !_isDropdownOpen) {
      _openDropdownListenable.value = Object();
    }
  }

  @override
  void didUpdateWidget(CustomDropDown<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.selectedItem != oldWidget.selectedItem) {
      _selectedValueNotifier.value = widget.selectedItem;
    }
    if (widget.isSearchable && widget.selectedItem != oldWidget.selectedItem) {
      final nextText = widget.selectedItem != null
          ? _getLabel(widget.selectedItem as T)
          : '';
      if (_searchController.text != nextText) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (!mounted) return;
          if (widget.selectedItem != null) {
            final label = _getLabel(widget.selectedItem as T);
            if (_searchController.text != label) {
              _searchController.text = label;
            }
          } else if (_searchController.text.isNotEmpty) {
            _searchController.clear();
          }
        });
      }
    }
  }

  @override
  void dispose() {
    _focusNode.removeListener(_onFocusChange);
    _searchController.removeListener(_onSearchChanged);
    _openDropdownListenable.dispose();
    _selectedValueNotifier.dispose();
    _searchController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  String _getLabel(T item) {
    return widget.labelBuilder?.call(item) ?? item.toString();
  }

  AsyncDropdownState _resolveAsyncState() {
    final paged = widget.pagedController;
    return AsyncDropdownState.of(
      explicit: widget.asyncState,
      paged: paged,
      onPagedRetry: paged == null
          ? null
          : () {
              unawaited(paged.refreshData());
            },
    );
  }

  bool _isFieldInteractive(AsyncDropdownState asyncState) =>
      asyncState.isInitial || asyncState.isInteractive;

  @override
  Widget build(BuildContext context) {
    final paged = widget.pagedController;
    if (paged == null) {
      final asyncState = _resolveAsyncState();
      return _CustomDropDownView<T>(
        widget: widget,
        asyncState: asyncState,
        effectiveItems: widget.items,
        isInteractive: _isFieldInteractive(asyncState),
        searchController: _searchController,
        focusNode: _focusNode,
        openDropdownListenable: _openDropdownListenable,
        selectedValueNotifier: _selectedValueNotifier,
        getLabel: _getLabel,
        onMenuStateChange: _onMenuStateChange,
      );
    }

    return ListenableBuilder(
      listenable: Listenable.merge([
        paged.pagingController,
        paged.isLoadingListenable,
      ]),
      builder: (context, _) {
        final asyncState = _resolveAsyncState();
        return _CustomDropDownView<T>(
          widget: widget,
          asyncState: asyncState,
          effectiveItems: paged.items,
          isInteractive: _isFieldInteractive(asyncState),
          searchController: _searchController,
          focusNode: _focusNode,
          openDropdownListenable: _openDropdownListenable,
          selectedValueNotifier: _selectedValueNotifier,
          getLabel: _getLabel,
          onMenuStateChange: _onMenuStateChange,
        );
      },
    );
  }

  void _onMenuStateChange(bool isOpen) {
    _isDropdownOpen = isOpen;
    final paged = widget.pagedController;
    if (isOpen) {
      unawaited(paged?.ensureInitialized());
    }
    if (isOpen && widget.isSearchable) {
      Future.delayed(const Duration(milliseconds: 100), () {
        if (mounted && _focusNode.canRequestFocus) {
          _focusNode.requestFocus();
        }
      });
    }
    if (!isOpen) {
      _searchController.clear();
      if (widget.selectedItem != null) {
        _searchController.text = _getLabel(widget.selectedItem as T);
      }
    }
  }
}

class _CustomDropDownView<T> extends StatelessWidget {
  const _CustomDropDownView({
    required this.widget,
    required this.asyncState,
    required this.effectiveItems,
    required this.isInteractive,
    required this.searchController,
    required this.focusNode,
    required this.openDropdownListenable,
    required this.selectedValueNotifier,
    required this.getLabel,
    required this.onMenuStateChange,
  });

  final CustomDropDown<T> widget;
  final AsyncDropdownState asyncState;
  final List<T> effectiveItems;
  final bool isInteractive;
  final TextEditingController searchController;
  final FocusNode focusNode;
  final ValueNotifier<Object?> openDropdownListenable;
  final ValueNotifier<T?> selectedValueNotifier;
  final String Function(T) getLabel;
  final ValueChanged<bool> onMenuStateChange;

  @override
  Widget build(BuildContext context) {
    final TextStyle hintTextStyle = context.titleMediumTS.copyWith(
      color: context.colors.subtitleTextColor,
      fontWeight: FontWeight.w400,
    );
    final hasAsyncError = asyncState.hasError;
    final borderColor = hasAsyncError
        ? context.colors.error
        : widget.color ?? context.colors.borderColor;

    // Outside DropdownButton2 so Try Again / retry taps are not swallowed by the
    // disabled InkWell (items empty + onChanged null).
    final Widget field = !isInteractive
        ? (widget.isSearchable
              ? _SearchableDropDownButton<T>(
                  widget: widget,
                  asyncState: asyncState,
                  isInteractive: false,
                  borderColor: borderColor,
                  hintTextStyle: hintTextStyle,
                  searchController: searchController,
                  focusNode: focusNode,
                )
              : widget.child ??
                    _DefaultDropDownButton<T>(
                      widget: widget,
                      asyncState: asyncState,
                      isInteractive: false,
                      borderColor: borderColor,
                      hintTextStyle: hintTextStyle,
                    ))
        : DropdownButtonHideUnderline(
            child: DropdownButton2<T>(
              openDropdownListenable: widget.isSearchable
                  ? openDropdownListenable
                  : null,
              isExpanded: true,
              customButton: widget.isSearchable
                  ? _SearchableDropDownButton<T>(
                      widget: widget,
                      asyncState: asyncState,
                      isInteractive: true,
                      borderColor: borderColor,
                      hintTextStyle: hintTextStyle,
                      searchController: searchController,
                      focusNode: focusNode,
                    )
                  : widget.child ??
                        _DefaultDropDownButton<T>(
                          widget: widget,
                          asyncState: asyncState,
                          isInteractive: true,
                          borderColor: borderColor,
                          hintTextStyle: hintTextStyle,
                        ),
              items: _DropDownMenuItemsBuilder<T>(
                widget: widget,
                effectiveItems: effectiveItems,
              ).buildItems(context),
              valueListenable: selectedValueNotifier,
              onChanged: (v) {
                selectedValueNotifier.value = v;
                widget.onSelected?.call(v);
                if (widget.isSearchable && v != null) {
                  searchController.text = getLabel(v);
                }
              },
              dropdownStyleData: DropdownStyleData(
                maxHeight: 400.r,
                offset: widget.offset ?? Offset.zero,
                decoration: BoxDecoration(
                  borderRadius: 14.radius,
                  color: context.colors.cardColor,
                ),
                scrollbarTheme: ScrollbarThemeData(
                  radius: Radius.circular(40.0.r),
                  thickness: WidgetStateProperty.all(6.0),
                  thumbVisibility: WidgetStateProperty.all(true),
                ),
              ),
              onMenuStateChange: onMenuStateChange,
              buttonStyleData: ButtonStyleData(
                padding: widget.contentPadding != null
                    ? EdgeInsets.zero
                    : EdgeInsets.symmetric(
                        vertical: 12.0.r,
                        horizontal: 10.0.r,
                      ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    widget.borderRadius?.r ?? 30.r,
                  ),
                  border: Border.all(color: borderColor),
                  color: widget.backgroundColor ?? context.colors.cardColor,
                ),
              ),
              iconStyleData: IconStyleData(
                icon: Icon(Icons.keyboard_arrow_down_rounded, size: 22.r),
                iconEnabledColor: widget.arrowColor ?? context.colors.primary,
                iconDisabledColor: const Color(0xFF9E9E9E),
              ),
              menuItemStyleData: MenuItemStyleData(
                padding:
                    widget.contentPadding ??
                    EdgeInsets.symmetric(vertical: 12.0.r, horizontal: 10.0.r),
              ),
              dropdownSearchData: widget.isSearchable
                  ? DropdownSearchData<T>(
                      searchController: searchController,
                      searchMatchFn: (item, searchValue) {
                        if (item.value == null) {
                          if (searchValue.isEmpty) return false;
                          if (widget.onSearch != null) {
                            return effectiveItems.isEmpty;
                          }
                          final hasMatch = effectiveItems.any(
                            (i) => getLabel(
                              i,
                            ).toLowerCase().contains(searchValue.toLowerCase()),
                          );
                          return !hasMatch;
                        }
                        if (widget.onSearch != null) return true;
                        return getLabel(
                          item.value as T,
                        ).toLowerCase().contains(searchValue.toLowerCase());
                      },
                    )
                  : null,
            ),
          );

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.title != null) ...[
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: widget.title?.replaceAll(' *', ''),
                  style: context.titleMediumTS.copyWith(
                    color: context.colors.onSurface,
                  ),
                ),
                if (widget.title?.contains('*') == true)
                  TextSpan(
                    text: ' *',
                    style: context.titleMediumTS.copyWith(
                      color: context.colors.error,
                    ),
                  ),
              ],
            ),
          ),
          8.0.hBox,
        ],
        field,
      ],
    );
  }
}

class _SearchableDropDownButton<T> extends StatelessWidget {
  const _SearchableDropDownButton({
    required this.widget,
    required this.asyncState,
    required this.isInteractive,
    required this.borderColor,
    required this.hintTextStyle,
    required this.searchController,
    required this.focusNode,
  });

  final CustomDropDown<T> widget;
  final AsyncDropdownState asyncState;
  final bool isInteractive;
  final Color borderColor;
  final TextStyle hintTextStyle;
  final TextEditingController searchController;
  final FocusNode focusNode;

  @override
  Widget build(BuildContext context) {
    final contentPadding =
        widget.contentPadding ??
        EdgeInsets.symmetric(
          vertical: 12.r,
          horizontal: widget.isShowSearchIcon ? 8.r : 12.r,
        );

    return ConstrainedBox(
      constraints: BoxConstraints(minHeight: 48.r, maxHeight: 48.r),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(widget.borderRadius?.r ?? 30.0.r),
          border: Border.all(color: borderColor),
          color: widget.backgroundColor ?? context.colors.cardColor,
        ),
        child: Row(
          children: [
            if (widget.isShowSearchIcon) ...[
              Padding(
                padding: EdgeInsetsDirectional.only(start: 12.0.r),
                child: IconInfo.svg(
                  Assets.icons.search,
                  size: 18.r,
                ).buildIconWidget(),
              ),
            ],
            Expanded(
              child: isInteractive
                  ? TextField(
                      controller: searchController,
                      focusNode: focusNode,
                      readOnly: !isInteractive,
                      textAlignVertical: TextAlignVertical.center,
                      style: context.titleMediumTS.copyWith(
                        color: context.colors.onSurface,
                        fontWeight: FontWeight.w400,
                      ),
                      decoration: InputDecoration(
                        fillColor: AppColors.transparent,
                        hoverColor: Colors.transparent,
                        focusColor: Colors.transparent,
                        hintText: widget.hint,
                        hintStyle: hintTextStyle,
                        isCollapsed: true,
                        border: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        contentPadding: contentPadding,
                      ),
                    )
                  : Padding(
                      padding: contentPadding,
                      child: _AsyncDropdownStateContent(
                        state: asyncState,
                        hintStyle: hintTextStyle,
                        textColor: context.colors.onSurface,
                      ),
                    ),
            ),
            if (isInteractive &&
                widget.showClearButton &&
                widget.selectedItem != null)
              _DropDownClearButton(
                endPadding: widget.isShowArrowIcon ? 0.0 : 10.0,
                onPressed: () {
                  widget.onSelected?.call(null);
                  searchController.clear();
                },
              ),
            if (isInteractive && widget.isShowArrowIcon)
              Padding(
                padding: EdgeInsetsDirectional.only(end: 10.r),
                child: Icon(
                  Icons.keyboard_arrow_down_rounded,
                  size: 22.r,
                  color: widget.arrowColor ?? context.colors.onAppBar,
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _DefaultDropDownButton<T> extends StatelessWidget {
  const _DefaultDropDownButton({
    required this.widget,
    required this.asyncState,
    required this.isInteractive,
    required this.borderColor,
    required this.hintTextStyle,
  });

  final CustomDropDown<T> widget;
  final AsyncDropdownState asyncState;
  final bool isInteractive;
  final Color borderColor;
  final TextStyle hintTextStyle;

  @override
  Widget build(BuildContext context) {
    final contentPadding =
        widget.contentPadding ??
        EdgeInsets.symmetric(vertical: 12.0.r, horizontal: 10.0.r);

    return Container(
      padding: contentPadding,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(widget.borderRadius?.r ?? 30.0.r),
        border: Border.all(color: borderColor),
        color: widget.backgroundColor ?? context.colors.cardColor,
      ),
      child: Row(
        children: [
          if (widget.isShowSearchIcon) ...[
            IconInfo.svg(Assets.icons.search, size: 18.r).buildIconWidget(),
            8.wBox,
          ],
          Expanded(
            child: isInteractive
                ? CustomText(
                    widget.selectedItem != null
                        ? (widget.labelBuilder?.call(
                                widget.selectedItem as T,
                              ) ??
                              widget.selectedItem.toString())
                        : (widget.hint ?? ''),
                    textStyle: widget.selectedItem != null
                        ? (widget.selectedTextStyle ??
                              context.titleMediumTS.copyWith(
                                color: context.colors.onSurface,
                                fontWeight: FontWeight.w400,
                              ))
                        : hintTextStyle,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    isTranslatable: false,
                  )
                : _AsyncDropdownStateContent(
                    state: asyncState,
                    hintStyle: hintTextStyle,
                    textColor: context.colors.onSurface,
                  ),
          ),
          if (isInteractive &&
              widget.showClearButton &&
              widget.selectedItem != null)
            _DropDownClearButton(
              endPadding: widget.isShowArrowIcon ? 0.0 : 10.0,
              onPressed: () => widget.onSelected?.call(null),
              useRoundedCloseIcon: true,
            ),
          if (isInteractive && widget.isShowArrowIcon)
            Icon(
              Icons.keyboard_arrow_down_rounded,
              size: 22.r,
              color: widget.arrowColor ?? context.colors.onAppBar,
            ),
        ],
      ),
    );
  }
}

class _DropDownClearButton extends StatelessWidget {
  const _DropDownClearButton({
    required this.onPressed,
    this.endPadding = 0.0,
    this.useRoundedCloseIcon = false,
  });

  final VoidCallback onPressed;
  final double endPadding;
  final bool useRoundedCloseIcon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: context.paddingOnly(end: endPadding),
      child: ActionButton(
        title: '',
        onPressed: onPressed,
        backgroundColor: AppColors.transparent,
        foregroundColor: context.colors.subtitleTextColor,
        icon: useRoundedCloseIcon
            ? Icon(
                Icons.close_rounded,
                size: 18.r,
                color: context.colors.subtitleTextColor,
              )
            : IconInfo.icon(
                Icons.close,
                size: 18.r,
                color: context.colors.subtitleTextColor,
              ).buildIconWidget(),
        padding: EdgeInsets.zero,
        constraints: BoxConstraints.tightFor(width: 24.r, height: 24.r),
      ),
    );
  }
}

/// Builds dropdown menu items, including search empty-state and pagination.
class _DropDownMenuItemsBuilder<T> {
  const _DropDownMenuItemsBuilder({
    required this.widget,
    required this.effectiveItems,
  });

  final CustomDropDown<T> widget;
  final List<T> effectiveItems;

  List<DropdownItem<T>> buildItems(BuildContext context) {
    final paged = widget.pagedController;
    final List<DropdownItem<T>> items = effectiveItems.map((T item) {
      return DropdownItem<T>(
        value: item,
        height: 48.r,
        alignment: Alignment.center,
        child:
            widget.itemBuilder?.call(item) ??
            _DefaultDropDownItem<T>(
              item: item,
              isSelected: widget.selectedItem == item,
              label: widget.labelBuilder?.call(item) ?? item.toString(),
              icon: widget.icon,
              iconUrl: widget.iconUrlBuilder?.call(item),
              showCancel: widget.showCancel && widget.selectedItem == item,
              onCancel: () => widget.onSelected?.call(null),
            ),
      );
    }).toList();

    if (widget.isSearchable) {
      items.add(
        DropdownItem<T>(
          enabled: false,
          height: 48.r,
          child: Center(
            child: CustomText(
              AppTrans.noDataMessage,
              fontSize: 14.sp,
              color: context.colors.subtitleTextColor,
            ),
          ),
        ),
      );
    }

    if (paged != null && effectiveItems.isEmpty && paged.isLoadingMore) {
      items.add(
        DropdownItem<T>(
          enabled: false,
          height: 48.r,
          child: const Center(child: CenterLoading.adaptive()),
        ),
      );
    }

    final isLoadingMore = paged?.isLoadingMore ?? widget.isLoadingMore;
    final hasMore = paged?.hasMore ?? widget.hasMore;
    final canLoadMore = paged != null || widget.onLoadMore != null;

    if (canLoadMore &&
        effectiveItems.isNotEmpty &&
        (hasMore || isLoadingMore)) {
      items.add(
        DropdownItem<T>(
          enabled: false,
          height: 48.r,
          child: isLoadingMore
              ? const Center(child: CenterLoading.adaptive())
              : _DropDownLoadMoreTrigger(
                  onLoadMore: () {
                    if (paged != null) {
                      unawaited(paged.fetchNextPage());
                    } else {
                      widget.onLoadMore?.call();
                    }
                  },
                ),
        ),
      );
    }

    return items;
  }
}

class _DropDownLoadMoreTrigger extends StatelessWidget {
  const _DropDownLoadMoreTrigger({required this.onLoadMore});

  final VoidCallback onLoadMore;

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) => onLoadMore());
    return SizedBox(height: 8.r);
  }
}

class _DefaultDropDownItem<T> extends StatelessWidget {
  const _DefaultDropDownItem({
    required this.item,
    required this.isSelected,
    required this.label,
    required this.showCancel,
    this.icon,
    this.iconUrl,
    this.onCancel,
  });

  final T item;
  final bool isSelected;
  final String label;
  final bool showCancel;
  final Widget? icon;
  final String? iconUrl;
  final VoidCallback? onCancel;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (icon != null) ...[icon!, SizedBox(width: 8.r)],
        if (iconUrl != null) ...[
          SizedBox(
            width: 20.r,
            height: 20.r,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(14.r),
              child: CachedNetworkImage(
                imageUrl: iconUrl ?? '',
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(width: 12.r),
        ],
        Expanded(
          child: CustomText(
            label,
            fontSize: 12.sp,
            color: context.colors.onSurface,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
          ),
        ),
        if (showCancel) ...[
          SizedBox(width: 8.r),
          InkWell(
            onTap: onCancel,
            child: Icon(
              Icons.close_rounded,
              size: 18.r,
              color: context.colors.primary,
            ),
          ),
        ],
      ],
    );
  }
}
