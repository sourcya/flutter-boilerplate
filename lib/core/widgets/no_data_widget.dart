import 'package:flutter/cupertino.dart';
import 'package:flutter_boilerplate/core/resources/assets/assets.dart';
import 'package:flutter_boilerplate/core/resources/colors/app_colors.dart';
import 'package:flutter_boilerplate/core/resources/translation/app_translations.dart';
import 'package:playx/playx.dart';

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
