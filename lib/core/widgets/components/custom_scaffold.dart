import 'package:flutter/material.dart';
import 'package:playx/playx.dart';

import '../../../app/app_launch/home/ui/views/widgets/custom_navigation_drawer.dart';

class CustomScaffold extends StatelessWidget {
  final List<Widget>? children;
  final Widget? child;
  final bool hasScrollBody;
  final MainAxisAlignment mainAxisAlignment;
  final EdgeInsetsGeometry? padding;
  final PlatformAppBar? appBar;
  final Widget? floatingActionButton;
  final MainAxisSize mainAxisSize;

  const CustomScaffold({
    this.children ,
    this.child,
    this.hasScrollBody =false,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.padding,
    this.appBar,
    this.floatingActionButton,
    this.mainAxisSize = MainAxisSize.max,
  });

  @override
  Widget build(BuildContext context) {

    final scaffoldChild = Container(
      padding: padding ??
          EdgeInsets.symmetric(
            // vertical: 8.h,
            horizontal: 8.w,
          ),
      alignment: Alignment.center,
      child: child ?? Column(
        mainAxisSize: mainAxisSize,
        mainAxisAlignment: mainAxisAlignment,
        children: children??[],
      ),
    );

    return PlatformScaffold(
      appBar: appBar,
      body: SafeArea(
        child: hasScrollBody ? scaffoldChild :OptimizedScrollView(
          child: scaffoldChild,
        ),
      ),
      material: (ctx,_) => MaterialScaffoldData(
        drawer: CustomNavigationDrawer(),
        floatingActionButton: floatingActionButton,
      ),
    );
  }
}
