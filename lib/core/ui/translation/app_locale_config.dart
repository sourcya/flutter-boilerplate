part of '../ui.dart';

class AppLocaleConfig {
  const AppLocaleConfig._();

  static const String arabicFontFamily = 'Cairo';
  static const String englishFontFamily = 'Poppins';

  static const arabicLocale = XLocale(
    id: 'ar',
    name: 'العربية',
    languageCode: 'ar',
    fontFamily: arabicFontFamily,
  );
  static const englishLocale = XLocale(
    id: 'en',
    name: 'English',
    languageCode: 'en',
    fontFamily: englishFontFamily,
  );

  static PlayxLocaleConfig createLocaleConfig() => PlayxLocaleConfig(
        supportedLocales: [
          englishLocale,
          arabicLocale,
        ],
        fallbackLocale: englishLocale,
      );
}

String get currentLanguageCode =>
    PlayxLocalization.currentLocale.toStringWithSeparator();

String fontFamily({BuildContext? context}) {
  try {
    final locale = context?.locale ?? PlayxLocalization.currentLocale;
    return locale.isArabic
        ? AppLocaleConfig.arabicFontFamily
        : AppLocaleConfig.englishFontFamily;
  }
  // ignore: avoid_catches_without_on_clauses
  catch (e) {
    return AppLocaleConfig.englishFontFamily;
  }
}

String fontFamilyBasedOnText(String? text, {bool isTranslatable = true}) =>
    (isTranslatable ? text?.tr() : text)?.isArabic == true
        ? AppLocaleConfig.arabicFontFamily
        : AppLocaleConfig.englishFontFamily;
