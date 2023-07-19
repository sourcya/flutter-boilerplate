import 'app_translations.dart';



class EnglishTranslation extends BaseTranslation {
      @override
      String get badRequest =>  "Sorry, The API request is invalid or improperly formed.";





      @override
  Map<String, String> get translations => {
        AppTrans.appName: "Sourcya App",

        //Network Errors
        AppTrans.requestCancelled: "Sorry, The request has been canceled.",
        AppTrans.unauthorizedRequest: "Sorry, The request is unauthorized.",
        AppTrans.badRequest: "Sorry, The API request is invalid or improperly formed.",
        AppTrans.notFound: "Sorry, The resource requested couldn't be found.",
        AppTrans.notAcceptable: "Sorry, The request is not acceptable.",
        AppTrans.requestTimeout: "Sorry, The request has timed out.",
        AppTrans.sendTimeout: "Sorry, The request has send timeout in connection with API server.",
        AppTrans.unProcessableEntity: "Unable to process the data",
        AppTrans.conflict: "Sorry, The request wasn't completed due to a conflict.",
        AppTrans.internalServerError: "Sorry, There is an internal server error.",
        AppTrans.serviceUnavailable: "Sorry, The service is unavailable.",
        AppTrans.noInternetConnection:
            "Sorry, There is no internet connection.",
        AppTrans.formatException: "Sorry, The request wasn't formatted correctly.",
        AppTrans.unableToProcess: "Sorry, Couldn't process the data.",
        AppTrans.defaultError: "Sorry, Something went wrong.",
        AppTrans.unexpectedError: "Sorry, Something went wrong.",
        AppTrans.emptyResponse:
            "Sorry, Couldn't receive response from the server.",

        //biometric auth
        AppTrans.bioLocalizedReason: 'Please authenticate to login',
        AppTrans.bioSignInTitle: 'Biometric authentication is required!',
        AppTrans.bioCancelText: 'No thanks',
        AppTrans.bioCanAuthenticate: "Can't authenticate with biometric",
        AppTrans.bioNotAvailableError:
            'Authentication using biometric is not available, Try setting lock screen password.',
        AppTrans.bioNotEnrolledError:
            'No biometrics has been enrolled on the device',
        AppTrans.bioLockedOutError:
            'Biometric authentication has been locked out due to too many attempts',
        AppTrans.bioDefaultError: 'Sorry, Something went wrong',
        AppTrans.bioPasscodeNotSetError:
            "You haven't configured any password for the device yet pls configure it to use the app.",

        //app
        AppTrans.emailHint: "Enter your username or email address",
        AppTrans.passwordHint: "Enter your password",
        AppTrans.usernameHint: "Enter your Username",

        AppTrans.loginText: "Login",
        AppTrans.registerText: "Register",

        AppTrans.emailRequired: "Email address is required",
        AppTrans.passwordRequired: "Password is required",
        AppTrans.usernameRequired: "Username is required",

        AppTrans.emailOrUsernameLabel: "Email or username",
        AppTrans.emailLabel: "Email",
        AppTrans.usernameLabel: "Username",
        AppTrans.passwordLabel: "Password",

        AppTrans.dontHaveAccountText: "Don't have an account?",
        AppTrans.registerNow: " Register Now!",

        AppTrans.haveAccountText: "Already have an account?",
        AppTrans.loginNow: " Login Now!",

        AppTrans.notEmailError: "Please enter a valid email address.",

        AppTrans.confirmPasswordLabel: "Confirm password",
        AppTrans.confirmPasswordHint: "Enter your password again.",

        AppTrans.passwordMinLengthError:
            "Password must be at least 6 characters long.",
        AppTrans.confirmPasswordRequiredError: "Confirm password is required.",
        AppTrans.confirmPasswordMatchError: "Passwords do not match.",

        AppTrans.termsAndPrivacyInitialText:
            "By registering, you agree to our ",
        AppTrans.terms: "Terms & Conditions",
        AppTrans.andText: " and ",

        AppTrans.privacyPolicyText: "Privacy Policy.",

        AppTrans.noDataMessage: "There is no data available.",
        AppTrans.noInternetMessage: "Network is not available.",
        AppTrans.retryText: "Retry",

        AppTrans.updateTitle: 'An update is available.',
        AppTrans.updateDescription:
            'A new version of the app is now available.\n\n'
                'Update now to enjoy the latest features now.',

        AppTrans.updateReleaseNotesTitle: 'Release notes:',
        AppTrans.updateConfirmActionTitle: 'Update',
        AppTrans.updateDismissActionTitle: 'Not Now',
      };
}
