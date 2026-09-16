part of '../ui.dart';

/// App Translation keys for every word that need to be translated
/// This key can be used to provide the right translation
/// for example we can get app name by using AppTrans.appName.tr
// ignore: avoid_classes_with_only_static_members
abstract class AppTrans {
  const AppTrans._();

  static const appName = 'appName';
  static const requestCancelled = 'requestCancelled';
  static const unauthorizedRequest = 'unauthorizedRequest';
  static const badRequest = 'badRequest';
  static const notFound = 'notFound';
  static const notAcceptable = 'notAcceptable';
  static const requestTimeout = 'requestTimeout';
  static const sendTimeout = 'sendTimeout';
  static const unProcessableEntity = 'unProcessableEntity';
  static const conflict = 'conflict';
  static const internalServerError = 'internalServerError';
  static const serviceUnavailable = 'serviceUnavailable';
  static const noInternetConnection = 'noInternetConnection';
  static const formatException = 'formatException';
  static const unableToProcess = 'unableToProcess';
  static const defaultError = 'defaultError';
  static const unexpectedError = 'unexpectedError';
  static const emptyResponse = 'emptyResponse';
  static const bioLocalizedReason = 'bioLocalizedReason';
  static const bioSignInTitle = 'bioSignInTitle';
  static const bioCancelText = 'bioCancelText';
  static const bioCanAuthenticate = 'bioCanAuthenticate';
  static const bioNotAvailableError = 'bioNotAvailableError';
  static const bioNotEnrolledError = 'bioNotEnrolledError';
  static const bioLockedOutError = 'bioLockedOutError';
  static const bioDefaultError = 'bioDefaultError';
  static const bioPasscodeNotSetError = 'bioPasscodeNotSetError';
  static const emailHint = 'emailHint';
  static const passwordHint = 'passwordHint';
  static const usernameHint = 'usernameHint';
  static const loginText = 'loginText';
  static const registerText = 'registerText';
  static const emailRequired = 'emailRequired';
  static const passwordRequired = 'passwordRequired';
  static const usernameRequired = 'usernameRequired';
  static const emailOrUsernameLabel = 'emailOrUsernameLabel';
  static const emailLabel = 'emailLabel';
  static const usernameLabel = 'usernameLabel';
  static const passwordLabel = 'passwordLabel';
  static const String firstNameLabel = 'firstNameLabel';
  static const String firstNameHint = 'firstNameHint';
  static const String firstNameRequired = 'firstNameRequired';

  static const String lastNameLabel = 'lastNameLabel';
  static const String lastNameHint = 'lastNameHint';
  static const String lastNameRequired = 'lastNameRequired';
  static const dontHaveAccountText = 'dontHaveAccountText';
  static const registerNow = 'registerNow';
  static const haveAccountText = 'haveAccountText';
  static const loginNow = 'loginNow';
  static const notEmailError = 'notEmailError';
  static const confirmPasswordLabel = 'confirmPasswordLabel';
  static const confirmPasswordHint = 'confirmPasswordHint';
  static const passwordMinLengthError = 'passwordMinLengthError';
  static const confirmPasswordRequiredError = 'confirmPasswordRequiredError';
  static const confirmPasswordMatchError = 'confirmPasswordMatchError';
  static const termsAndPrivacyInitialText = 'termsAndPrivacyInitialText';
  static const terms = 'terms';
  static const andText = 'andText';
  static const privacyPolicyText = 'privacyPolicyText';

  static const loggingInText = 'loggingInText';
  static const loginWithEmailLabel = 'loginWithEmailLabel';
  static const loginWithGoogleLabel = 'loginWithGoogleLabel';
  static const loginWithAppleLabel = 'loginWithAppleLabel';
  static const emailOrPasswordIncorrect = 'emailOrPasswordIncorrect';
  static const loginPrompt = 'loginPrompt';
  static const welcomeTitle = 'welcomeTitle';
  static const welcomeFirstPart = 'welcomeFirstPart';
  static const welcomeBackSecondPart = 'welcomeBackSecondPart';
  static const welcomeSubtitle = 'welcomeSubtitle';
  static const signInAccessSubtitle = 'signInAccessSubtitle';
  static const rememberMe = 'rememberMe';
  static const emailLabelWideLandscape = 'emailLabelWideLandscape';
  static const poweredBy = 'poweredBy';

  static const continueWithSocial = 'continueWithSocial';

  static const registerSubtitle = 'registerSubtitle';

  static const registerTitle = 'registerTitle';

  static const registeringText = 'registeringText';

  static const contributions = 'contributions';

  static const profile = 'profile';
  static const agreeToTerms = 'agreeToTerms';

  static const noDataMessage = 'noDataMessage';
  static const noInternetMessage = 'noInternetMessage';
  static const retryText = 'retryText';
  static const updateTitle = 'updateTitle';
  static const updateDescription = 'updateDescription';
  static const updateReleaseNotesTitle = 'updateReleaseNotesTitle';
  static const updateConfirmActionTitle = 'updateConfirmActionTitle';
  static const updateDismissActionTitle = 'updateDismissActionTitle';

  static const settings = 'settings';

  static const language = 'language';

  static const theme = 'theme';

  static const home = 'home';

  static const notifications = 'notifications';

  //onBoarding
  static const firstBoardingTitle = 'firstBoardingTitle';
  static const firstBoardingSubTitle = 'firstBoardingSubTitle';
  static const firstBoardingTitleAccent = 'firstBoardingTitleAccent';
  static const firstBoardingTitleTrailing = 'firstBoardingTitleTrailing';
  static const secondBoardingTitle = 'secondBoardingTitle';
  static const secondBoardingSubTitle = 'secondBoardingSubTitle';
  static const secondBoardingTitleAccent = 'secondBoardingTitleAccent';
  static const secondBoardingTitleTrailing = 'secondBoardingTitleTrailing';
  static const thirdBoardingTitle = 'thirdBoardingTitle';
  static const thirdBoardingSubTitle = 'thirdBoardingSubTitle';
  static const thirdBoardingTitleAccent = 'thirdBoardingTitleAccent';
  static const thirdBoardingTitleTrailing = 'thirdBoardingTitleTrailing';
  static const loremIpsum = 'loremIpsum';

  static const skip = 'skip';
  static const next = 'next';
  static const back = 'back';
  static const getStarted = 'getStarted';
  static const main = 'main';
  static const account = 'account';
  static const accountInformation = 'accountInformation';
  static const accountSubtitle = 'accountSubtitle';
  static const preferences = 'preferences';
  static const preferencesSubtitle = 'preferencesSubtitle';
  static const username = 'username';
  static const usernameSubtitle = 'usernameSubtitle';
  static const email = 'email';
  static const emailSubtitle = 'emailSubtitle';
  static const phoneTitle = 'phoneTitle';
  static const phoneNumberSubtitle = 'phoneNumberSubtitle';
  static const password = 'password';
  static const passwordSubtitle = 'passwordSubtitle';
  static const change = 'change';
  static const changePasswordTitle = 'changePasswordTitle';
  static const changePasswordCurrentPasswordText =
      'changePasswordCurrentPasswordText';
  static const changePasswordNewPasswordText = 'changePasswordNewPasswordText';
  static const changePasswordOldPasswordHint = 'changePasswordOldPasswordHint';
  static const changePasswordNewPasswordHint = 'changePasswordNewPasswordHint';
  static const changePasswordConfirmPasswordHint =
      'changePasswordConfirmPasswordHint';
  static const changeOldPasswordRequired = 'changeOldPasswordRequired';
  static const oldPasswordAndNewMatchError = 'oldPasswordAndNewMatchError';
  static const confirmPasswordTitle = 'confirmPasswordTitle';
  static const confirmPasswordNotMatchError = 'confirmPasswordNotMatchError';
  static const changePasswordSuccessMessage = 'changePasswordSuccessMessage';
  static const invalidCurrentPasswordError = 'invalidCurrentPasswordError';
  static const notificationsSubtitle = 'notificationsSubtitle';
  static const browserNotifications = 'browserNotifications';
  static const browserNotificationsSubtitle = 'browserNotificationsSubtitle';
  static const soundAlerts = 'soundAlerts';
  static const soundAlertsSubtitle = 'soundAlertsSubtitle';
  static const activeModulesTitle = 'activeModulesTitle';
  static const activeModulesDescription = 'activeModulesDescription';
  static const reportsModuleTitle = 'reportsModuleTitle';
  static const reportsModuleSubtitle = 'reportsModuleSubtitle';
  static const analyticsModuleTitle = 'analyticsModuleTitle';
  static const analyticsModuleSubtitle = 'analyticsModuleSubtitle';
  static const general = 'general';
  static const interfaceTheme = 'interfaceTheme';
  static const themeSubtitle = 'themeSubtitle';
  static const languageSubtitle = 'languageSubtitle';
  static const system = 'system';
  static const failedToUpdateTheme = 'failedToUpdateTheme';
  static const contactSupport = 'contactSupport';

  static const lightTheme = 'lightTheme';
  static const darkTheme = 'darkTheme';
  static const lightThemeShortLabel = 'lightThemeShortLabel';
  static const darkThemeShortLabel = 'darkThemeShortLabel';
  static const continueSetupLabel = 'continueSetupLabel';

  static const logout = 'logout';
  static const logoutDialogTitle = 'logoutDialogTitle';
  static const logoutDialogMessage = 'logoutDialogMessage';
  static const sessionExpiredTitle = 'sessionExpiredTitle';
  static const sessionExpiredMessage = 'sessionExpiredMessage';
  static const goBack = 'goBack';
  static const na = 'na';

  static const phoneNumberLabel = 'phoneNumberLabel';

  static const phoneNumberHint = 'phoneNumberHint';

  static const validNumberErrMsg = 'validNumberErrMsg';

  static const loginSubtitle = 'loginSubtitle';

  static const verifyPhoneTitle = 'verifyPhoneTitle';

  static const verifyPhoneValidOtpError = 'verifyPhoneValidOtpError';

  static const verifyPhoneBtnText = 'verifyPhoneBtnText';

  static const verifyPhoneSubtitle = 'verifyPhoneSubtitle';

  static const verifyPhoneCodeNotReceived = 'verifyPhoneCodeNotRecived';

  static const resendCode = 'resendCode';

  static const mobileNumberRequiredErrMsg = 'mobileNumberRequiredErrMsg';

  static const dashboard = 'dashboard';
  static const validNumberMinLength = 'validNumberMinLength';

  static const noInternetConnectionBannerMsg = 'noInternetConnectionBannerMsg';
  static const internetConnectionRestoredBannerMsg =
      'internetConnectionRestoredBannerMsg';
  static const noInternetConnectionDismissBannerMsg =
      'noInternetConnectionDismissBannerMsg';
  static const refresh = 'refresh';

  static const confirm = 'confirm';

  static const gradientTheme = 'gradientTheme';

  static const bluePurpleGradientTheme = 'bluePurpleGradientTheme';

  static const userCanceledLoginErrorMessage = 'userCanceledLoginErrorMessage';
  static const browserNotAvailableErrorMessage =
      'browserNotAvailableErrorMessage';
  static const pkceNotAvailableErrorMessage = 'pkceNotAvailableErrorMessage';
  static const invalidAuthorizeUrlErrorMessage =
      'invalidAuthorizeUrlErrorMessage';
  static const invalidConfigurationErrorMessage =
      'invalidConfigurationErrorMessage';
  static const mfaRequiredErrorMessage = 'mfaRequiredErrorMessage';
  static const mfaRegistrationRequiredErrorMessage =
      'mfaRegistrationRequiredErrorMessage';
  static const requiresVerificationErrorMessage =
      'requiresVerificationErrorMessage';
  static const passwordLeakedErrorMessage = 'passwordLeakedErrorMessage';
  static const ruleError = 'ruleError';
  static const accessDeniedErrorMessage = 'accessDeniedErrorMessage';
  static const loginRequiredErrorMessage = 'loginRequiredErrorMessage';
  static const tooManyAttemptsErrorMessage = 'tooManyAttemptsErrorMessage';

  static const loadingStatusLoading = 'loadingStatusLoading';
  static const loadingStatusLogin = 'loadingStatusLogin';
  static const loadingStatusRegister = 'loadingStatusRegister';
  static const loadingStatusLogout = 'loadingStatusLogout';
  static const loadingStatusNone = 'loadingStatusNone';
  static const readMore = 'readMore';
  static const readLess = 'readLess';

  static const phoneNumberCopiedToClipboard = 'phoneNumberCopiedToClipboard';
  static const contactUsVia = 'contactUsVia';
  static const cancel = 'cancel';
  static const all = 'all';
  static const daysText = 'daysText';
  static const hourText = 'hourText';
  static const minText = 'minText';
  static const secondText = 'secondText';
  static const km = 'km';
  static const chooseLanguage = 'chooseLanguage';
  static const continueText = 'continueText';
  static const searchHint = 'searchHint';
  static const clear = 'clear';
  static const quickActions = 'quickActions';
  static const appVersion = 'appVersion';
  static const nameLabel = 'nameLabel';
  static const descriptionLabel = 'descriptionLabel';
  static const search = 'search';
  static const showing = 'showing';
  static const of = 'of';
  static const page = 'page';
  static const rowsPerPage = 'rowsPerPage';
  static const viewDetails = 'viewDetails';
  static const edit = 'edit';
  static const delete = 'delete';
  static const save = 'save';
  static const subscription = 'subscription';
  static const subscriptionSubtitle = 'subscriptionSubtitle';
  static const expiryDate = 'expiryDate';
  static const expired = 'expired';
  static const active = 'active';
  static const privilegesTitle = 'privilegesTitle';
  static const standardPlan = 'standardPlan';
  static const expirationDateError = 'expirationDateError';
  static const noExpiryDateText = 'noExpiryDateText';
  static const subscriptionExpiredAtText = 'subscriptionExpiredAtText';
  static const subscriptionValidUntilText = 'subscriptionValidUntilText';
  static const previous = 'previous';
  static const shareReportText = 'shareReportText';
  static const setAsTemplate = 'setAsTemplate';
  static const forgetPasswordText = 'forgetPasswordText';
  static const forgetPasswordSubtitle = 'forgetPasswordSubtitle';
  static const forgetPasswordSuccessMessage = 'forgetPasswordSuccessMessage';
  static const submit = 'submit';
  static const invalidEmailAddress = 'invalidEmailAddress';
  static const invalidOtpCodeError = 'invalidOtpCodeError';
  static const invalidToken = 'invalidToken';
  static const passwordOtpTitle = 'passwordOtpTitle';
  static const passwordOtpSubtitle = 'passwordOtpSubtitle';
  static const passwordOtpVerify = 'passwordOtpVerify';
  static const passwordOtpResendCode = 'passwordOtpResendCode';
  static const passwordOtpResendCodeSuccess = 'passwordOtpResendCodeSuccess';
  static const passwordOtpCodeNotReceived = 'passwordOtpCodeNotReceived';
  static const passwordOtpExpiredMessage = 'passwordOtpExpiredMessage';
  static const remainingOtpCodeTimeValidMessage =
      'remainingOtpCodeTimeValidMessage';
  static const resetPasswordTitle = 'resetPasswordTitle';
  static const resetPasswordSubtitle = 'resetPasswordSubtitle';
  static const resetPasswordButtonText = 'resetPasswordButtonText';
  static const resetPasswordSuccessMessage = 'resetPasswordSuccessMessage';
  static const signInLabel = 'signInLabel';
  static const helpSupport = 'helpSupport';
  static const support = 'support';
  static const installMobileApp = 'installMobileApp';
  static const viewWebDashboard = 'viewWebDashboard';
  static const ios = 'ios';
  static const android = 'android';
  static const appStore = 'appStore';
  static const googlePlayStore = 'googlePlayStore';
  static const whatsappContactMsg = 'whatsappContactMsg';
  static const whatsappNotFoundMsg = 'whatsappNotFoundMsg';
}
