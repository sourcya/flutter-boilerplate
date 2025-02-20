part of '../../ui.dart';

class LoadingOverlay extends StatelessWidget {
  final bool isLoading;
  final String? loadingText;

  const LoadingOverlay({super.key, required this.isLoading, this.loadingText});

  @override
  Widget build(BuildContext context) {
    if (!isLoading) return const SizedBox.shrink();
    return Material(
      color: Colors.transparent,
      child: Container(
        color: Colors.black.withValues(alpha: .5),
        height: double.infinity,
        child: Center(
          child: CustomCard(
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
                if (loadingText != null && loadingText!.isNotEmpty) ...[
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(
                      horizontal: 8.0.r,
                      vertical: 8.r,
                    ),
                    child: AnimatedDottedText(
                      text: loadingText ?? '',
                      style: TextStyle(
                        fontSize: 16.sp,
                        color: context.colors.onSurface,
                        fontFamily: fontFamily,
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
        return Text(
          '${widget.isTranslatable ? widget.text.tr(context: context) : widget.text}${'.' * tween.evaluate(animation)}',
          style: widget.style,
          textAlign: TextAlign.center,
        );
      },
    );
  }
}
