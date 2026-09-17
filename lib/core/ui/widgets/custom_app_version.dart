part of '../ui.dart';

/// Widget to display current App Version.
class CustomAppVersion extends StatelessWidget {
  /// Version text style.
  final TextStyle? textStyle;

  /// text to be added before app version.
  final String prefix;

  /// text to be added after app version.
  final String postfix;

  final bool showVersionCode;

  final bool showStroke;
  final double? fontSize;
  final Color? color;

  const CustomAppVersion({
    super.key,
    this.textStyle,
    this.prefix = 'v',
    this.postfix = '',
    this.showVersionCode = false,
    this.showStroke = true,
    this.fontSize,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getVersionName(),
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        final versionName = snapshot.data ?? '';
        return _AppVersionText(
          versionName: versionName,
          textStyle: textStyle,
          isStroke: showStroke,
          fontSize: fontSize,
          color: color,
        );
      },
    );
  }

  Future<String> getVersionName() async {
    final PackageInfo packageInfo = await PackageInfo.fromPlatform();
    final String version = showVersionCode
        ? '${packageInfo.version}+${packageInfo.buildNumber}'
        : packageInfo.version;
    return "$prefix$version$postfix";
  }
}

class _AppVersionText extends StatelessWidget {
  const _AppVersionText({
    required this.versionName,
    this.textStyle,
    required this.isStroke,
    this.fontSize,
    this.color,
  });

  final String versionName;
  final TextStyle? textStyle;
  final bool isStroke;
  final double? fontSize;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return isStroke
        ? CustomText.stroke(
            versionName,
            isTranslatable: false,
            textStyle: textStyle,
            fontSize: fontSize ?? 12.sp,
            textAlign: TextAlign.center,
            color: color ?? context.colors.onDoneColor,
            strokeColor: context.colors.onSurface,
          )
        : CustomText(
            versionName,
            isTranslatable: false,
            textStyle: textStyle,
            fontSize: fontSize ?? 12.sp,
            textAlign: TextAlign.center,
            decoration: TextDecoration.none,
            color: color ?? textStyle?.color ?? context.colors.onSurface,
          );
  }
}
