import 'package:flutter/cupertino.dart';
import 'package:playx/playx.dart';

import '../resources/assets/assets.dart';
import '../resources/colors/app_colors.dart';
import '../resources/translation/app_translations.dart';

//Widget for showing that there is no data.
class NoDataAnimation extends StatelessWidget {
  final String? message;
  final TextStyle? textStyle;

  const NoDataAnimation({this.message, this.textStyle});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        Lottie.asset(Assets.animations.noDataAnimation),
        Text(
          message ?? AppTrans.noDataMessage.tr(context: context),
          style: textStyle ??
              TextStyle(
                color: context.colors.onSurface,
                fontSize: 18.sp,
              ),
        ),
      ],
    );
  }
}
