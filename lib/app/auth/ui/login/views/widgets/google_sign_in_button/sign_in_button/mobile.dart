import 'package:flutter/material.dart';
import 'package:playx/playx.dart';

import '../../../../../../../../core/resources/assets.dart';
import 'stub.dart';

/// Renders a SIGN IN button that calls `handleSignIn` onclick.
Widget buildGoogleSignInButton(
    {HandleSignInFn? onPressed, bool isIcon = false, bool isDark = false}) {
  print('building google sign in for mobile');

  return isIcon
      ? IconButton(
          onPressed: onPressed,
          icon: Container(
            decoration: ShapeDecoration(
              color: isDark ? Colors.black : Colors.white,
              shape: const CircleBorder(),
            ),
            padding: const EdgeInsets.all(4),
            child: ImageViewer.svgAsset(
              AppAssets.googleLogoImage,
              width: 36,
              height: 36,
            ),
          ),
        )
      : ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: isDark ? Colors.black : Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                4,
              ),
            ),
            padding: const EdgeInsets.all(8),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                'Sign in with Google',
                style: TextStyle(
                  fontSize: 15,
                  color: isDark ? Colors.white : Colors.black,
                ),
              ),
              const SizedBox(width: 12),
              ImageViewer.svgAsset(
                AppAssets.googleLogoImage,
                width: 36,
                height: 36,
              )
            ],
          ),
        );
}
