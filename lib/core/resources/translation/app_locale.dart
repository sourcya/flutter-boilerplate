import 'package:get/get.dart';

import 'ar_translation.dart';
import 'english_translation.dart';

///This class is responsible for providing the translation for the app.
class AppLocale extends Translations {
  static const String arabicLanguage = "ar";
  static const String englishLanguage = "en";

  ArabicTranslations arabicTranslations = ArabicTranslations();
  EnglishTranslation englishTranslation = EnglishTranslation();

  @override
  Map<String, Map<String, String>> get keys => {
        arabicLanguage: arabicTranslations.translations,
        englishLanguage: englishTranslation.translations
      };
}
