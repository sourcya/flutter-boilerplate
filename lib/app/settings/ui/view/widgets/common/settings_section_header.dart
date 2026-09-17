part of '../../../imports/settings_imports.dart';

class SettingsSectionHeader extends StatelessWidget {
  final String title;
  const SettingsSectionHeader({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: context.paddingOnly(start: 16, end: 16, bottom: 8),
      child: CustomText(
        title,
        color: context.colors.mutedForeground,
        fontWeight: FontWeight.w400,
        fontSize: 14.sp,
        height: 1.43,
      ),
    );
  }
}
