//utils that will be used in the app
import 'package:flutter/material.dart';
import 'package:playx/playx.dart';

import '../resources/theme/dark_theme.dart';

/// Class for app utilities that will be used in the app.
class AppUtils {
  AppUtils._();

  /// validates text field forms state and apply it to an RxBool
  static void validate(GlobalKey<FormState> key, RxBool validatorListener) {
    final formState = key.currentState;
    final isValid = formState != null && formState.validate();
    validatorListener.value = isValid;
  }

  static bool isDarkMode() {
    return PlayxTheme.id == DarkTheme.theme.id;
  }
}
