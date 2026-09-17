part of '../../imports/app_imports.dart';

mixin AppAuthMixin on GetxController {
  AppController get app => this as AppController;

  final currentUser = Rxn<UserInfo>();
  final currentSubscription = Rxn<Subscription>();

  Future<void> updateCurrentUser({UserInfo? user}) async {
    final resolvedUser =
        user ?? await MyPreferenceManger.instance.getSavedUser();
    if (resolvedUser != null) {
      currentUser.value = resolvedUser;
      currentSubscription.value ??= Subscription(
        username: resolvedUser.username ?? '',
        email: resolvedUser.email ?? '',
        phoneNumber: '+966123456789',
        isNonExpiring: true,
      );
    }
  }

  Future<UserInfo?> getCurrentUser() async {
    if (currentUser.value == null) {
      await updateCurrentUser();
    }
    return currentUser.value;
  }

  /// Checks the stored token against the profile endpoint.
  ///
  /// Session expiry is **not** handled here — the caller (e.g. splash)
  /// shows the dialog via [SessionManager.showSessionExpiredDialog].
  Future<AppSessionStatus> checkSessionStatus() async {
    if (!getIt.isRegistered<AuthRepository>()) {
      AuthRepository.registerInstance();
    }

    final result = await AuthRepository.instance.validateSession();
    if (result.isError) {
      final error = result.error;
      if (error is ApiException &&
          (error.statusCode == 401 || error.statusCode == 403)) {
        return AppSessionStatus.sessionExpired;
      }
    }
    return AppSessionStatus.active;
  }
}

/// Result of a session-status check against the profile endpoint.
enum AppSessionStatus {
  active,
  sessionExpired,
}
