import 'package:flutter/material.dart';
import 'package:playx/playx.dart';

AppBar buildAppBar({required String title}) {
  return AppBar(
    toolbarHeight: 56.h,
    title: Text(title, style: TextStyle(fontSize: 14.sp)),
    centerTitle: true,
  );
}
