import 'package:playx/playx.dart';

abstract class Constants {
  Constants._();

  static const String? appleId = null;
  static const String playStoreId = 'io.sourcya.app';

  static const String playStoreUrl =
      'https://play.google.com/store/apps/details?id=io.sourcya.app';
  static const String iosStoreUrl = '';

  static String storeUrl = PlayxPlatform.isAndroid
      ? playStoreUrl
      : PlayxPlatform.isIOS
      ? iosStoreUrl
      : '';

  static const String storeCountry = 'sa';
  static String storeLanguage = PlayxLocalization.currentLocale.languageCode;

  static const String webUrl = 'https://sourcya.io';
  static const String telephoneNumber = '+966 11 000 0000';
  static const String phoneNumber = '+966 50 000 0000';
  static const String contactWhatsappNumber = '+966 50 000 0000';
  static const String whatsappNumber = '966500000000';
}
