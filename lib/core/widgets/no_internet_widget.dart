import 'package:flutter/material.dart';
import 'package:playx/playx.dart';

import '../resources/assets/assets.dart';
import '../resources/colors/app_colors.dart';
import '../resources/translation/app_translations.dart';
import '../utils/app_utils.dart';
import 'components/custom_elevated_button.dart';
import 'components/custom_text.dart';
import 'orientation_widget.dart';

/// Widget for showing there's no internet connection.
class NoInternetWidget extends OrientationWidget {
  final String error;
  final VoidCallback? onRetryClicked;

  const NoInternetWidget({required this.error, this.onRetryClicked});

  @override
  Widget buildLandscape(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(4.0.r),
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
                      padding: EdgeInsets.all(4.0.r),
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
      padding: EdgeInsets.all(4.0.r),
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
                padding: EdgeInsets.all(4.0.r),
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
