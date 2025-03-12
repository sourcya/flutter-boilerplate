part of '../imports/verify_phone_view_imports.dart';

///Login controller to setup data to the ui.
class VerifyPhoneController extends GetxController {
  final AuthRepository authRepository;

  VerifyPhoneController({
    required this.authRepository,
  });

  final isLoading = false.obs;

  final isOtpValid = false.obs;
  final currentPin = ''.obs;

  final showScrollPadding = true.obs;

  Future<void> verifyOtp() async {
    showScrollPadding.value = false;
    WidgetsBinding.instance.focusManager.primaryFocus?.unfocus();
    if (!isOtpValid.value) return;
    isLoading.value = true;

    final result = await authRepository.verifyOtpCode(
      pin: currentPin.value,
    );

    result.when(
      success: (user) async {
        isLoading.value = false;
        AppNavigation.navigateFromVerifyOtpToHome();
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
