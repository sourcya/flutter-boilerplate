import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/core/config/theme.dart';
import 'package:flutter_boilerplate/core/resources/assets.dart';
import 'package:lottie/lottie.dart';
import 'package:playx/playx.dart';

import '../resources/translation/app_translations.dart';

// ignore: must_be_immutable
class NoInternetAnimation extends StatelessWidget {
  String? message;
  TextStyle? textStyle;
  TextStyle? retryTextStyle;
  ButtonStyle? retryButtonStyle;
  VoidCallback onRetryClicked;

  NoInternetAnimation(
      {this.message,
      this.textStyle,
      this.retryTextStyle,
      this.retryButtonStyle,
      required this.onRetryClicked});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Lottie.asset(AppAssets.noInternetAnimation,
            height: context.height * .5),
        Text(
          message ?? AppTrans.noInternetMessage.tr,
          style: textStyle ??
              TextStyle(
                color: AppThemeConfig.getColorScheme(context).onBackground,
                fontSize: 18,
              ),
        ),
        const SizedBox(
          height: 20,
        ),
        ElevatedButton(
          style: retryButtonStyle ?? const ButtonStyle(),
          onPressed: onRetryClicked,
          child: Text(
            AppTrans.retryText.tr,
            style: retryTextStyle ??
                TextStyle(
                  color: AppThemeConfig.getColorScheme(context).onPrimary,
                  fontSize: 14,
                ),
          ),
        )
      ],
    );
  }
}
