import 'package:flutter/services.dart';
import 'package:flutter_boilerplate/core/resources/translation/app_translations.dart';
import 'package:flutter_boilerplate/core/utils/models/result.dart';
import 'package:local_auth/error_codes.dart' as auth_error;
import 'package:local_auth/local_auth.dart';
import 'package:local_auth_android/local_auth_android.dart';
import 'package:local_auth_ios/local_auth_ios.dart';
import 'package:playx/playx.dart' hide Result;

class BiometricAuthRepository {
  static final BiometricAuthRepository _instance =
      BiometricAuthRepository._internal();

  factory BiometricAuthRepository() {
    return _instance;
  }

  BiometricAuthRepository._internal();

  final LocalAuthentication auth = LocalAuthentication();

  final androidAuthMessages = AndroidAuthMessages(
    signInTitle: AppTrans.bioSignInTitle.tr,
    cancelButton: AppTrans.bioCancelText.tr,
  );
  final iosAuthMessages = IOSAuthMessages(
    cancelButton: AppTrans.bioCancelText.tr,
  );

  Future<bool> canAuthenticate() async {
    try {
      final bool canAuthenticateWithBiometrics = await auth.canCheckBiometrics;
      final bool canAuthenticate =
          canAuthenticateWithBiometrics || await auth.isDeviceSupported();
      return canAuthenticate;
    } catch (_) {
      return false;
    }
  }

  Future<List<BiometricType>> getAvailableBiometrics() {
    return auth.getAvailableBiometrics();
  }

  Future<bool> isAuthenticationAvailable() async {
    try {
      final canAuthenticateWithBiometric = await canAuthenticate();
      final List<BiometricType> availableBiometrics =
          await getAvailableBiometrics();
      return canAuthenticateWithBiometric && availableBiometrics.isNotEmpty;
    } catch (_) {
      return false;
    }
  }

  void stopBiometricAuthentication() {
    auth.stopAuthentication();
  }

  Future<Result<bool>> authenticate({bool biometricOnly = false}) async {
    try {
      final canAuthenticateWithBiometric = await canAuthenticate();

      if (!canAuthenticateWithBiometric) {
        return Result.error(AppTrans.bioCanAuthenticate.tr);
      }

      // final List<BiometricType> availableBiometrics =
      //     await getAvailableBiometrics();
      // if (availableBiometrics.isEmpty) {
      //   return Result.error(AppTrans.bioNotAvailableError.tr);
      // }

      final bool didAuthenticate = await auth.authenticate(
        localizedReason: AppTrans.bioLocalizedReason.tr,
        options: AuthenticationOptions(
          biometricOnly: biometricOnly,
          stickyAuth: true,
        ),
        authMessages: <AuthMessages>[androidAuthMessages, iosAuthMessages],
      );
      return Result.success(didAuthenticate);
    } on PlatformException catch (e) {
      e.printError();
      switch (e.code) {
        case auth_error.passcodeNotSet:
          return Result.error(AppTrans.bioPasscodeNotSetError.tr);
        case auth_error.notAvailable:
          return Result.error(AppTrans.bioNotAvailableError.tr);
        case auth_error.notEnrolled:
          return Result.error(AppTrans.bioNotEnrolledError.tr);
        case auth_error.lockedOut:
        case auth_error.permanentlyLockedOut:
          return Result.error(AppTrans.bioLockedOutError.tr);
        default:
          return Result.error(AppTrans.bioDefaultError.tr);
      }
    }
  }
}
