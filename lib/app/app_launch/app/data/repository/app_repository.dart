import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/app/app_launch/app/data/datasource/app_datasource.dart';
import 'package:flutter_boilerplate/app/app_launch/app/data/model/custom_navigation_destination_item.dart';
import 'package:flutter_boilerplate/core/models/models.dart';
import 'package:flutter_boilerplate/core/ui/ui.dart';
import 'package:playx/playx.dart';

class AppRepository {
  final AppDatasource _dataSource;
  AppRepository({
    required AppDatasource dataSource,
  }) : _dataSource = dataSource;

  static AppRepository get instance => getIt.get<AppRepository>();

  List<CustomNavigationDestinationItem> get mainDrawerItems => [
    CustomNavigationDestinationItem(
      icon: IconInfo.svg(Assets.icons.dashboard),
      label: AppTrans.dashboard,
      navigationIndex: 0,
    ),
    CustomNavigationDestinationItem(
      icon: IconInfo.icon(Icons.favorite_border),
      label: AppTrans.wishlist,
      navigationIndex: 1,
    ),
    CustomNavigationDestinationItem(
      icon: IconInfo.svg(Assets.icons.settings),
      label: AppTrans.settings,
      navigationIndex: 2,
    ),
  ];

  List<CustomNavigationDestinationItem> get otherDrawerItems => [
    CustomNavigationDestinationItem(
      icon: IconInfo.icon(FontAwesomeIcons.whatsapp),
      label: AppTrans.support,
    ),
    CustomNavigationDestinationItem(
      icon: IconInfo.icon(Icons.logout),
      label: AppTrans.logout,
    ),
  ];

  // List<CustomNavigationDestinationItem> get popupDrawerItems => [
  //   CustomNavigationDestinationItem(
  //     icon: IconInfo.svg(Asset.icons.badgeCheck),
  //     label: AppTrans.myAccount,
  //     navigationIndex: 12,
  //     route: Routes.profile,
  //   ),
  //   CustomNavigationDestinationItem(
  //     icon: IconInfo.icon(Icons.settings),
  //     label: AppTrans.settings,
  //     navigationIndex: 13,
  //     route: Routes.settings,
  //   ),
  //   CustomNavigationDestinationItem(
  //     icon: IconInfo.svg(SettingsTab.activeModules.icon),
  //     label: AppTrans.activeModulesTitle,
  //     navigationIndex: 13,
  //     route: Routes.moduleSettings,
  //   ),
  // ];
}
