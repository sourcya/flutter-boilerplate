import 'package:playx/playx.dart';

const String _arabicFontFamily = 'Cairo';
const String _englishFontFamily = 'Poppins';

const _supportedLocales = [
  XLocale(id: 'en', name: 'English', languageCode: 'en'),
  XLocale(id: 'ar', name: 'العربية', languageCode: 'ar'),
];
PlayxLocaleConfig createLocaleConfig() => PlayxLocaleConfig(
      supportedLocales: _supportedLocales,
      fallbackLocale: _supportedLocales[0],
    );

String get fontFamily => PlayxLocalization.isCurrentLocaleArabic()
    ? _arabicFontFamily
    : _englishFontFamily;

String fontFamilyBasedOnText(String text) {
  if (text.isEmpty) {
    return fontFamily;
  }
  return text.isArabic ? _arabicFontFamily : _englishFontFamily;
}
