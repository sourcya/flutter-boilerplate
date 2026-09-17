import 'package:flutter_boilerplate/core/models/models.dart';
import 'package:flutter_boilerplate/core/ui/ui.dart';

class AppModule {
  const AppModule({
    required this.type,
    required this.title,
    required this.subtitle,
    required this.icon,
  });

  final String type;
  final String title;
  final String subtitle;
  final IconInfo icon;
}

abstract final class AppModules {
  const AppModules._();

  static const String reports = 'reports';
  static const String analytics = 'analytics';

  static List<AppModule> get availableModules => [
        AppModule(
          type: reports,
          title: AppTrans.reportsModuleTitle,
          subtitle: AppTrans.reportsModuleSubtitle,
          icon: IconInfo.svg(Assets.icons.icTable),
        ),
        AppModule(
          type: analytics,
          title: AppTrans.analyticsModuleTitle,
          subtitle: AppTrans.analyticsModuleSubtitle,
          icon: IconInfo.svg(Assets.icons.icLayoutGrid),
        ),
      ];

  static List<AppModule> getInitialActiveAppModules() => availableModules;

  static AppModule? findByType(String type) {
    for (final module in availableModules) {
      if (module.type == type) return module;
    }
    return null;
  }
}
