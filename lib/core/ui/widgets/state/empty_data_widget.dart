part of '../../ui.dart';

class EmptyDataWidget extends OrientationWidget {
  final VoidCallback? onRetryClicked;
  final VoidCallback? onActionClicked;
  final String? actionText;
  final String? error;
  final String? subtitle;
  final bool isScrollable;
  final Color? errorColor;
  final double? animationHeight;

  const EmptyDataWidget({
    super.key,
    this.onRetryClicked,
    this.error,
    this.subtitle,
    this.isScrollable = true,
    this.errorColor,
    this.animationHeight,
    this.onActionClicked,
    this.actionText,
  });

  @override
  Widget build(BuildContext context) {
    final isMobile = context.height < 600;
    return context.isLandscape && isMobile ? buildLandscape(context) : buildPortrait(context);
  }

  @override
  Widget buildLandscape(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(4.0.r),
      child: Center(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  maxHeight: animationHeight ?? context.height * .25,
                ),
                child: Lottie.asset(
                  Assets.animations.noDataAnimation,
                  height: animationHeight,
                ),
              ),
            ),
            SizedBox(height: 6.r),
            Expanded(
              child: OptimizedScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(4.0.r),
                      child: CustomText(
                        error ?? AppTrans.emptyResponse.tr(context: context),
                        textAlign: TextAlign.center,
                        fontWeight: FontWeight.w400,
                        fontSize: context.width < 720 ? 16.sp : 20.sp,
                        color: errorColor,
                      ),
                    ),
                    if (subtitle != null) ...[
                      SizedBox(height: 12.h),
                      CustomText(
                        subtitle ?? "",
                        textStyle: context.textTheme.bodyMedium?.copyWith(
                          color: context.colors.onSurfaceVariant,
                        ),
                        textAlign: TextAlign.center,
                        maxLines: 3,
                        textOverflow: TextOverflow.ellipsis,
                      ),
                    ],
                    if (actionText != null && onActionClicked != null) ...[
                      SizedBox(height: 32.h),
                      CustomElevatedButton(
                        onPressed: onActionClicked,
                        icon: IconInfo.icon(Icons.add, size: 18.sp),
                        label: actionText,
                        width: context.height < 600 ? null : context.width * .5,
                      ),
                    ],
                    if (onRetryClicked != null) ...[
                      SizedBox(
                        height: context.width < 720 ? 4.r : 15.r,
                      ),
                      CustomElevatedButton(
                        backgroundColor: context.colors.primary,
                        onPressed: onRetryClicked,
                        label: AppTrans.retryText.tr(context: context),
                        width: context.height < 600 ? null : context.width * .5,
                      ),
                    ],
                    SizedBox(
                      height: context.width < 720 ? 4.r : 15.r,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget buildPortrait(BuildContext context) {
    final child = SafeArea(
      child: Padding(
        padding: EdgeInsets.all(4.0.r),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: animationHeight,
                constraints: context.isLandscape
                    ? BoxConstraints(maxHeight: context.height * .4)
                    : null,
                child: Lottie.asset(
                  Assets.animations.noDataAnimation,
                ),
              ),
              SizedBox(
                height: 4.r,
              ),
              Padding(
                padding: EdgeInsets.all(4.0.r),
                child: CustomText(
                  error ?? AppTrans.emptyResponse.tr(context: context),
                  textAlign: TextAlign.center,
                  fontWeight: FontWeight.w400,
                  fontSize: context.width < 720 ? 16.sp : 20.sp,
                  color: errorColor,
                ),
              ),
              if (actionText != null && onActionClicked != null) ...[
                SizedBox(height: 32.h),
                CustomElevatedButton(
                  onPressed: onActionClicked,
                  icon: IconInfo.icon(Icons.add, size: 18.sp),
                  label: actionText,
                  width: context.height < 600 ? null : context.width * .5,
                ),
              ],
              if (onRetryClicked != null) ...[
                SizedBox(
                  height: context.width < 720 ? 4.r : 15.r,
                ),
                CustomElevatedButton(
                  backgroundColor: context.colors.primary,
                  onPressed: onRetryClicked,
                  label: AppTrans.retryText.tr(context: context),
                  width: context.height < 600 ? null : context.width * .5,
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.r,
                    vertical: 16.r,
                  ),
                ),
              ],
              SizedBox(
                height: context.width < 720 ? 4.r : 15.r,
              ),
            ],
          ),
        ),
      ),
    );
    return isScrollable
        ? OptimizedScrollView(
            child: child,
          )
        : child;
  }
}
