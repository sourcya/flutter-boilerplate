part of '../imports/login_imports.dart';

///Login controller to setup data to the ui.
class LoginController extends GetxController {

  final AuthRepository authRepository;

  LoginController({
    required this.authRepository,
  });


  final hidePassword = true.obs;

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final isEmailValid = false.obs;
  final isPasswordValid = false.obs;

  final isFormValid = false.obs;
  Worker? _validationWorker;

  final Rxn<LoginMethod> currentLoginMethod = Rxn();
  final loginMethods = <LoginMethod>[
    LoginMethod.email,
    LoginMethod.google,
    LoginMethod.apple,
  ];

  @override
  void onInit() {
    if (kDebugMode) {
      // emailController.text = 'bbbb@mail.com';
      // passwordController.text = '123456';
      // isEmailValid.value = true;
      // isPasswordValid.value = true;
      // isFormValid.value = true;
    }
    super.onInit();
    listenToValidationState();
  }

  void listenToValidationState() {
    _validationWorker = everAll([
      isEmailValid,
      isPasswordValid,
    ], (callback) {
      final isValid = isEmailValid.value && isPasswordValid.value;
      isFormValid.value = isValid;
    });
  }

  Future<void> loginBy({required LoginMethod method}) async {
    currentLoginMethod.value = method;
    if (method == LoginMethod.email) {
      currentLoginMethod.value = LoginMethod.email;
    } else {
      AppController.instance.loadingStatus.value = LoadingStatus.login;

      currentLoginMethod.value = null;
      final result = await authRepository.loginViaAuth0(method: method);
      result.when(
        success: (User user) async {
          _navigateToHome();
        },
        error: (NetworkException exception) {
          Alert.error(message: exception.message);
        },
      );
    }
  }

  Future<void> login() async {
    if (!isFormValid()) return;
    FocusManager.instance.primaryFocus?.unfocus();
    AppController.instance.loadingStatus.value = LoadingStatus.login;
    final result = await authRepository.loginViaEmailAndPassword(
      email: emailController.text,
      password: passwordController.text,
    );
    result.when(
      success: (User user) async {
        // if (saveLoginInfo.value) {
        //   await authRepository.saveLoginInfo(
        //     email: emailController.text,
        //     password: passwordController.text,
        //   );
        // }
        await _navigateToHome();
      },
      error: (NetworkException exception) {
        AppController.instance.loadingStatus.value = LoadingStatus.none;
        Alert.error(message: exception.message);
      },
    );
  }

  Future<void> _navigateToHome() async {
    AppController.instance.loadingStatus.value = LoadingStatus.none;
    AppNavigation.navigateFromLoginToHome();
  }

  void navigateToRegister() {
    AppNavigation.navigateFromLoginToRegister();
  }

  @override
  void onClose() {
    super.onClose();
    emailController.dispose();
    passwordController.dispose();
    _validationWorker?.dispose();
  }
}
