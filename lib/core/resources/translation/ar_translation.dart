import 'app_translations.dart';

class ArabicTranslations extends BaseTranslation {



  @override
  Map<String, String> get translations => {
        AppTrans.appName: "تطبيق",

        //Network Errors
        AppTrans.requestCancelled:"عذرا ، تم إلغاء الطلب.",
        AppTrans.unauthorizedRequest: "عذرا ، الطلب غير مصرح به.",
        AppTrans.badRequest: "عذرًا ، الطلب غير صالح أو تم صياغته بشكل غير صحيح.",
        AppTrans.notFound: "عذرًا ، تعذر العثور على المورد المطلوب.",
        AppTrans.notAcceptable:"عذرا ، الطلب غير مقبول.",
        AppTrans.requestTimeout:  "عذرا ، لقد انقضت مهلة الطلب.",
        AppTrans.sendTimeout: "عذرا ، لقد انقضت مهلة الطلب.",
        AppTrans.unProcessableEntity: "عذراً، لم نستطع معالجة البيانات.",
        AppTrans.conflict: "عذرًا ، لم يكتمل الطلب بسبب وجود تعارض.",
        AppTrans.internalServerError:
            "عذرا ، هناك مشكلة في الخادم.",
        AppTrans.serviceUnavailable:
            "عذراً، الخدمة غير متوفرة حالياً",
        AppTrans.noInternetConnection:
            ".عذراً ، لايوجد إتصال بالإنترنت، يرجي إعادة المحاولة لاحقاً",
        AppTrans.formatException: "عذرًا ، الطلب لم يتم تنسيقه بشكل صحيح.",
        AppTrans.unableToProcess:  "عذرا ، لا يمكن معالجة البيانات.",
        AppTrans.defaultError: "عذراً، لقد حدث خطأ ما .",
        AppTrans.unexpectedError: "عذرا، لقد حدث خطأ ما.",
        AppTrans.emptyResponse: "عذرا ،لم نتكن من تلقي استجابة من الخادم.",

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
        AppTrans.retryText: "أعد المحاولة",
        AppTrans.updateTitle: 'هناك تحديث جديد متوفر.',
        AppTrans.updateDescription: 'هنالك نسخة جديدة من التطبيق متوفرة الان\n'
            'حدث التطبيق لتستمتع بأخر المميزات الجديدة الان',

        AppTrans.updateReleaseNotesTitle: 'أخر التحديثات :',
        AppTrans.updateConfirmActionTitle: 'تحديث',
        AppTrans.updateDismissActionTitle: 'لاحقاً',
      };
}
