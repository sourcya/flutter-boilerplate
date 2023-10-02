import 'dart:async';

import 'package:flutter/material.dart';

/// The type of the onClick callback for the (mobile) Sign In Button.
typedef HandleSignInFn = Future<void> Function();

/// Renders a SIGN IN button that (maybe) calls the `handleSignIn` onclick.
Widget buildGoogleSignInButton(
    {HandleSignInFn? onPressed, bool isIcon = false, bool isDark = false}) {
  print('building google sign in for stub');

  return Container();
}
