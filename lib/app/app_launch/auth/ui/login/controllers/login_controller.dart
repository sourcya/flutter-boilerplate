part of '../imports/login_imports.dart';

class LoginController extends GetxController {
  final AuthRepository repo;

  LoginController({required this.repo});

  final hidePassword = true.obs;
  final rememberMe = true.obs;

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final emailFocusNode = FocusNode();
  final passwordFocusNode = FocusNode();

  final isEmailValid = false.obs;
  final isPasswordValid = false.obs;
  final isFormValid = false.obs;
  Worker? _validationWorker;

  @override
  void onInit() {
    super.onInit();
    emailController.addListener(_syncValidationFromTextControllers);
    passwordController.addListener(_syncValidationFromTextControllers);
    _validationListener();
  }

  void _validationListener() {
    _validationWorker = everAll(
      [
        isEmailValid,
        isPasswordValid,
      ],
      (_) {
        isFormValid.value = isEmailValid.value && isPasswordValid.value;
      },
    );
  }

  void _syncValidationFromTextControllers() {
    final email = emailController.text.trim();
    final password = passwordController.text;

    isEmailValid.value = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(email);
    isPasswordValid.value = password.isNotEmpty;
  }

  @override
  void onReady() {
    super.onReady();
    unawaited(_restoreSavedLoginFields());
  }

  Future<void> _restoreSavedLoginFields() async {
    final prefs = MyPreferenceManger.instance;
    final username = await prefs.getSavedUsername();
    final password = await prefs.getSavedPassword();

    if (username != null &&
        password != null &&
        username.isNotEmpty &&
        password.isNotEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        emailController.text = username;
        passwordController.text = password;
        isEmailValid.value = true;
        isPasswordValid.value = true;
        isFormValid.value = true;
      });
      rememberMe.value = true;
      return;
    }

    rememberMe.value = await prefs.shouldRememberUser;
  }

  Future<void> signIn() async {
    if (!isFormValid.value) return;
    FocusManager.instance.primaryFocus?.unfocus();
    TextInput.finishAutofillContext(shouldSave: rememberMe.value);
    try {
      AppController.instance.loadingStatus.value = const LoadingStatus.login();
      final result = await repo.loginViaEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      if (result is NetworkError<User>) {
        Alert.error(message: result.error.message);
        return;
      }
      final user = (result as NetworkSuccess<User>).data;
      await AppController.instance.updateCurrentUser(user: user.info);
      final prefs = MyPreferenceManger.instance;
      await prefs.saveRememberMe(rememberMe.value);
      if (rememberMe.value) {
        await prefs.saveUserCredentials(
          username: emailController.text,
          password: passwordController.text,
        );
      } else {
        await prefs.forgetUsernameAndPassword();
      }
      AppNavigation.navigateFromLoginToHome();
    } catch (e) {
      Alert.error(message: e.toString(), isMessageTranslatable: false);
    } finally {
      AppController.instance.loadingStatus.value = const LoadingStatus.idle();
    }
  }

  void navigateToRegister() {
    AppNavigation.navigateFromLoginToRegister();
  }

  void onRememberMeChanged(bool? value) {
    if (value == null) return;
    rememberMe.value = value;
  }

  void toggleRememberMe() {
    rememberMe.value = !rememberMe.value;
  }

  void onForgotPassword() {
    AppNavigation.navigateFromLoginToForgetPassword();
  }

  Future<void> onTelephoneContact({BuildContext? context}) async {
    final canLaunch = await launchPhoneNumber(
      number: Constants.telephoneNumber,
    );
    if (!canLaunch) {
      await Clipboard.setData(
        const ClipboardData(text: Constants.telephoneNumber),
      );
      Alert.success(message: AppTrans.phoneNumberCopiedToClipboard);
    }
  }

  Future<void> onPhoneContact({BuildContext? context}) async {
    final canLaunch = await launchPhoneNumber(
      number: Constants.phoneNumber,
    );
    if (!canLaunch) {
      await Clipboard.setData(
        const ClipboardData(text: Constants.phoneNumber),
      );
      Alert.success(message: AppTrans.phoneNumberCopiedToClipboard);
    }
  }

  void onWhatsappContact({BuildContext? context}) {
    unawaited(contactSupportViaWhatsapp(context: context));
  }

  void focusEmailField() {
    if (!emailFocusNode.hasFocus) {
      emailFocusNode.requestFocus();
    }
  }

  void focusPasswordField() {
    if (!passwordFocusNode.hasFocus) {
      passwordFocusNode.requestFocus();
    }
  }

  @override
  void onClose() {
    super.onClose();
    emailController.removeListener(_syncValidationFromTextControllers);
    passwordController.removeListener(_syncValidationFromTextControllers);
    emailController.dispose();
    passwordController.dispose();
    emailFocusNode.dispose();
    passwordFocusNode.dispose();
    _validationWorker?.dispose();
  }
}
