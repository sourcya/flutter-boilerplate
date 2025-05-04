part of '../models.dart';

enum LoginMethod {
  auth0Web,
  email,
  google,
  apple;

  String get auth0Connection => switch (this) {
        auth0Web => '',
        email => 'Username-Password-Authentication',
        google => 'google-oauth2',
        apple => 'apple',
      };

  IconInfo? get icon => switch (this) {
        auth0Web => IconInfo.icon(Icons.login),
        email => null,
        google => IconInfo.svg(Assets.icons.google),
        apple => IconInfo.svg(Assets.icons.apple),
      };

  String get loginLabel => switch (this) {
        auth0Web => AppTrans.loginWithAuth0Label,
        email => AppTrans.loginWithEmailLabel,
        google => AppTrans.loginWithGoogleLabel,
        apple => AppTrans.loginWithAppleLabel,
      };

  Color? backgroundColor(BuildContext context) => switch (this) {
        auth0Web => context.colors.primary.withValues(alpha: .6),
        email => context.colors.primary.withValues(alpha: .6),
        google => context.colors.primary.withValues(alpha: .6),
        apple => context.colors.primary.withValues(alpha: .6),
      };

  Color? onBackground(BuildContext context) => switch (this) {
        auth0Web => context.colors.onPrimary,
        email => context.colors.onPrimary,
        google => context.colors.onPrimary,
        apple => context.colors.onPrimary,
      };

  Color? iconColor(BuildContext context) => switch (this) {
        auth0Web => context.colors.primary,
        email => context.colors.primary,
        google => null,
        apple => null,
      };

  String get value => switch (this) {
        auth0Web => 'auth0Web',
        email => 'email',
        google => 'google',
        apple => 'apple',
      };

  static LoginMethod? fromValue(String? value) => switch (value) {
        'auth0Web' => auth0Web,
        'email' => email,
        'google' => google,
        'apple' => apple,
        _ => null
      };
}
