part of '../navigation.dart';

abstract class Routes {
  static const splash = 'splash';
  static const login = 'login';
  static const onboarding = 'onboarding';
  static const forgetPassword = 'forget-password';
  static const passwordOtp = 'password-otp';
  static const resetPassword = 'reset-password';
  static const settings = 'settings';
  static const dashboard = 'dashboard';
  static const reports = 'reports';
  static const analytics = 'analytics';
}

abstract class Paths {
  static const splash = '/';
  static const login = '/login';
  static const onboarding = '/onboarding';
  static const forgetPassword = '/password/forget';
  static const passwordOtp = '/password/otp';
  static const resetPassword = '/password/reset';
  static const settings = '/settings';
  static const dashboard = '/dashboard';
  static const reports = '/reports';
  static const analytics = '/analytics';
}
