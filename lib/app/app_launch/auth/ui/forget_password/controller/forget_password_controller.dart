part of '../imports/forget_password_imports.dart';

class ForgetPasswordController extends GetxController {
  final AuthRepository _authRepository;

  ForgetPasswordController({
    required AuthRepository authRepository,
  }) : _authRepository = authRepository;

  final isLoading = false.obs;

  final emailController = TextEditingController();
  final isEmailValid = false.obs;

  final isForgetPasswordFormValid = false.obs;

  Worker? validationWorker;

  @override
  void onInit() {
    super.onInit();
    _validationListener();
  }

  void resetEmail() {
    emailController.clear();
    isEmailValid.value = false;
    isForgetPasswordFormValid.value = false;
  }

  void _validationListener() {
    validationWorker = everAll(
      [
        isEmailValid,
      ],
      (callback) {
        isForgetPasswordFormValid.value = isEmailValid.value;
      },
    );
  }

  Future<void> submitForgetPassword() async {
    if (!isForgetPasswordFormValid.value) return;
    isLoading.value = true;

    FocusManager.instance.primaryFocus?.unfocus();
    final result = await _authRepository.forgetPassword(
      email: emailController.text,
    );

    result.when(
      success: (bool isSent) {
        isLoading.value = false;
        if (isSent) {
          AppNavigation.navigateFromForgetPasswordToPasswordOtp(
            email: emailController.text,
          );
        } else {
          Alert.error(message: AppTrans.unexpectedError.tr());
        }
      },
      error: (NetworkException exception) {
        isLoading.value = false;
        Alert.error(message: exception.message);
      },
    );
  }

  @override
  void onClose() {
    emailController.dispose();
    validationWorker?.dispose();
    validationWorker = null;
    super.onClose();
  }
}
