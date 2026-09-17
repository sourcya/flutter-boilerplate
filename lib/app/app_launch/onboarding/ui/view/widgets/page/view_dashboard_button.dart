part of '../../../imports/onboarding_imports.dart';

class ViewDashboardButton extends StatelessWidget {
  final String? url;

  const ViewDashboardButton({
    super.key,
    this.url,
  });

  @override
  Widget build(BuildContext context) {
    final hasUrl = url != null && url!.isNotEmpty;

    return ActionButton.outlined(
      title: AppTrans.viewWebDashboard.tr(context: context),
      onPressed: hasUrl ? () => launchUrlString(url!) : () {},
      backgroundColor: context.colors.cardColor,
      disabledBackgroundColor: context.colors.cardColor,
      foregroundColor: context.colors.primary,
      borderColor: context.colors.primaryOutlineBorder,
      borderRadius: 12.radius,
      padding: context.paddingSymmetric(horizontal: 8, vertical: 6),
      constraints: BoxConstraints(minWidth: 64.r),
      textStyle: context.labelLargeTS.copyWith(
        color: context.colors.primary,
        fontSize: 14.sp,
        fontWeight: FontWeight.w600,
        height: 1.71,
      ),
    );
  }
}
