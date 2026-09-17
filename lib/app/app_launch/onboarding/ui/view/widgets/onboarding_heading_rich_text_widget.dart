import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/app/app_launch/onboarding/data/model/onboarding.dart';
import 'package:flutter_boilerplate/core/ui/ui.dart';
import 'package:playx/playx.dart';

class OnboardingHeadingRichTextWidget extends StatelessWidget {
  final OnboardingTitleParts parts;
  final TextAlign textAlign;
  final double fontSize;
  final double? height;
  final double? letterSpacing;

  const OnboardingHeadingRichTextWidget({
    super.key,
    required this.parts,
    this.textAlign = TextAlign.start,
    this.fontSize = 30,
    this.height,
    this.letterSpacing,
  });

  @override
  Widget build(BuildContext context) {
    final hasSplit =
        (parts.prefixKey?.isNotEmpty ?? false) || (parts.trailingKey?.isNotEmpty ?? false);

    if (!hasSplit) {
      return CustomText(
        parts.accentKey,
        fontSize: fontSize.sp,
        fontWeight: FontWeight.w600,
        height: height ?? 1.20,
        letterSpacing: letterSpacing ?? -0.75,
        color: context.colors.foreground,
        textAlign: textAlign,
        firstWordColor: context.colors.secondary,
      );
    }

    final foregroundStyle = context.headlineMediumTS.copyWith(
      fontSize: fontSize.sp,
      fontWeight: FontWeight.w600,
      height: height ?? 1.20,
      letterSpacing: letterSpacing ?? -0.75,
      color: context.colors.foreground,
    );
    final accentStyleBase = TextStyle(
      color: context.colors.secondary,
      fontWeight: FontWeight.w600,
    );
    final accentStyle = foregroundStyle.merge(accentStyleBase);

    return RichText(
      textAlign: textAlign,
      text: TextSpan(
        style: foregroundStyle,
        children: [
          if (parts.prefixKey?.isNotEmpty ?? false)
            TextSpan(
              text: parts.prefixKey!.tr(context: context),
            ),
          TextSpan(
            text: parts.accentKey.tr(context: context),
            style: accentStyle,
          ),
          if (parts.trailingKey?.isNotEmpty ?? false)
            TextSpan(
              text: parts.trailingKey!.tr(context: context),
            ),
        ],
      ),
    );
  }
}
