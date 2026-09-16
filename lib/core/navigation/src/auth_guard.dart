part of '../navigation.dart';

/// Route guard that runs before entering any authenticated route.
///
/// Server-side token validity is handled separately by [SessionManager] +
/// [PlayxNetworkClient.onUnauthorizedRequestReceived].
class AuthGuard {
  const AuthGuard._();

  static const _publicPaths = <String>[
    Paths.splash,
    Paths.login,
    Paths.forgetPassword,
    Paths.passwordOtp,
    Paths.resetPassword,
    Paths.onboarding,
  ];

  static Future<String?> redirect(
    BuildContext context,
    GoRouterState state,
  ) async {
    final location = state.matchedLocation;
    final isPublicRoute =
        _publicPaths.any((p) => location == p || location.startsWith('$p/'));
    if (!isPublicRoute) {
      final hasToken = !(await SessionManager.instance.isTokenMissing());
      if (!hasToken) return Paths.login;
    }
    return null;
  }
}
