import 'package:flutter/cupertino.dart';

class OnBoarding {
  final String title;
  final String? subtitle;
  final String lottieAsset;

  final Widget Function(BuildContext context)? customWidgetBuilder;

  const OnBoarding({
    required this.title,
    required this.subtitle,
    required this.lottieAsset,
    this.customWidgetBuilder,
  });
}
