part of '../imports/password_otp_imports.dart';

class PasswordOtpController extends GetxController {
  String email;
  DateTime createOtpTime;
  final AuthRepository _authRepository;

  PasswordOtpController({
    required this.email,
    required this.createOtpTime,
    AuthRepository? authRepository,
  }) : _authRepository = authRepository ?? AuthRepository.instance;

  final isLoading = false.obs;

  final isOtpValid = false.obs;
  final currentPin = ''.obs;

  String get remainingMinutes {
    final diff = DateTime.now().difference(createOtpTime);
    final remaining = (10 * 60 - diff.inSeconds) ~/ 60;
    return remaining < 0 ? '0' : remaining.toString();
  }

  String get remainingSeconds {
    final diff = DateTime.now().difference(createOtpTime);

    final remaining = 10 * 60 - diff.inSeconds;
    if (remaining < 0) return '0';
    final seconds = remaining % 60;

    return seconds.toString();
  }

  final isOtpExpired = false.obs;
  Timer? otpTimerWorker;

  @override
  void onInit() {
    super.onInit();
    startOtpTimer();
  }

  void startOtpTimer() {
    otpTimerWorker?.cancel();
    otpTimerWorker = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (remainingMinutes == '0' && remainingSeconds == '0') {
        isOtpExpired.value = true;
        timer.cancel();
      }
    });
  }

  Future<void> verifyOtp() async {
    if (!isOtpValid.value) return;
    isLoading.value = true;

    FocusManager.instance.primaryFocus?.unfocus();
    final result = await _authRepository.verifyForgetPasswordOtpCode(
      code: currentPin.value,
      email: email,
    );

    result.when(
      success: (String token) {
        isLoading.value = false;
        AppNavigation.navigateFromPasswordOtpToResetPassword(
          token: token,
          email: email,
        );
      },
      error: (NetworkException exception) {
        isLoading.value = false;
        Alert.error(message: exception.message);
      },
    );
  }

  Future<void> resendOtpCode() async {
    isLoading.value = true;

    final res = await _authRepository.forgetPassword(email: email);
    res.when(
      success: (bool data) {
        if (data) {
          otpTimerWorker?.cancel();
          createOtpTime = DateTime.now();
          startOtpTimer();
          isOtpExpired.value = false;
          Alert.success(message: AppTrans.passwordOtpResendCodeSuccess);
        } else {
          Alert.error(message: AppTrans.unexpectedError);
        }
        isLoading.value = false;
      },
      error: (NetworkException exception) {
        isLoading.value = false;
        Alert.error(message: exception.message);
      },
    );
  }

  void updateEmail(String email, DateTime createOtpTime) {
    this.email = email;
    this.createOtpTime = createOtpTime;
    startOtpTimer();
  }

  @override
  void onClose() {
    otpTimerWorker?.cancel();
    super.onClose();
  }
}
