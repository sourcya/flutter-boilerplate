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
    return AnimatedVisibility(
      isVisible: loadingStatus is! LoadingStatusIdle,
      child: Container(
        color: Colors.black.withValues(alpha: .5),
        height: double.infinity,
        child: Center(
          child: Container(
            width: context.width > 600
                ? context.width * .5
                : context.width > 900
                ? context.width * .35
                : context.width > 1200
                ? context.width * .25
                : double.infinity,
            margin: EdgeInsets.symmetric(horizontal: 32.r),
            child: Card(
              color: Colors.black.withValues(alpha: .55),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.0.r, vertical: 16.r),
                    child: const CenterLoading.adaptive(
                      color: Colors.white,
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
                          color: Colors.white,
                          fontFamily: fontFamily(context: context),
                        ),
                        color: Colors.white,
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
  late final controller = AnimationController(vsync: this, duration: widget.duration);
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
