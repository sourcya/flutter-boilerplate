part of '../../../imports/change_password_imports.dart';

class ChangePasswordHeaderWidget extends StatelessWidget {
  const ChangePasswordHeaderWidget({
    super.key,
    this.padding,
    this.isWideLayout = false,
    this.isBottomSheet = false,
  });

  final EdgeInsetsGeometry? padding;
  final bool isWideLayout;
  final bool isBottomSheet;

  @override
  Widget build(BuildContext context) {
    final titleStyle = isBottomSheet
        ? context.displayMediumTS.copyWith(
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
            height: 1.0,
            letterSpacing: -0.45,
            color: context.colors.cardForeground,
          )
        : context.displayMediumTS.copyWith(
            fontSize: 24.sp,
            fontWeight: FontWeight.w600,
            height: 1.0,
            letterSpacing: -0.6,
            color: context.colors.cardForeground,
          );

    final prefixWidget = Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 24.r,
          height: 24.r,
          padding: context.paddingAll(6),
          decoration: ShapeDecoration(
            color: context.colors.primary,
            shape: RoundedRectangleBorder(
              borderRadius: 6.0.radius,
            ),
          ),
          child: IconInfo.svg(
            Assets.icons.icEdit,
            size: 12.r,
            color: context.colors.primaryActionText,
          ).buildIconWidget(),
        ),
        8.wBox,
        Expanded(
          child: CustomText(
            AppTrans.changePasswordTitle,
            textStyle: titleStyle,
          ),
        ),
      ],
    );

    if (isBottomSheet) {
      return Row(
        children: [
          Expanded(child: prefixWidget),
          _ChangePasswordCloseButton(
            onTap: () => Navigator.of(context).pop(),
          ),
        ],
      );
    }

    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: context.paddingAll(24),
            child: prefixWidget,
          ),
        ),
        Padding(
          padding: context.paddingSymmetric(horizontal: 24),
          child: _ChangePasswordCloseButton(
            onTap: () => Navigator.of(context).pop(),
          ),
        ),
      ],
    );
  }
}

class _ChangePasswordCloseButton extends StatelessWidget {
  const _ChangePasswordCloseButton({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: AppTrans.cancel.tr(context: context),
      child: Material(
        color: AppColors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: 8.0.radius,
          child: Container(
            width: 32.r,
            height: 32.r,
            decoration: ShapeDecoration(
              color: context.colors.screenCardSurface,
              shape: RoundedRectangleBorder(
                side: BorderSide(color: AppColors.primaryPalette.primary200),
                borderRadius: 8.0.radius,
              ),
            ),
            alignment: Alignment.center,
            child: IconInfo.icon(
              Icons.close,
              size: 16.r,
              color: context.colors.cardForeground,
            ).buildIconWidget(),
          ),
        ),
      ),
    );
  }
}
