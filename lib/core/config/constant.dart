import 'dart:io';

import 'package:playx/playx.dart';

/// contains global keys
abstract class Constants {
  Constants._();

  static const String? googleSignInServerId = null;

  //APP UPDATES
  static const String? appleId = null;
  static const String playStoreId = 'io.sourcya.tmt.track';

  static const String playStoreUrl =
      'https://play.google.com/store/apps/details?id=io.sourcya.tmt.track';
  static const String iosStoreUrl = '';

  static String storeUrl = Platform.isAndroid
      ? playStoreUrl
      : Platform.isIOS
          ? iosStoreUrl
          : '';

  static const String storeCountry = 'sa';
  static String storeLanguage = PlayxLocalization.currentLocale.languageCode;

  static const bool shouldUseGoogleSignIn = true;

  static const bool shouldUseBiometricAuth = true;

  static String auth0ClientId = '';
  static String auth0Domain = 'sourcya.eu.auth0.com';
}
