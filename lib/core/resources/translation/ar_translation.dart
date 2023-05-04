import 'app_translations.dart';

class ArabicTranslations extends BaseTranslation {
  @override
  Map<String, String> get translations => {
        AppTrans.appName: "تطبيق",

        //Network Errors
        AppTrans.requestCancelled: "تم إلغاء الطلب",
        AppTrans.unauthorizedRequest: "طلب غير مسموح به",
        AppTrans.badRequest: "طلب خطأ",
        AppTrans.notFound: "طلب غير موجود",
        AppTrans.methodNotAllowed: "طلب غير مسموح به",
        AppTrans.notAcceptable: "طلب غير مسموح به",
        AppTrans.requestTimeout:
            "عذراً ، تم قطع الإتصال يرجي إعادة المحاولة لاحقاً",
        AppTrans.sendTimeout:
            "عذراً ، تم قطع الإتصال يرجي إعادة المحاولة لاحقاً",
        AppTrans.unProcessableEntity: "عذراً، لم نستطع معالجة البيانات",
        AppTrans.conflict: "عذراً، حدث خطأ ما",
        AppTrans.internalServerError:
            " عذراً، حدث خطأ ما يرجي إعادة المحاولة لاحقاً",
        AppTrans.notImplemented: "عذراً، حدث خطأ ما",
        AppTrans.serviceUnavailable:
            "عذراً، حدث خطأ ما يرجي إعادة المحاولة لاحقاً",
        AppTrans.noInternetConnection:
            "عذراً ، لايوجد إنترنت يرجي إعادة المحاولة لاحقاًز",
        AppTrans.formatException: "عذراً، لم نستطع معالجة البيانات",
        AppTrans.unableToProcess: "عذراً، لم نستطع معالجة البيانات",
        AppTrans.defaultError: "عذراً، حدث خطأ ما يرجي إعادة المحاولة لاحقاً.",
        AppTrans.unexpectedError:
            "عذراً، حدث خطأ ما يرجي إعادة المحاولة لاحقاً.",
        AppTrans.emptyResponse:
            "عذراً، لم نستطع معالجة البيانات يرجي إعادة المحاولة لاحقاً.",

        //biometric auth
        AppTrans.bioLocalizedReason:
            'من فضلك ، قم بإتمام المصادقة البيومترية لتسجيل الدخول.',
        AppTrans.bioSignInTitle: 'المصادقة البيومترية مطلوبة!',
        AppTrans.bioCancelText: 'شكراً',
        AppTrans.bioCanAuthenticate: "لايمكن عمل مصادقة بيومترية",
        AppTrans.bioNotAvailableError: 'المصادقة البيومترية غير متوفرة',
        AppTrans.bioNotEnrolledError:
            'لم يتم إضافة اي مصادقة بيومترية  على هذا الجهاز',
        AppTrans.bioLockedOutError:
            'تم وقف المصادقة البيومترية لكثرة المحاولات',
        AppTrans.bioDefaultError: 'عذراً حدث خطأ ما',
        AppTrans.bioPasscodeNotSetError:
            "لم تقم باضافة باسورد لهاتفك بعد، قم بإضافة الباسورد لتستطيع استخدام التطبيق",

        //app
        AppTrans.emailHint: "أدخل الإيميل أو إسم المستخدم",
        AppTrans.passwordHint: "أدخل كلمة المرور",
        AppTrans.usernameHint: "أدخل إسم المستخدم",

        AppTrans.loginText: "تسجيل الدخول",
        AppTrans.registerText: "النسجيل",

        AppTrans.emailRequired: "يتوجب عليك إدخال الإيميل",
        AppTrans.passwordRequired: "يتوجب عليك إدخال كلمة المرور",
        AppTrans.usernameRequired: "يتوجب عليك إدخال إسم المستخدم",

        AppTrans.emailOrUsernameLabel: "الإيميل أو إسم المستخدم",
        AppTrans.emailLabel: "الإيميل",
        AppTrans.usernameLabel: "إسم المستخدم",
        AppTrans.passwordLabel: "كلمة المرور",

        AppTrans.dontHaveAccountText: "ليس لديك حساب؟ ",
        AppTrans.registerNow: " قم بإنشاء حساب الان!",

        AppTrans.haveAccountText: "هل لديك حساب؟",
        AppTrans.loginNow: " سجل الدخول الان!",

        AppTrans.notEmailError: "من فضلك إدخل إيميل صحيح.",

        AppTrans.confirmPasswordLabel: "تأكيد كلمة المرور",
        AppTrans.confirmPasswordHint: "أدخل كلمة المرور ثانية.",

        AppTrans.passwordMinLengthError:
            "كلمة المرور يجب أن تكون أكثر من 6 حروف.",
        AppTrans.confirmPasswordRequiredError:
            "يتوجب عليك إدخال كلمة المرور ثانية.",
        AppTrans.confirmPasswordMatchError: "كلمتي المرور غير متوافقتان.",

        AppTrans.termsAndPrivacyInitialText: "بإنشاء حساب فأنت توافق على ",
        AppTrans.terms: "شروط الإستخام ",
        AppTrans.andText: " و ",

        AppTrans.privacyPolicyText: "سياسة الخصوصية.",
        AppTrans.noDataMessage: "لا توجد بيانات متاحة.",
        AppTrans.noInternetMessage: "لا يوجد إنترنت.",
        AppTrans.retryText: "أعد المحاولة"
      };
}
