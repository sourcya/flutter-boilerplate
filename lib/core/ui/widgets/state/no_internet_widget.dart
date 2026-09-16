part of '../../ui.dart';

/// Widget for showing there's no internet connection.
class NoInternetWidget extends OrientationWidget {
  final String error;
  final VoidCallback? onRetryClicked;

  const NoInternetWidget({required this.error, this.onRetryClicked});

  @override
  Widget buildLandscape(BuildContext context) {
    return Padding(
      padding: context.paddingAll(4.0),
      child: Center(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: Lottie.asset(
                Assets.animations.noInternetAnimation,
              ),
            ),
            SizedBox(
              height: 6.r,
            ),
            Expanded(
              child: OptimizedScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: context.paddingAll(4.0),
                      child: CustomText(
                        error,
                        textAlign: TextAlign.center,
                        fontWeight: FontWeight.w400,
                        fontSize: AppUtils.isMobile() ? 16.sp : 20.sp,
                      ),
                    ),
                    if (onRetryClicked != null) ...[
                      SizedBox(
                        height: AppUtils.isMobile() ? 8.r : 15.r,
                      ),
                      CustomElevatedButton(
                        color: context.colors.primary,
                        onPressed: onRetryClicked,
                        label: AppTrans.retryText.tr(context: context),
                      ),
                    ],
                    SizedBox(
                      height: AppUtils.isMobile() ? 4.r : 15.r,
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
    return Padding(
      padding: context.paddingAll(4.0),
      child: OptimizedScrollView(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                child: Lottie.asset(
                  Assets.animations.noInternetAnimation,
                ),
              ),
              SizedBox(
                height: 6.r,
              ),
              Padding(
                padding: context.paddingAll(4.0),
                child: CustomText(
                  error,
                  textAlign: TextAlign.center,
                  fontWeight: FontWeight.w400,
                  fontSize: AppUtils.isMobile() ? 16.sp : 20.sp,
                ),
              ),
              if (onRetryClicked != null) ...[
                SizedBox(
                  height: AppUtils.isMobile() ? 8.r : 15.r,
                ),
                CustomElevatedButton(
                  color: context.colors.primary,
                  onPressed: onRetryClicked,
                  label: AppTrans.retryText.tr(context: context),
                ),
              ],
              SizedBox(
                height: AppUtils.isMobile() ? 4.r : 15.r,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
