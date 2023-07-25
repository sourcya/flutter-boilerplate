
import 'package:playx/playx.dart';

class AppLocaleConfig extends XLocaleConfig{

  AppLocaleConfig() : super(path: 'assets/translations',);

  @override
  List<XLocale> get supportedLocales => [
    const XLocale(id: 'en', name: 'English', languageCode: 'en'),
    const XLocale(id: 'ar', name: 'العربية', languageCode: 'ar'),
  ];

  @override
  XLocale? get startLocale => supportedLocales[0];

  @override
  XLocale? get fallbackLocale => supportedLocales[0];

}
