part of '../../ui.dart';

class WebBodySelectionArea extends StatelessWidget {
  final Widget child;

  const WebBodySelectionArea({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    if (!kIsWeb) return child;
    return SelectionArea(child: child);
  }
}

class WebTableSelectionScope extends InheritedWidget {
  const WebTableSelectionScope({super.key, required super.child});

  static bool maybeOf(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<WebTableSelectionScope>() != null;

  @override
  bool updateShouldNotify(covariant WebTableSelectionScope oldWidget) => false;
}

class WebSelectableRichText extends StatelessWidget {
  final TextSpan text;
  final int? maxLines;
  final TextOverflow overflow;
  final TextAlign textAlign;
  final StrutStyle? strutStyle;
  final TextWidthBasis textWidthBasis;
  final Locale? locale;
  final bool softWrap;
  final bool isSelectable;

  const WebSelectableRichText({
    super.key,
    required this.text,
    this.maxLines,
    this.overflow = TextOverflow.clip,
    this.textAlign = TextAlign.start,
    this.strutStyle,
    this.textWidthBasis = TextWidthBasis.parent,
    this.locale,
    this.softWrap = true,
    this.isSelectable = true,
  });

  @override
  Widget build(BuildContext context) {
    if (kIsWeb && isSelectable) {
      return SelectableText.rich(
        text,
        maxLines: maxLines,
        textAlign: textAlign,
        strutStyle: strutStyle,
        textWidthBasis: textWidthBasis,
        selectionColor: DefaultSelectionStyle.of(context).selectionColor,
      );
    }

    return RichText(
      text: text,
      maxLines: maxLines,
      overflow: overflow,
      textAlign: textAlign,
      strutStyle: strutStyle,
      textWidthBasis: textWidthBasis,
      locale: locale,
      softWrap: softWrap,
      selectionRegistrar: SelectionContainer.maybeOf(context),
      selectionColor: kIsWeb ? DefaultSelectionStyle.of(context).selectionColor : null,
    );
  }
}

class WebDetailsSelectionArea extends WebBodySelectionArea {
  const WebDetailsSelectionArea({
    super.key,
    required super.child,
  });
}

class WebDetailsSelectableRichText extends WebSelectableRichText {
  const WebDetailsSelectableRichText({
    super.key,
    required super.text,
    super.maxLines,
    super.overflow,
    super.textAlign,
    super.strutStyle,
    super.textWidthBasis,
    super.locale,
    super.softWrap,
    super.isSelectable,
  });
}

class WebSelectionDisabledContainer extends StatelessWidget {
  final Widget child;
  final MouseCursor cursor;

  const WebSelectionDisabledContainer({
    super.key,
    required this.child,
    this.cursor = SystemMouseCursors.click,
  });

  @override
  Widget build(BuildContext context) {
    final content = MouseRegion(
      cursor: cursor,
      child: child,
    );

    if (!kIsWeb) return content;
    return SelectionContainer.disabled(child: content);
  }
}

class WebSelectionDisabledGestureDetector extends StatelessWidget {
  final Widget child;
  final VoidCallback? onTap;
  final GestureTapDownCallback? onTapDown;
  final GestureTapUpCallback? onTapUp;
  final GestureTapCancelCallback? onTapCancel;
  final GestureDragStartCallback? onHorizontalDragStart;
  final GestureDragUpdateCallback? onHorizontalDragUpdate;
  final GestureDragEndCallback? onHorizontalDragEnd;
  final GestureDragCancelCallback? onHorizontalDragCancel;
  final GestureDragEndCallback? onVerticalDragEnd;
  final GestureDragStartCallback? onPanStart;
  final GestureDragUpdateCallback? onPanUpdate;
  final GestureDragEndCallback? onPanEnd;
  final HitTestBehavior behavior;
  final MouseCursor enabledCursor;
  final MouseCursor disabledCursor;

  const WebSelectionDisabledGestureDetector({
    super.key,
    required this.child,
    this.onTap,
    this.onTapDown,
    this.onTapUp,
    this.onTapCancel,
    this.onHorizontalDragStart,
    this.onHorizontalDragUpdate,
    this.onHorizontalDragEnd,
    this.onHorizontalDragCancel,
    this.onVerticalDragEnd,
    this.onPanStart,
    this.onPanUpdate,
    this.onPanEnd,
    this.behavior = HitTestBehavior.deferToChild,
    this.enabledCursor = SystemMouseCursors.click,
    this.disabledCursor = MouseCursor.defer,
  });

  @override
  Widget build(BuildContext context) {
    final hasEnabledGesture = onTap != null ||
        onTapDown != null ||
        onTapUp != null ||
        onTapCancel != null ||
        onHorizontalDragStart != null ||
        onHorizontalDragUpdate != null ||
        onHorizontalDragEnd != null ||
        onHorizontalDragCancel != null ||
        onVerticalDragEnd != null ||
        onPanStart != null ||
        onPanUpdate != null ||
        onPanEnd != null;

    return WebSelectionDisabledContainer(
      cursor: hasEnabledGesture ? enabledCursor : disabledCursor,
      child: GestureDetector(
        onTap: onTap,
        onTapDown: onTapDown,
        onTapUp: onTapUp,
        onTapCancel: onTapCancel,
        onHorizontalDragStart: onHorizontalDragStart,
        onHorizontalDragUpdate: onHorizontalDragUpdate,
        onHorizontalDragEnd: onHorizontalDragEnd,
        onHorizontalDragCancel: onHorizontalDragCancel,
        onVerticalDragEnd: onVerticalDragEnd,
        onPanStart: onPanStart,
        onPanUpdate: onPanUpdate,
        onPanEnd: onPanEnd,
        behavior: behavior,
        child: child,
      ),
    );
  }
}
