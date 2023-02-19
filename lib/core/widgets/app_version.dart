import 'package:flutter/cupertino.dart';
import 'package:package_info_plus/package_info_plus.dart';

// ignore: must_be_immutable
class AppVersion extends StatefulWidget {
  TextStyle textStyle;

  AppVersion({this.textStyle = const TextStyle()});

  @override
  State<StatefulWidget> createState() => _AppVersionState();
}

class _AppVersionState extends State<AppVersion> {
  String versionName = 'V';

  @override
  void initState() {
    super.initState();
    getVersionName();
  }

  Future<void> getVersionName() async {
    final PackageInfo packageInfo = await PackageInfo.fromPlatform();
    final String version = packageInfo.version;
    setState(() {
      versionName = "V$version";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      versionName,
      style: widget.textStyle,
      textAlign: TextAlign.center,
    );
  }
}
