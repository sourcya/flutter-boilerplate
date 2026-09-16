part of '../imports/reset_password_imports.dart';

class ResetPasswordController extends GetxController {
  String token;
  String? recoveryEmail;
  final AuthRepository _authRepository;

  ResetPasswordController({
    required this.token,
    this.recoveryEmail,
    AuthRepository? authRepository,
  }) : _authRepository = authRepository ?? AuthRepository.instance;

  final MyPreferenceManger _preferenceManger = MyPreferenceManger.instance;

  final isLoading = false.obs;
  final hidePassword = true.obs;
  final hideConfirmPassword = true.obs;

  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  final isPasswordValid = false.obs;
  final isConfirmPasswordValid = false.obs;

  final isFormValid = false.obs;

  final confirmPasswordFormKey = GlobalKey<FormState>();
  final newPasswordFormKey = GlobalKey<FormState>();
  Worker? validationWorker;

  @override
  void onInit() {
    super.onInit();
    listenToValidationState();
  }

  void listenToValidationState() {
    validationWorker = everAll(
      [
        isConfirmPasswordValid,
        isPasswordValid,
      ],
      (callback) {
        final isValid = isConfirmPasswordValid.value && isPasswordValid.value;
        isFormValid.value = isValid;
      },
    );
  }

  Future<void> resetPassword() async {
    if (!isFormValid.value) return;
    isLoading.value = true;

    FocusManager.instance.primaryFocus?.unfocus();

    final result = await _authRepository.resetPassword(
      password: passwordController.text,
      token: token,
    );

    result.when(
      success: (bool isSuccess) async {
        final shouldRememberUser = await _preferenceManger.shouldRememberUser;
        if (shouldRememberUser) {
          final trimmedRecovery = recoveryEmail?.trim();
          final savedSession = await _preferenceManger.getSavedUser();
          final rememberedUsername = await _preferenceManger.getSavedUsername();
          final usernameOrEmail = (trimmedRecovery != null && trimmedRecovery.isNotEmpty)
              ? trimmedRecovery
              : savedSession?.email ?? savedSession?.username ?? rememberedUsername;

          if (usernameOrEmail != null && usernameOrEmail.isNotEmpty) {
            await _preferenceManger.saveUserCredentials(
              username: usernameOrEmail,
              password: passwordController.text,
            );
          }
        }
        isLoading.value = false;
        Alert.success(message: AppTrans.resetPasswordSuccessMessage);
        await _preferenceManger.signOut();
        AppNavigation.navigateFromResetPasswordToLogin();
      },
      error: (NetworkException exception) {
        isLoading.value = false;
        Alert.error(message: exception.message);
      },
    );
  }

  void updateRouteArgs({required String token, String? recoveryEmail}) {
    this.token = token;
    this.recoveryEmail = recoveryEmail;
  }

  @override
  void onClose() {
    passwordController.dispose();
    confirmPasswordController.dispose();
    validationWorker?.dispose();
    validationWorker = null;
    super.onClose();
  }
}
