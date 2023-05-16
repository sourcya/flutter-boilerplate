//utils that will be used in the app
import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/core/resources/theme/dark_theme.dart';
import 'package:playx/exports.dart';

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
    return AppTheme.id == DarkTheme.theme.id;
  }
}

void focusNextTextField(BuildContext context) {
  do {
    final foundFocusNode = FocusScope.of(context).nextFocus();
    if (!foundFocusNode) return;
  } while (
      FocusScope.of(context).focusedChild?.context?.widget is! EditableText);
}
