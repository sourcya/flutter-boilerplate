import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:playx/playx.dart';

import '../resources/assets.dart';
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
        Lottie.asset(AppAssets.noDataAnimation),
        Text(
          message ?? AppTrans.noDataMessage.tr,
          style: textStyle ??
              TextStyle(
                color: context.colorScheme.onBackground,
                fontSize: 18.sp,
              ),
        )
      ],
    );
  }
}
