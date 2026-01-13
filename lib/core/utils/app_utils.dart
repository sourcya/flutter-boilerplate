//utils that will be used in the app
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/core/config/constant.dart';
import 'package:flutter_boilerplate/core/navigation/navigation.dart';
import 'package:flutter_boilerplate/core/preferences/preference_manger.dart';
import 'package:flutter_boilerplate/core/ui/ui.dart';
import 'package:playx/playx.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

/// Class for app utilities that will be used in the app.
class AppUtils {
  AppUtils._();

  /// validates text field forms state and apply it to an RxBool
  static void validate(GlobalKey<FormState> key, RxBool validatorListener) {
    final formState = key.currentState;
    final isValid = formState != null && formState.validate();
    validatorListener.value = isValid;
  }

  static bool isMobile() {
    final double width = ScreenUtil().screenWidth;
    final double height = ScreenUtil().screenHeight;
    final shortestSide = min(width.abs(), height.abs());
    return shortestSide < 600;
  }

  double _degreesToRadians(double degrees) {
    return degrees * pi / 180;
  }

  String? getFormattedDuration({
    Duration? duration,
    required BuildContext context,
    bool showSeconds = true,
  }) {
    if (duration == null) {
      return null;
    }

    final days = duration.inDays;
    final hours = duration.inHours.remainder(24);

    final space = spaceOnArabicText;
    final daysText = days == 0
        ? ''
        : "${twoDigits(days).toLocalizedArabicOrEnglishNumber()}$space${AppTrans.daysText.tr(context: context)} : ";
    final hoursText = days == 0 && hours == 0
        ? ''
        : "${twoDigits(hours).toLocalizedArabicOrEnglishNumber()}$space${AppTrans.hourText.tr(context: context)} : ";

    final minValue = duration.inMinutes.remainder(60);
    final String minText =
        "${twoDigits(minValue).toLocalizedArabicOrEnglishNumber()}$space${AppTrans.minText.tr(context: context)} ";
    final String secText =
        "${twoDigits(duration.inSeconds.remainder(60)).toLocalizedArabicOrEnglishNumber()}$space${AppTrans.secondText.tr(context: context)}";

    if (showSeconds) {
      return "$daysText$hoursText$minText: $secText";
    }
    return "$daysText$hoursText$minText";
  }

  String get spaceOnArabicText =>
      PlayxLocalization.isCurrentLocaleArabic() ? ' ' : '';

  String? getFormattedDurationForSeconds({
    num? seconds,
    required BuildContext context,
  }) {
    if (seconds == null) {
      return null;
    }
    final duration = Duration(seconds: seconds.toInt());

    return getFormattedDuration(duration: duration, context: context);
  }

  bool isDarkMode() => PlayxTheme.id == DarkTheme.darkThemeId;

  /// validates text field forms state and apply it to an RxBool
  void validateTextField(GlobalKey<FormState> key, RxBool validatorListener) {
    final formState = key.currentState;
    final isValid = formState != null && formState.validate();

    validatorListener.value = isValid;
  }
}

Future<bool> launchPhoneNumber({required String number}) async {
  if (kIsWeb) return false;
  final uri = Uri(scheme: 'tel', path: number);
  final canLaunch = await canLaunchUrl(uri);

  if (!canLaunch) return false;

  try {
    await launchUrl(uri);
    return true;
  } catch (_) {
    return false;
  }
}

Future<ShareResult> shareMessage({
  required String message,
  required BuildContext context,
}) {
  return SharePlus.instance.share(ShareParams(text: message));
}

Future<ShareResult> shareFiles({
  required List<XFile> files,
  String? text,
  required BuildContext context,
}) {
  return SharePlus.instance.share(
    ShareParams(
      files: files,
      title: text,
      sharePositionOrigin: Rect.fromLTWH(
        0,
        0,
        MediaQuery.of(context).size.width,
        MediaQuery.of(context).size.height / 2,
      ),
    ),
  );
}

Future<void> contactSupportViaWhatsapp({BuildContext? context}) async {
  final dialogContext = context ?? NavigationUtils.navigationContext;
  if (dialogContext == null) return;
  final user = await MyPreferenceManger.instance.getSavedUser();
  final PackageInfo packageInfo = await PackageInfo.fromPlatform();

  final version = packageInfo.version;

  final email = user?.email ?? '';
  final emailText = email.isNotEmpty ? email : AppTrans.notLoggedIn.tr();
  final text = AppTrans.whatsappContactMsg.tr().format([emailText, version]);

  final androidUrl =
      "whatsapp://send?phone=${Constants.whatsappNumber}&text=$text";
  final iosUrl = "https://wa.me/${Constants.whatsappNumber}?text=$text";

  try {
    if (PlayxPlatform.isIOS) {
      await launchUrl(Uri.parse(iosUrl));
    } else {
      await launchUrl(Uri.parse(androidUrl));
    }
    // ignore: avoid_catches_without_on_clauses
  } catch (_) {
    if (dialogContext.mounted) {
      showAdaptiveDialog(
        context: dialogContext,
        builder: (context) {
          return AlertDialog.adaptive(
            title: const CustomText(AppTrans.appName),
            content: CustomText(
              AppTrans.whatsappNotFoundMsg.tr(),
              fontSize: 14.sp,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.r),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const CustomText(AppTrans.cancel),
              ),
            ],
          );
        },
      );
    }
  }
}

extension StringExtensions on String {
  String toLocalizedArabicOrEnglishNumber() {
    return toDoubleOr(this).toLocalizedArabicOrEnglishNumber();
  }
}
