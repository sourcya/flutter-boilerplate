import 'package:flutter/cupertino.dart';
import 'package:flutter_boilerplate/core/config/theme.dart';
import 'package:flutter_boilerplate/core/resources/assets.dart';
import 'package:lottie/lottie.dart';
import 'package:playx/playx.dart';

import '../resources/translation/app_translations.dart';

class NoDataAnimation extends StatelessWidget {
  String? message;
  TextStyle? textStyle;

  NoDataAnimation({this.message, this.textStyle});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Lottie.asset(AppAssets.noDataAnimation),
        Text(
          message ?? AppTrans.noDataMessage.tr,
          style: textStyle ??
              TextStyle(
                color: AppThemeConfig.getColorScheme(context).onBackground,
                fontSize: 18,
              ),
        )
      ],
    );
  }
}
