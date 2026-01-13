part of '../../ui.dart';

class ErrorDataWidget extends OrientationWidget {
  final VoidCallback? onRetryClicked;
  final String error;
  final String? retryLabel;
  final bool isScrollable;

  final double? animationHeight;

  const ErrorDataWidget({
    super.key,
    this.onRetryClicked,
    required this.error,
    this.retryLabel,
    this.isScrollable = true,
    this.animationHeight,
  });

  @override
  Widget build(BuildContext context) {
    final isMobile = context.height < 600;
    return context.isLandscape && isMobile ? buildLandscape(context) : buildPortrait(context);
  }

  @override
  Widget buildLandscape(BuildContext context) {
    final column = Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: EdgeInsets.all(4.0.r),
          child: CustomText(
            error,
            textAlign: TextAlign.center,
            fontWeight: FontWeight.w400,
            fontSize: context.width < 720 ? 16.sp : 20.sp,
          ),
        ),
        if (onRetryClicked != null) ...[
          SizedBox(height: context.width < 720 ? 8.r : 15.r),
          CustomElevatedButton(
            backgroundColor: context.colors.primary,
            onPressed: onRetryClicked,
            label: retryLabel ?? AppTrans.retryText,
            width: context.height < 600 ? null : context.width * .5,
          ),
        ],
        SizedBox(height: context.width < 720 ? 4.r : 15.r),
      ],
    );
    return Padding(
      padding: EdgeInsets.all(4.0.r),
      child: Center(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(
              child: ConstrainedBox(
                constraints: BoxConstraints(maxHeight: context.height * .24),
                child: Lottie.asset(
                  Assets.animations.error,
                  height: animationHeight ?? context.height * .25,
                ),
              ),
            ),
            SizedBox(height: 6.r),
            if (!isScrollable) column else Expanded(child: OptimizedScrollView(child: column)),
          ],
        ),
      ),
    );
  }

  @override
  Widget buildPortrait(BuildContext context) {
    final isMobile = context.height < 600;

    return Padding(
      padding: EdgeInsets.all(4.0.r),
      child: (!isScrollable)
          ? _body(isMobile, context)
          : OptimizedScrollView(child: _body(isMobile, context)),
    );
  }

  Center _body(bool isMobile, BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: isMobile ? null : animationHeight ?? context.height * .5,
            child: Lottie.asset(Assets.animations.error),
          ),
          SizedBox(height: 6.r),
          Padding(
            padding: EdgeInsets.all(4.0.r),
            child: CustomText(
              error,
              textAlign: TextAlign.center,
              fontWeight: FontWeight.w400,
              fontSize: context.width < 720 ? 16.sp : 20.sp,
            ),
          ),
          if (onRetryClicked != null) ...[
            SizedBox(height: context.width < 720 ? 8.r : 15.r),
            CustomElevatedButton(
              backgroundColor: context.colors.primary,
              onPressed: onRetryClicked,
              label: retryLabel ?? AppTrans.retryText,
              width: isMobile ? null : context.width * .5,
            ),
          ],
          SizedBox(height: context.width < 720 ? 4.r : 15.r),
        ],
      ),
    );
  }
}
