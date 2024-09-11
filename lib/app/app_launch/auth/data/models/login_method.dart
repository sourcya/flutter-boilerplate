import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/core/models/icon_info.dart';
import 'package:flutter_boilerplate/core/resources/colors/app_colors.dart';

import '../../../../../core/resources/assets/assets.dart';
import '../../../../../core/resources/translation/app_translations.dart';

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

  IconInfo get icon => switch (this) {
        auth0Web => IconInfo.icon(Icons.login),
        email => IconInfo.icon(Icons.email),
        google => IconInfo.svg(Assets.images.google),
        apple => IconInfo.svg(Assets.images.apple),
      };

  String get loginLabel => switch (this) {
        auth0Web => AppTrans.loginWithAuth0Label,
        email => AppTrans.loginWithEmailLabel,
        google => AppTrans.loginWithGoogleLabel,
        apple => AppTrans.loginWithAppleLabel,
      };

  Color? backgroundColor(BuildContext context) => switch (this) {
        auth0Web => context.colors.primary,
        email => context.colors.primary,
        google => context.colors.primary.withOpacity(.6),
        apple => context.colors.primary.withOpacity(.6),
      };

  Color? onBackground(BuildContext context) => switch (this) {
        auth0Web => context.colors.onPrimary,
        email => context.colors.onPrimary,
        google => context.colors.onPrimary,
        apple => context.colors.onPrimary,
      };

  Color? iconColor(BuildContext context) => switch (this) {
        auth0Web => context.colors.onPrimary,
        email => context.colors.onPrimary,
        google => null,
        apple => null,
      };
}
