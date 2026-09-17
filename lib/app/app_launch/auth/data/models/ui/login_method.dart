part of '../models.dart';

enum LoginMethod {
  email;

  String get loginLabel => AppTrans.loginWithEmailLabel;

  String get value => 'email';

  static LoginMethod? fromValue(String? value) => switch (value) {
        'email' => email,
        _ => null,
      };
}
