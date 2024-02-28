part of '../imports/login_view_imports.dart';

///Login controller to setup data to the ui.
class OtpLoginController extends GetxController {
  final authRepository = AuthRepository();

  final isLoading = false.obs;
  final phoneController = TextEditingController();

  final isPhoneNumberValid = false.obs;

  @override
  void onInit() {
    if (kDebugMode) {
      // phoneController.text = '1121221';
      // isPhoneNumberValid.value = true;
      // isFormValid.value = true;
    }
    super.onInit();
  }

  Future<void> login() async {
    if (!isPhoneNumberValid.value) return;
    WidgetsBinding.instance.focusManager.primaryFocus?.unfocus();
    isLoading.value = true;
    final result = await authRepository.otpLogin(
      phoneNumber: phoneController.text,
    );
    result.when(
      success: (ApiUser user) async {
        isLoading.value = false;
        AppNavigation.navigateFromLoginToVerifyPhone();
      },
      error: (NetworkException exception) {
        isLoading.value = false;
        Alert.error(message: exception.message);
      },
    );
  }

  void navigateToRegister() {
    AppNavigation.navigateFromLoginToRegister();
  }

  @override
  void onClose() {
    phoneController.dispose();
  }
}
