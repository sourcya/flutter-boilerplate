import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/core/resources/colors/app_colors.dart';
import 'package:flutter_boilerplate/core/widgets/custom_app_bar.dart';
import 'package:go_router/go_router.dart';
import 'package:playx/playx.dart';

import '../../../app/app_launch/home/ui/imports/home_imports.dart';
import '../../../app/app_launch/home/ui/views/widgets/custom_navigation_drawer.dart';
import '../../resources/translation/app_translations.dart';

class CustomScaffold extends StatelessWidget {
  final StatefulNavigationShell navigationShell;
  final String? title;
  final EdgeInsetsGeometry? padding;
  final AppBar? appBar;
  final Widget? floatingActionButton;

  const CustomScaffold({
    required this.navigationShell,
    this.title,
    this.padding,
    this.appBar,
    this.floatingActionButton,
  });

  @override
  Widget build(BuildContext context) {
    final scaffoldChild = Container(
      padding: padding,
      alignment: Alignment.center,
      child: navigationShell,
    );

    return PlayxThemeSwitchingArea(
      child: PlatformScaffold(
        appBar: buildAppBar(title: title ?? AppTrans.appName),
        body: SafeArea(child: scaffoldChild),
        backgroundColor: context.colors.background,
        material: (context, platform) => MaterialScaffoldData(
          floatingActionButton: floatingActionButton,
          drawer: CustomNavigationDrawer(
            navigationShell: navigationShell,
          ),
          bottomNavBar: CustomNavigationBar(navigationShell: navigationShell),
        ),
      ),
    );
  }
}
