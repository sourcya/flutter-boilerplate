import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/core/resources/colors/app_color_scheme.dart';
import 'package:playx/playx.dart';

import '../resources/dimens/dimens.dart';

class CustomLoading extends StatelessWidget {
  final EdgeInsetsGeometry margin;
  const CustomLoading({
    this.margin = const EdgeInsets.only( bottom:  Dimens.bottomNavBarHeight),
});

  @override
  Widget build(BuildContext context) {
    return  CenterLoading(color: colorScheme.onPrimary,);
    // return  Center(
    //   child: Container(
    //       height: context.height *.3,
    //     margin:margin ,
    //     // child:Lottie.asset(Assets.animations.loadingAnimation),
    //   ),
    // );
  }

}
