import 'package:flutter/cupertino.dart';
import 'package:package_info_plus/package_info_plus.dart';

/// Widget to display current App Version
// ignore: must_be_immutable
class AppVersion extends StatelessWidget {
  TextStyle textStyle;

  AppVersion({this.textStyle = const TextStyle()});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getVersionName(),
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        final versionName = snapshot.data ?? '';
        return Text(
          versionName,
          style: textStyle,
          textAlign: TextAlign.center,
        );
      },
    );
  }

  Future<String> getVersionName() async {
    final PackageInfo packageInfo = await PackageInfo.fromPlatform();
    final String version = packageInfo.version;
    return "V$version";
  }
}
