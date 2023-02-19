import 'app_translations.dart';

class EnglishTranslation extends BaseTranslation {
  @override
  Map<String, String> get translations => {
        AppTrans.appName: "Sourcya App",

        //Network Errors
        AppTrans.requestCancelled: "The request has been canceled",
        AppTrans.unauthorizedRequest: "Unauthorized Request",
        AppTrans.badRequest: "bad Request",
        AppTrans.notFound: "not found",
        AppTrans.methodNotAllowed: "Method Not Allowed",
        AppTrans.notAcceptable: "The request is not acceptable",
        AppTrans.requestTimeout: "Sorry, connection timed out.",
        AppTrans.sendTimeout: "Send timeout in connection with API server",
        AppTrans.unProcessableEntity: "Unable to process the data",
        AppTrans.conflict: "Error due to a conflict",
        AppTrans.internalServerError: "internal server error",
        AppTrans.notImplemented: "not implemented",
        AppTrans.serviceUnavailable: "service unavailable",
        AppTrans.noInternetConnection:
            "Sorry, There is no internet connection.",
        AppTrans.formatException: "format exception",
        AppTrans.unableToProcess: "Unable to process the data",
        AppTrans.defaultError: "Sorry, Something went wrong.",
        AppTrans.unexpectedError: "Sorry, Something went wrong.",
        AppTrans.emptyResponse:
            "Sorry, couldn't receive response from the server.",

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
        AppTrans.retryText: "Retry"
      };
}
