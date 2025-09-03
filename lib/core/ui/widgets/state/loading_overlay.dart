part of '../../ui.dart';

class LoadingOverlay extends StatelessWidget {
  final LoadingStatus loadingStatus;
  final String? loadingText;

  const LoadingOverlay({
    super.key,
    required this.loadingStatus,
    this.loadingText,
  });

  @override
  Widget build(BuildContext context) {
    final text = loadingText ?? loadingStatus.displayName;
    return Material(
      color: Colors.transparent,
      child: AnimatedVisibility(
        isVisible: loadingStatus is! LoadingStatusIdle,
        child: Container(
          color: Colors.black.withValues(alpha: .5),
          height: double.infinity,
          child: Center(
            child: Card(
              color: context.colors.surfaceContainer.withValues(alpha: .7),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 8.0.r, vertical: 16.r),
                    child: CenterLoading.adaptive(
                      color: context.colors.primary,
                    ),
                  ),
                  if (text.isNotEmpty) ...[
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(
                        horizontal: 8.0.r,
                        vertical: 8.r,
                      ),
                      child: AnimatedDottedText(
                        text: text,
                        style: TextStyle(
                          fontSize: 16.sp,
                          color: context.colors.onSurface,
                          fontFamily: fontFamily(context: context),
                        ),
                        color: context.colors.onSurface,
                      ),
                    ),
                    SizedBox(height: 16.r),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// Animated Dotted Text
// animate ... for text
class AnimatedDottedText extends StatefulWidget {
  final String text;
  final Duration duration;
  final TextStyle? style;
  final int dotsCount;
  final Color color;
  final bool isTranslatable;

  const AnimatedDottedText({
    super.key,
    required this.text,
    this.duration = const Duration(milliseconds: 1000),
    this.style,
    this.dotsCount = 3,
    this.color = Colors.black,
    this.isTranslatable = true,
  });

  @override
  State<AnimatedDottedText> createState() => _AnimatedDottedTextState();
}

class _AnimatedDottedTextState extends State<AnimatedDottedText>
    with SingleTickerProviderStateMixin {
  late final controller =
      AnimationController(vsync: this, duration: widget.duration);
  late final animation = CurvedAnimation(
    parent: controller,
    curve: Curves.easeInOut,
  );
  late final tween = IntTween(begin: 0, end: widget.dotsCount);

  @override
  void initState() {
    super.initState();
    controller.repeat(reverse: true);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        final visibleDotsCount = tween.evaluate(animation);
        return Text(
          // show dot or space
          '${widget.isTranslatable ? widget.text.tr(context: context) : widget.text}${'.' * visibleDotsCount}${' ' * (widget.dotsCount - visibleDotsCount)}',
          style: widget.style,
          textAlign: TextAlign.center,
        );
      },
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
