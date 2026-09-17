part of '../../network.dart';

/// contains network endpoints.
abstract class Endpoints {
  static const baseUrl = "https://sourcya-connect.herokuapp.com";

  static const login = '/auth/local';
  static const register = '/auth/local/register';
  static const upload = '/upload';

  static const profile = '/users/me';
  static const updateUser = '/users/edit-profile';

  static const forgetPassword = '/auth/forgot-password';
  static const verifyForgetPasswordOtpCode = '/auth/verify-otp';
  static const resetPassword = '/auth/reset-password';
  static const changePassword = '/auth/change-password';

  /// Extension point: example public API used by the Products demo feature.
  /// This is a separate third-party base URL, never the app's [baseUrl].
  static const productsBaseUrl = 'https://dummyjson.com';
  static const products = '/products';
}
