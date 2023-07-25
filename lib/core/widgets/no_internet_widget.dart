import 'package:flutter/material.dart';
import 'package:playx/playx.dart';

import '../resources/assets.dart';
import '../resources/translation/app_translations.dart';

/// Widget for showing there's no internet connection.
class NoInternetAnimation extends StatelessWidget {
  final String? message;
  final TextStyle? textStyle;
  final TextStyle? retryTextStyle;
  final ButtonStyle? retryButtonStyle;
  final VoidCallback? onRetryClicked;

  const NoInternetAnimation(
      {this.message,
      this.textStyle,
      this.retryTextStyle,
      this.retryButtonStyle,
      required this.onRetryClicked,});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Lottie.asset(AppAssets.noInternetAnimation,
            height: context.height * .5,),
        Text(
          message ?? AppTrans.noInternetMessage.tr,
          style: textStyle ??
              TextStyle(
                color: context.colorScheme.onBackground,
                fontSize: 18.sp,
              ),
        ),
         SizedBox(
          height: 20.h,
        ),
        ElevatedButton(
          style: retryButtonStyle ?? const ButtonStyle(),
          onPressed: onRetryClicked,
          child: Text(
            AppTrans.retryText.tr,
            style: retryTextStyle ??
                TextStyle(
                  color: context.colorScheme.onPrimary,
                  fontSize: 14.sp,
                ),
          ),
        )
      ],
    );
  }
}
