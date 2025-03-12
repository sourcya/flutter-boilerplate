part of '../imports/register_imports.dart';

class RegisterController extends GetxController {
  final AuthRepository authRepository;

  RegisterController({
    required this.authRepository,
  });

  final hidePassword = true.obs;
  final hideConfirmPassword = true.obs;
  final agreeToTerms = false.obs;

  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  /// This needed for text field that has complex ui like hide password button
  /// As using [TextInputAction.next] to move keyboard to next field won't work
  /// as the button will take focus so we need to manually add text field current and next focus node
  final firstNameFocus = FocusNode();
  final lastNameFocus = FocusNode();
  final emailFocus = FocusNode();
  final passwordFocus = FocusNode();
  final confirmPasswordFocus = FocusNode();

  final confirmPasswordFormKey = GlobalKey<FormState>();

  final isFirstNameValid = false.obs;
  final isLastNameValid = false.obs;
  final isEmailValid = false.obs;
  final isPasswordValid = false.obs;
  final isConfirmPasswordValid = false.obs;

  final isFormValid = false.obs;


  final Rxn<LoginMethod> currentLoginMethod = Rxn();
  final loginMethods = <LoginMethod>[
    LoginMethod.email,
    LoginMethod.google,
    LoginMethod.apple,
  ];

  Worker? _validationWorker;
  @override
  void onInit() {
    super.onInit();
    listenToValidationState();
  }

  void listenToValidationState() {
    _validationWorker = everAll([
      agreeToTerms,
      isFirstNameValid,
      isLastNameValid,
      isEmailValid,
      isPasswordValid,
      isConfirmPasswordValid,
    ], (callback) {
      final isValid = agreeToTerms.value &&
          isFirstNameValid.value &&
          isLastNameValid.value &&
          isEmailValid.value &&
          isPasswordValid.value &&
          isConfirmPasswordValid.value;
      isFormValid.value = isValid;
    });
  }

  Future<void> registerBy({required LoginMethod method}) async {
    currentLoginMethod.value = method;
    if (method == LoginMethod.email) {
      currentLoginMethod.value = LoginMethod.email;
    } else {
      AppController.instance.loadingStatus.value = LoadingStatus.register;
      currentLoginMethod.value = null;
      final result = await authRepository.loginViaAuth0(method: method);
      result.when(
        success: (User user) async {
          _navigateToHome();
        },
        error: (NetworkException exception) {
          AppController.instance.loadingStatus.value = LoadingStatus.none;
          Alert.error(message: exception.message);
        },
      );
    }
  }

  Future<void> register() async {
    if (!isFormValid.value) return;
    AppController.instance.loadingStatus.value = LoadingStatus.register;

    final result = await authRepository.register(
      firstName: firstNameController.text,
      lastName: lastNameController.text,
      email: emailController.text,
      password: passwordController.text,
    );
    result.when(
      success: (User user) async {
        _navigateToHome();
      },
      error: (NetworkException exception) {
        Alert.error(message: exception.message);
        AppController.instance.loadingStatus.value = LoadingStatus.none;
      },
    );
  }

  Future<void> _navigateToHome() async {
    AppController.instance.loadingStatus.value = LoadingStatus.none;
    AppNavigation.navigateFromRegisterToHome();
  }

  void changeHidePasswordState() {
    hidePassword.value = !hidePassword.value;
  }

  void changeHideConfirmPasswordState() {
    hideConfirmPassword.value = !hideConfirmPassword.value;
  }

  void navigateToLogin() {
    AppNavigation.navigateFromRegisterToLogin();
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    _validationWorker?.dispose();
    _validationWorker = null;
    super.onClose();
  }
}
