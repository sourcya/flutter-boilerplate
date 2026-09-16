import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/core/config/constant.dart';
import 'package:flutter_boilerplate/core/ui/ui.dart';
import 'package:playx/playx.dart';
import 'package:url_launcher/url_launcher.dart';

Future<bool> launchPhoneNumber({required String number}) async {
  if (kIsWeb) return false;
  final uri = Uri(scheme: 'tel', path: number.replaceAll(' ', ''));
  final canLaunch = await canLaunchUrl(uri);
  if (!canLaunch) return false;
  try {
    await launchUrl(uri);
    return true;
  } catch (_) {
    return false;
  }
}

Future<void> contactSupportViaWhatsapp({BuildContext? context}) async {
  final dialogContext = context;
  final text = AppTrans.whatsappContactMsg.tr();
  final androidUrl =
      'whatsapp://send?phone=${Constants.whatsappNumber}&text=$text';
  final iosUrl =
      'https://wa.me/${Constants.whatsappNumber}?text=${Uri.encodeComponent(text)}';
  final webUrl =
      'https://wa.me/${Constants.whatsappNumber}?text=${Uri.encodeComponent(text)}';

  try {
    final uri = Uri.parse(
      kIsWeb
          ? webUrl
          : PlayxPlatform.isIOS
              ? iosUrl
              : androidUrl,
    );
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  } catch (_) {
    if (dialogContext == null || !dialogContext.mounted) return;
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
              onPressed: () => Navigator.of(context).pop(),
              child: const CustomText(AppTrans.cancel),
            ),
          ],
        );
      },
    );
  }
}
