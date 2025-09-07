// ignore_for_file: constant_identifier_names
part of '../navigation.dart';

/// app routes names.
abstract class Routes {
  static const splash = 'splash';
  static const login = 'login';
  static const verifyPhone = 'verifyPhone';
  static const register = 'register';
  static const onboarding = 'onboarding';
  static const settings = 'settings';
  static const dashboard = 'dashboard';
  static const wishlist = 'wishlist';
  static const wishlistDetails = 'wishlistDetails';
  static const privacyPolicy = 'privacyPolicy';
  static const termsConditions = 'termsConditions';
  static const updateprofile ='update-profile'; 
}

/// app routes paths.
abstract class Paths {
  static const splash = '/';
  static const login = '/login';
  static const verifyPhone = '/otp';
  static const register = '/register';
  static const onboarding = '/onboarding';
  static const settings = '/settings';
  static const dashboard = '/dashboard';
  static const wishlist = '/wishlist';
  static const wishlistDetails = 'details';
  static const privacyPolicy = '/privacy-policy';
  static const termsConditions = '/terms-conditions';
  static const updateprofile ='/update-profile';
}
