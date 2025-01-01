import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/core/resources/assets/assets.dart';
import 'package:flutter_boilerplate/core/resources/colors/app_colors.dart';
import 'package:flutter_boilerplate/core/resources/translation/app_translations.dart';
import 'package:flutter_boilerplate/core/utils/app_utils.dart';
import 'package:flutter_boilerplate/core/widgets/components/custom_elevated_button.dart';
import 'package:flutter_boilerplate/core/widgets/components/custom_text.dart';
import 'package:flutter_boilerplate/core/widgets/orientation_widget.dart';
import 'package:playx/playx.dart';

class ErrorDataWidget extends OrientationWidget {
  final VoidCallback? onRetryClicked;
  final String error;

  const ErrorDataWidget({
    super.key,
    this.onRetryClicked,
    required this.error,
  });

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
                Assets.animations.error,
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
              Lottie.asset(
                Assets.animations.error,
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
