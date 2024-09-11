import 'package:playx/playx.dart';

import '../../../../../core/resources/translation/app_translations.dart';

class Auth0exception extends ApiException {
  final String errorCode;
  final String auth0ErrorMessage;

  Auth0exception({
    required this.errorCode,
    required this.auth0ErrorMessage,
    Map<String, dynamic>? errorDetails,
  }) : super(
          statusCode: 400,
          errorMessage: _getAuth0ErrorMessage(
            errorCode: errorCode,
            auth0ErrorMessage: auth0ErrorMessage,
            errorDetails: errorDetails,
          ),
        );

  static String _getAuth0ErrorMessage({
    required String errorCode,
    required String auth0ErrorMessage,
    Map<String, dynamic>? errorDetails,
  }) =>
      switch (errorCode) {
        // When a user closes the browser app and in turn, cancels the authentication
        'USER_CANCELLED' ||
        'a0.authentication_canceled' =>
          AppTrans.userCanceledLoginErrorMessage,
        // When there is no Browser app installed to handle the web authentication
        'a0.browser_not_available' => AppTrans.browserNotAvailableErrorMessage,
        // When the required algorithms to support PKCE web authentication is    not available on the device
        'a0.pkce_not_available' => AppTrans.pkceNotAvailableErrorMessage,
        // When the Authorize URL is invalid
        'a0.invalid_authorize_url' => AppTrans.invalidAuthorizeUrlErrorMessage,
        // When a Social Provider Configuration is invalid
        'a0.invalid_configuration' => AppTrans.invalidConfigurationErrorMessage,
        // When MFA code is required to authenticate
        'mfa_required' || 'a0.mfa_required' => AppTrans.mfaRequiredErrorMessage,
        // When MFA is required and the user is not enrolled
        'a0.mfa_registration_required' ||
        'unsupported_challenge_type' =>
          AppTrans.mfaRegistrationRequiredErrorMessage,
        // When Bot Protection flags the request as suspicious
        'requires_verification' => AppTrans.requiresVerificationErrorMessage,
        // When password used was reported to be leaked and a different one is required
        'password_leaked' => AppTrans.passwordLeakedErrorMessage,
        // When Auth0 rule returns an error. The message returned by the rule will be in description
        'unauthorized' => AppTrans.ruleError,
        // When authenticating with web-based authentication and the resource server denied access per OAuth2 spec
        'access_denied' => AppTrans.accessDeniedErrorMessage,
        // When authenticating with web-based authentication using prompt=none and the auth0 session had expired
        'login_required' => AppTrans.loginRequiredErrorMessage,
        // When the user is blocked due to too many attempts to log in
        'too_many_attempts' => AppTrans.tooManyAttemptsErrorMessage,

        // /// When the password used for signup does not match the strength requirements of the connection.
        // /// Additional information is available in the ``info`` dictionary.
        // public var isPasswordNotStrongEnough: Bool {
        // return self.code == "invalid_password" && self.info["name"] as? String == "PasswordStrengthError"
        // }
        //
        // /// When the password used for signup was already used before. This is reported when the Password History feature
        // /// is enabled.
        // /// Additional information is available in the ``info`` dictionary.
        // public var isPasswordAlreadyUsed: Bool {
        // return self.code == "invalid_password" && self.info["name"] as? String == "PasswordHistoryError"
        // }

        _ => AppTrans.unexpectedError,
      };
}
