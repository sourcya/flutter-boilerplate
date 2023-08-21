import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/core/resources/colors/app_color_scheme.dart';

import '../resources/dimens/dimens.dart';

AppBar buildAppBar({required String title}) {
  return AppBar(
    toolbarHeight: dimens.appBarHeight,
    title: Text(title, style: TextStyle(fontSize: dimens.appBarTextSize, color: colorScheme.onAppBar)),
    centerTitle: true,
  );
}
