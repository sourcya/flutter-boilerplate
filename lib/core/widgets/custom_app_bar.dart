import 'package:flutter/material.dart';

import '../resources/dimens/dimens.dart';

AppBar buildAppBar({required String title}) {
  return AppBar(
    toolbarHeight: dimens.appBarHeight,
    title: Text(title, style: TextStyle(fontSize: dimens.appBarTextSize)),
    centerTitle: true,

  );
}
