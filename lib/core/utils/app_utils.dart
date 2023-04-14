//utils that will be used in the app
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppUtils {
  AppUtils._();

  static void validate(GlobalKey<FormState> key, RxBool validatorListener) {
    final formState = key.currentState;
    final isValid = formState != null && formState.validate();
    validatorListener.value = isValid;
  }
}
