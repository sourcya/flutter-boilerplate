part of '../../ui.dart';

/// Widget for showing there's no internet connection.
class NoInternetWidget extends StatelessWidget {
  final String? error;
  final TextStyle? textStyle;
  final TextStyle? retryTextStyle;
  final ButtonStyle? retryButtonStyle;
  final VoidCallback? onRetryClicked;

  const NoInternetWidget({
    this.error,
    this.textStyle,
    this.retryTextStyle,
    this.retryButtonStyle,
    required this.onRetryClicked,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: Lottie.asset(
                Assets.animations.noInternetAnimation,
              ),
            ),
            SizedBox(
              height: 20.r,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomText(
                error ?? AppTrans.noInternetConnection,
                textAlign: TextAlign.center,
                fontWeight: FontWeight.w600,
                fontSize: 20.sp,
              ),
            ),
            if (onRetryClicked != null) ...[
              SizedBox(
                height: 15.r,
              ),
              CustomElevatedButton(
                backgroundColor: context.colors.primary,
                onPressed: onRetryClicked,
                label: AppTrans.retryText,
              ),
            ],
            SizedBox(
              height: 20.r + 56,
            ),
          ],
        ),
      ),
    );
  }
}
