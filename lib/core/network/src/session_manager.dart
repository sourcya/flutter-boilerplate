part of '../network.dart';

/// Centralized manager for session-expiry detection and the forced-logout flow.
///
/// [SessionManager] is a lazy singleton accessed via [SessionManager.instance].
/// It is used by:
/// - [PlayxNetworkClient.onUnauthorizedRequestReceived] — when a 401/403
///   response is received from any API call.
/// - [AuthGuard] — when a protected route is about to be entered.
///
/// The flow on a 401/403:
/// 1. Call the profile endpoint (`/users/me`) to verify whether the
///    session is actually expired (avoids reacting to a single transient
///    failure).
/// 2. If confirmed expired, show a confirmation dialog (not a silent redirect)
///    informing the user their session has expired, with a **"Login"** button.
/// 3. On tapping "Login", clear all cached user/session state and navigate to
///    the Login screen.
class SessionManager {
  SessionManager._();

  static SessionManager? _instance;
  // ignore: prefer_constructors_over_static_methods
  static SessionManager get instance => _instance ??= SessionManager._();

  /// Guards against showing the dialog more than once.
  bool _isDialogShowing = false;

  /// Deduplicates concurrent unauthorized-response triggers.
  Future<void>? _unauthorizedVerificationFuture;

  /// Called by [PlayxNetworkClient.onUnauthorizedRequestReceived] when a
  /// 401/403 response is received, or by [AuthGuard] when a protected route
  /// is about to be entered and the token appears invalid.
  Future<void> handleUnauthorizedResponse() async {
    if (await MyPreferenceManger.instance.isLoggedOut) return;
    if (_isDialogShowing) return;

    final pendingVerification = _unauthorizedVerificationFuture;
    if (pendingVerification != null) {
      return pendingVerification;
    }

    final verification = _verifySessionAndHandleExpiration();
    _unauthorizedVerificationFuture = verification;
    try {
      await verification;
    } finally {
      _unauthorizedVerificationFuture = null;
    }
  }

  Future<void> _verifySessionAndHandleExpiration() async {
    try {
      final isExpired = await _verifySessionExpired();
      if (isExpired) {
        await _showSessionExpiredDialog();
      }
    } catch (e, s) {
      await Sentry.captureException(e, stackTrace: s);
    }
  }

  /// Lightweight local check: returns `true` if there is no token at all.
  Future<bool> isTokenMissing() async {
    final token = await MyPreferenceManger.instance.token;
    return token == null || token.isEmpty;
  }

  /// Calls `GET /users/me` to verify whether the session is still valid.
  Future<bool> _verifySessionExpired() async {
    final token = await MyPreferenceManger.instance.token;
    if (token == null || token.isEmpty) return true;

    if (!getIt.isRegistered<AuthRepository>()) {
      AuthRepository.registerInstance();
    }

    try {
      final result = await AuthRepository.instance.validateSession();
      if (result.isError) {
        final error = result.error;
        if (error != null) {
          return _isUnauthorizedException(error);
        }
      }
      return false;
    } catch (e, s) {
      await Sentry.captureException(e, stackTrace: s);
      return false;
    }
  }

  static bool _isUnauthorizedException(NetworkException error) {
    return error is ApiException &&
        (error.statusCode == 401 || error.statusCode == 403);
  }

  Future<void> _showSessionExpiredDialog() async {
    if (_isDialogShowing) return;
    _isDialogShowing = true;

    final context = NavigationUtils.navigationContext;
    if (context == null) {
      await _forceLogout();
      _isDialogShowing = false;
      return;
    }

    try {
      await showConfirmDialog(
        title: AppTrans.sessionExpiredTitle,
        message: AppTrans.sessionExpiredMessage,
        lottie: Assets.animations.logout,
        lottieBackgroundColor: context.colors.errorContainer,
        color: context.colors.error,
        hideCancel: true,
        confirmLabel: AppTrans.loginText,
        isConfirm: false,
        onConfirmed: () {},
        context: context,
      );
      await _forceLogout();
    } catch (e, s) {
      await Sentry.captureException(e, stackTrace: s);
      await _forceLogout();
    } finally {
      _isDialogShowing = false;
    }
  }

  /// Public entry point when the caller has already confirmed expiry
  /// (e.g. splash [AppSessionStatus.sessionExpired]).
  Future<void> showSessionExpiredDialog() async {
    if (_isDialogShowing) return;
    if (_unauthorizedVerificationFuture != null) {
      await _unauthorizedVerificationFuture;
      return;
    }
    await _showSessionExpiredDialog();
  }

  Future<void> _forceLogout() async {
    try {
      await AuthRepository.handleSignOut();

      if (Get.isRegistered<AppController>()) {
        final appController = AppController.instance;
        appController.currentUser.value = null;
        appController.currentSubscription.value = null;
      }

      Alert.dismissAll();
      AppNavigation.navigateToLogin();
    } catch (e, s) {
      await Sentry.captureException(e, stackTrace: s);
    }
  }
}
