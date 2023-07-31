import 'package:flutter/material.dart';
import 'package:google_sign_in_platform_interface/google_sign_in_platform_interface.dart';
import 'package:google_sign_in_web/google_sign_in_web.dart' as web;

import 'stub.dart';

/// Renders a web-only SIGN IN button.
Widget buildGoogleSignInButton(
    {HandleSignInFn? onPressed, bool isIcon = false, bool isDark = false}) {
  print('building google sign in for web');
  return (GoogleSignInPlatform.instance as web.GoogleSignInPlugin).renderButton(
    configuration: web.GSIButtonConfiguration(
      type: isIcon ? web.GSIButtonType.icon : web.GSIButtonType.standard,
      size: web.GSIButtonSize.large,
      theme:
          isDark ? web.GSIButtonTheme.filledBlack : web.GSIButtonTheme.outline,
    ),
  );
}
