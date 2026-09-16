part of '../imports/change_password_imports.dart';

class ChangePasswordController extends GetxController {
  final AuthRepository _authRepository;
  final MyPreferenceManger _preferenceManger;

  ChangePasswordController({
    AuthRepository? authRepository,
    MyPreferenceManger? preferenceManger,
  })  : _authRepository = authRepository ?? AuthRepository.instance,
        _preferenceManger = preferenceManger ?? MyPreferenceManger.instance;

  final isLoading = false.obs;

  final hideOldPassword = true.obs;
  final hidePassword = true.obs;
  final hideConfirmPassword = true.obs;

  final oldPasswordController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  final isOldPasswordValid = false.obs;
  final isPasswordValid = false.obs;
  final isConfirmPasswordValid = false.obs;

  final isFormValid = false.obs;

  final confirmPasswordFormKey = GlobalKey<FormState>();
  final newPasswordFormKey = GlobalKey<FormState>();

  Worker? validationWorker;

  @override
  void onInit() {
    super.onInit();
    observeValidationChanges();
  }

  void observeValidationChanges() {
    validationWorker = everAll(
      [
        isOldPasswordValid,
        isConfirmPasswordValid,
        isPasswordValid,
      ],
      (_) {
        isFormValid.value = isConfirmPasswordValid.value &&
            isPasswordValid.value &&
            isOldPasswordValid.value;
      },
    );
  }

  Future<void> resetPassword() async {
    if (!isFormValid.value) return;
    isLoading.value = true;
    FocusManager.instance.primaryFocus?.unfocus();

    final result = await _authRepository.changePassword(
      password: passwordController.text,
      oldPassword: oldPasswordController.text,
    );

    result.when(
      success: (user) async {
        final shouldRememberUser = await _preferenceManger.shouldRememberUser;
        if (shouldRememberUser) {
          final usernameOrEmail = user.info.email;
          if (usernameOrEmail != null && usernameOrEmail.isNotEmpty) {
            await _preferenceManger.saveUserCredentials(
              username: usernameOrEmail,
              password: passwordController.text,
            );
          }
        }
        isLoading.value = false;
        Alert.success(message: AppTrans.changePasswordSuccessMessage.tr());
        PlayxNavigation.pop();
      },
      error: (NetworkException exception) {
        isLoading.value = false;
        Alert.error(message: exception.message);
      },
    );
  }

  @override
  void onClose() {
    oldPasswordController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    validationWorker?.dispose();
    validationWorker = null;
    super.onClose();
  }

  void handleForgetPassword() {
    PlayxNavigation.pop();
    AppNavigation.navigateFromLoginToForgetPassword();
  }
}
