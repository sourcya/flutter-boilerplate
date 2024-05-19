import 'package:playx/playx.dart';

/// This class is responsible for saving key/value pairs in shared preferences.
class EnvManger {
  static final EnvManger instance = Get.find<EnvManger>();

  final String _googleMapsApiKey = 'google_maps_api_key';
  final String _sentryKey = 'sentry_key';
  final String _googleSignIosInClientId = 'google_sign_ios_in_client_id';
  final String _googleSignWebInClientId = 'google_sign_web_in_client_id';

  Future<String?> get googleSignInClientId async {
    if (GetPlatform.isIOS) {
      return googleSignIosInClientId;
    } else if (GetPlatform.isWeb) {
      return googleSignWebInClientId;
    }
    return null;
  }

  Future<String> get googleMapsKey => PlayxEnv.getString(_googleMapsApiKey);

  Future<String> get sentryKey => PlayxEnv.getString(_sentryKey);

  Future<String> get googleSignIosInClientId =>
      PlayxEnv.getString(_googleSignIosInClientId);

  Future<String> get googleSignWebInClientId =>
      PlayxEnv.getString(_googleSignWebInClientId);

  Future<String> get testWishlistEnv =>
      PlayxEnv.getString('test_wishlist_env_key',
          fallback: 'Wishlist Env Fallback');
}
