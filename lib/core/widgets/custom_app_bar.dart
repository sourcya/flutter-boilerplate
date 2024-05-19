import 'package:flutter_boilerplate/core/resources/colors/app_colors.dart';
import 'package:flutter_boilerplate/core/widgets/components/custom_text.dart';
import 'package:playx/playx.dart';

PlatformAppBar buildAppBar({required String title}) {
  return PlatformAppBar(
    // toolbarHeight: dimens.appBarHeight,
    title: CustomText(
      title,
      fontSize: 16,
    ),
    material: (ctx, _) => MaterialAppBarData(
      centerTitle: true,
    ),
    cupertino: (ctx, __) => CupertinoNavigationBarData(
      // Issue with cupertino where a bar with no transparency
      // will push the list down. Adding some alpha value fixes it (in a hacky way)
      backgroundColor: ctx.colors.background.withAlpha(254),
    ),
  );
}
