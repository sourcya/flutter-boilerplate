import 'package:flutter/material.dart';
import 'package:playx/playx.dart';

class CustomScaffold extends StatelessWidget {
  final List<Widget> children;
  final MainAxisAlignment mainAxisAlignment;
  final EdgeInsetsGeometry? padding;
  final AppBar? appBar;
  final Widget? floatingActionButton;
  final MainAxisSize mainAxisSize;

  const CustomScaffold({
    required this.children,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.padding,
    this.appBar,
    this.floatingActionButton,
    this.mainAxisSize = MainAxisSize.max,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar,
      body: OptimizedScrollView(
        child: SafeArea(
          child: Container(
            padding: padding ??
                EdgeInsets.symmetric(
                  vertical: 8.h,
                  horizontal: 16.w,
                ),
            alignment: Alignment.center,
            child: Column(
              mainAxisSize: mainAxisSize,
              mainAxisAlignment: mainAxisAlignment,
              children: children,
            ),
          ),
        ),
      ),
      floatingActionButton: floatingActionButton,
    );
  }
}
