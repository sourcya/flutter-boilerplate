part of '../imports/reset_password_imports.dart';

class ResetPasswordBinding extends PlayxBinding {
  @override
  Future<void> onEnter(BuildContext context, GoRouterState state) async {
    final tokenExtra = state.extra;
    final token = tokenExtra is String ? tokenExtra : null;
    final recoveryEmail = state.uri.queryParameters['email'];

    if (token == null || token.isEmpty) {
      PlayxNavigation.offAllNamed(Routes.login);
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Alert.error(message: AppTrans.invalidToken);
      });
      return;
    }

    Get.put<ResetPasswordController>(
      ResetPasswordController(
        token: token,
        recoveryEmail: recoveryEmail,
      ),
    );
  }

  @override
  Future<void> onReEnter(
    BuildContext context,
    GoRouterState? state,
    bool wasPoppedAndReentered,
  ) async {
    final tokenExtra = state?.extra;
    final token = tokenExtra is String ? tokenExtra : null;
    final recoveryEmail = state?.uri.queryParameters['email'];

    if (token != null && token.isNotEmpty) {
      if (!Get.isRegistered<ResetPasswordController>()) {
        Get.put<ResetPasswordController>(
          ResetPasswordController(
            token: token,
            recoveryEmail: recoveryEmail,
          ),
        );
      } else {
        if (!wasPoppedAndReentered) {
          Get.find<ResetPasswordController>().updateRouteArgs(
            token: token,
            recoveryEmail: recoveryEmail,
          );
        }
      }
    }
  }

  @override
  Future<void> onHidden(BuildContext context) async {
    await Future.delayed(500.milliseconds);
    if (Get.isRegistered<ResetPasswordController>()) {
      Get.delete<ResetPasswordController>();
    }
  }

  @override
  Future<void> onExit(BuildContext context) async {
    if (Get.isRegistered<ResetPasswordController>()) {
      Get.delete<ResetPasswordController>();
    }
  }
}
