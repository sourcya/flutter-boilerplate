import 'package:get/get_utils/src/platform/platform.dart';

/// contains global keys
abstract class Keys {
  Keys();

  static const googleMapsApiKey = '';

  static const sentryKey = '';

  static const String googleSignIosInClientId =
      '743602006598-9theilas4ei4k02reesl8b01vksol5fu.apps.googleusercontent.com';
  static const String googleSignWebInClientId =
      '743602006598-5hjqlo332apgcf6pien9mgnv3bg860s6.apps.googleusercontent.com';

  static const String? googleSignInServerId = null;

  static String? get googleSignInClientId {
    if (GetPlatform.isIOS) {
      return googleSignIosInClientId;
    } else if (GetPlatform.isWeb) {
      return googleSignWebInClientId;
    }
    return null;
  }
}
