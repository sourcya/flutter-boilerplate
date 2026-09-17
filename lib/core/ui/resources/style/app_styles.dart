part of '../../ui.dart';

/// Typography access used by Madaan-style widgets via [BuildContext.styles].
class AppStyles {
  const AppStyles(this.context);

  final BuildContext context;

  TextStyle get bodyMedium => context.bodyMediumTS;

  TextStyle get textXs => context.bodySmallTS.copyWith(fontSize: 12.sp, height: 1.33);

  TextStyle get textXsSemibold => textXs.copyWith(fontWeight: FontWeight.w600);
}

extension AppStylesExtension on BuildContext {
  AppStyles get styles => AppStyles(this);
}
