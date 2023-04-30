abstract class BaseTranslation {
  Map<String, String> get translations;
}

/// App Translation keys for every word that need to be translated
/// This key can be used to provide the right translation
/// for example we can get app name by using AppTrans.appName.tr
// ignore: avoid_classes_with_only_static_members
abstract class AppTrans {
  static const String appName = "app_name";

  //network errors
  static const String requestCancelled = "requestCancelled";
  static const String unauthorizedRequest = "UnauthorizedRequest";
  static const String badRequest = "badRequest";
  static const String notFound = "notFound";
  static const String methodNotAllowed = "methodNotAllowed";
  static const String notAcceptable = "notAcceptable";
  static const String requestTimeout = "RequestTimeout";
  static const String sendTimeout = "sendTimeout";
  static const String unProcessableEntity = "unProcessableEntity";
  static const String conflict = "conflict";
  static const String internalServerError = "internalServerError";
  static const String notImplemented = "NotImplemented";
  static const String serviceUnavailable = "ServiceUnavailable";
  static const String noInternetConnection = "NoInternetConnection";
  static const String formatException = "FormatException";
  static const String unableToProcess = "UnableToProcess";
  static const String defaultError = "defaultError";
  static const String unexpectedError = "UnexpectedError";
  static const String emptyResponse = "emptyResponse";

  //app
  static const String emailHint = "email_hint";
  static const String passwordHint = "password_hint";
  static const String usernameHint = "username_hint";

  static const String loginText = "login_text";
  static const String registerText = "register_text";

  static const String emailRequired = "email_required";
  static const String passwordRequired = "password_required";
  static const String usernameRequired = "username_required";

  static const String emailOrUsernameLabel = "email_or_username_label";
  static const String emailLabel = "email_label";
  static const String usernameLabel = "username_label";
  static const String passwordLabel = "password_label";

  static const String dontHaveAccountText = "dont_have_account_text";
  static const String registerNow = "register_now";

  static const String haveAccountText = "have_account_text";
  static const String loginNow = "login_now";

  static const String notEmailError = "not_email_error";

  static const String confirmPasswordLabel = "confirm_password_label";
  static const String confirmPasswordHint = "confirm_password_hint";

  static const String passwordMinLengthError = "password_min_length_error";
  static const String confirmPasswordRequiredError =
      "confirm_password_required_error";
  static const String confirmPasswordMatchError =
      "confirm_password_match_error";

  static const String termsAndPrivacyInitialText =
      "terms_and_privacy_initial_text";
  static const String terms = "terms";
  static const String privacyPolicyText = "privacy_policy_text";

  static const String andText = "and_text";

  static const String playerLoopingDisabled = "player_looping_disabled";
  static const String playerLoopingEnabled = "player_looping_enabled";
  static const String playerBackOnline = "player_back_online";
  static const String playerNoConnection = "player_no_connection";
  static const String playerDismiss = "player_dismiss";
  static const String playerTryAgain = "player_try_again";
  static const String playerDefaultError = "player_default_error";
  static const String playerNoInternetMainError =
      "player_no_internet_main_error";

  static const String noDataMessage = "no_data_message";
  static const String noInternetMessage = "no_internet_message";
  static const String retryText = "retry_text";
}
