part of '../imports/password_otp_imports.dart';

class PasswordOtpBinding extends PlayxBinding {
  @override
  Future<void> onEnter(BuildContext context, GoRouterState state) async {
    myLogger.d('Entering PasswordOtpBinding with state: $state');
    final email = state.uri.queryParameters['email'];
    final otpSentAtRaw = state.uri.queryParameters['otpSentAt'];
    final otpMs = int.tryParse(otpSentAtRaw ?? '');
    final createOtpTime = otpMs != null
        ? DateTime.fromMillisecondsSinceEpoch(otpMs)
        : DateTime.now();

    if (email == null || email.isEmpty) {
      PlayxNavigation.offAllNamed(Routes.login);
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Alert.error(message: AppTrans.invalidEmailAddress);
      });
      return;
    }

    Get.put(
      PasswordOtpController(
        email: email,
        createOtpTime: createOtpTime,
        authRepository: AuthRepository.instance,
      ),
    );
  }

  @override
  Future<void> onReEnter(
    BuildContext context,
    GoRouterState? state,
    bool wasPoppedAndReentered,
  ) async {
    myLogger.d('Re-entering PasswordOtpBinding with state: $state');
    final email = state?.uri.queryParameters['email'];
    final otpSentAtRaw = state?.uri.queryParameters['otpSentAt'];
    final otpMs = int.tryParse(otpSentAtRaw ?? '');
    final createOtpTime = otpMs != null ? DateTime.fromMillisecondsSinceEpoch(otpMs) : null;

    if (email != null && email.isNotEmpty) {
      final effectiveOtpTime = createOtpTime ?? DateTime.now();
      if (!Get.isRegistered<PasswordOtpController>()) {
        Get.put<PasswordOtpController>(
          PasswordOtpController(
            email: email,
            createOtpTime: effectiveOtpTime,
            authRepository: AuthRepository.instance,
          ),
        );
      } else {
        if (!wasPoppedAndReentered) {
          Get.find<PasswordOtpController>().updateEmail(email, effectiveOtpTime);
        }
      }
    }
  }

  @override
  Future<void> onHidden(BuildContext context) async {
    myLogger.d('Hiding PasswordOtpBinding');
    await Future.delayed(500.milliseconds);
    if (Get.isRegistered<PasswordOtpController>()) {
      Get.delete<PasswordOtpController>();
    }
  }

  @override
  Future<void> onExit(BuildContext context) async {
    myLogger.d('Exiting PasswordOtpBinding');
    Get.delete<PasswordOtpController>();
  }
}
