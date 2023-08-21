
part of '../imports/login_imports.dart';



///Login controller to setup data to the ui.
class LoginController extends GetxController {
  final authRepository = AuthRepository();
  final biometricAuthRepo = BiometricAuthRepository();
  final googleAuthRepo = GoogleAuthRepository();

  final AppNavigation appNavigation = AppNavigation.instance;
  final isLoading = false.obs;
  final hidePassword = true.obs;

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final isEmailValid = false.obs;
  final isPasswordValid = false.obs;

  final isFormValid = false.obs;
  Worker? _validationWorker;


  @override
  void onInit() {
    if (kDebugMode) {
      emailController.text = 'bbbb@mail.com';
      passwordController.text = '123456';
      isEmailValid.value = true;
      isPasswordValid.value = true;
      isFormValid.value = true;
    }
    super.onInit();
    listenToValidationState();
  }

  void listenToValidationState() {
    _validationWorker=  everAll([
      isEmailValid,
      isPasswordValid,
    ], (callback) {
      final isValid = isEmailValid.value && isPasswordValid.value;
      isFormValid.value = isValid;
    });
  }

  Future<void> login() async {
    if (!isFormValid()) return;
    isLoading.value = true;
    appNavigation.navigateFromLoginToHome();
    final result = await authRepository.login(
      email: emailController.text,
      password: passwordController.text,
    );
    result.when(
      success: (ApiUser user) async {
        isLoading.value = false;
        authenticateWithBiometric();
      },
      error: (NetworkException exception) {
        isLoading.value = false;
        Alert.error(message: exception.message);
      },
    );
  }

  Future<void> authenticateWithBiometric() async {
    final isBiometricAvailable = await biometricAuthRepo.canAuthenticate();
    if (Keys.shouldUseBiometricAuth && isBiometricAvailable) {
      final bioAuthResult = await biometricAuthRepo.authenticate();

      bioAuthResult.when(
        success: (isAuthenticated) {
          if (isAuthenticated) {
            appNavigation.navigateFromLoginToHome();
          } else {
            Alert.message(message: "couldn't authenticate");
          }
        },
        error: (message) {
          Alert.error(message: message);
        },
      );
    } else {
      appNavigation.navigateFromLoginToHome();
    }
  }

  Future<void> loginWithGoogle() async {
    final res = await googleAuthRepo.signIn();
    res.when(
      success: (user) {
        appNavigation.navigateFromLoginToHome();
        Alert.success(
            message: 'Logged in successfully using Google with ${user.email}',);
      },
      error: (message) {
        Alert.error(message: message);
      },
    );
  }

  void navigateToRegister() {
    appNavigation.navigateFromLoginToRegister();
  }

  @override
  void onClose() {
    super.onClose();
    emailController.dispose();
    passwordController.dispose();
    _validationWorker?.dispose();

  }
}
