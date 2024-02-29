import 'package:playx/playx.dart';

class AppLocaleConfig extends XLocaleConfig {
  AppLocaleConfig()
      : super(
          path: 'assets/translations',
        );

  static const String arabicFontFamily = 'Cairo';
  static const String englishFontFamily = 'Poppins';

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

String get fontFamily => PlayxLocalization.isCurrentLocaleArabic()
    ? AppLocaleConfig.arabicFontFamily
    : AppLocaleConfig.englishFontFamily;

String fontFamilyBasedOnText(String text) {
  if (text.isEmpty) {
    return fontFamily;
  }
  return text.isArabic
      ? AppLocaleConfig.arabicFontFamily
      : AppLocaleConfig.englishFontFamily;
}
