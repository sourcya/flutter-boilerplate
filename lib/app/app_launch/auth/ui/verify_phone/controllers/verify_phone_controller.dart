part of '../imports/verify_phone_view_imports.dart';

///Login controller to setup data to the ui.
class VerifyPhoneController extends GetxController {
  final _authRepository = AuthRepository();

  final isLoading = false.obs;

  final isOtpValid = false.obs;
  final currentPin = ''.obs;

  final showScrollPadding = true.obs;

  Future<void> verifyOtp() async {
    showScrollPadding.value = false;
    WidgetsBinding.instance.focusManager.primaryFocus?.unfocus();
    if (!isOtpValid.value) return;
    isLoading.value = true;

    final result = await _authRepository.verifyOtpCode(
      pin: currentPin.value,
    );

    result.when(
      success: (ApiUser user) async {
        isLoading.value = false;
        AppNavigation.navigateFromVerifyOtpToDashboard();
      },
      error: (NetworkException exception) {
        isLoading.value = false;
        Alert.error(message: exception.message);
      },
    );
  }

  void handleOtpPinChanged(String value) {
    showScrollPadding.value = true;

    currentPin.value = value;
    isOtpValid.value = isOtpCodeValidNumber(value);
  }

  bool isOtpCodeValidNumber(String value) {
    final number = num.tryParse(value);
    if (number == null) {
      return false;
    }
    if (number > 1000) {
      return true;
    }
    return false;
  }

  void resendCode() {}
}
