part of '../../imports/login_imports.dart';

class HelpSeparator extends GetView<LoginController> {
  const HelpSeparator({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        40.hBox,
        Divider(color: context.colors.mutedForeground, height: 1.r),
        40.hBox,
        Column(
          mainAxisSize: MainAxisSize.min,
          spacing: 16,
          children: [
            CustomText(
              AppTrans.helpSupport,
              textAlign: TextAlign.center,
              textStyle: context.bodyLargeTS.copyWith(
                color: context.colors.foreground,
                fontSize: 16.sp,
                height: 1.75,
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: _HelpContactButton(
                    title: Constants.telephoneNumber,
                    icon: Assets.icons.icCall,
                    onTap: () => controller.onTelephoneContact(context: context),
                  ),
                ),
                8.wBox,
                Expanded(
                  child: _HelpContactButton(
                    title: Constants.phoneNumber,
                    icon: Assets.icons.icPhone,
                    onTap: () => controller.onPhoneContact(context: context),
                  ),
                ),
                8.wBox,
                Expanded(
                  child: _HelpContactButton(
                    title: Constants.contactWhatsappNumber,
                    icon: Assets.icons.icSupport,
                    onTap: () =>
                        controller.onWhatsappContact(context: context),
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}

class _HelpContactButton extends StatelessWidget {
  final String title;
  final String icon;
  final VoidCallback onTap;

  const _HelpContactButton({
    required this.title,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ActionButton.outlined(
      title: title,
      onPressed: onTap,
      constraints: BoxConstraints.tightFor(height: 36.r),
      backgroundColor: context.colors.surface,
      foregroundColor: context.colors.foreground,
      borderColor: context.colors.inputBorderColor,
      borderRadius: 8.radius,
      padding: context.paddingSymmetric(horizontal: 8, vertical: 8),
      isIconPositionLeft: true,
      iconSpace: 4,
      icon: IconInfo.svg(
        icon,
        size: 16.r,
        color: icon == Assets.icons.icSupport ? null : context.colors.foreground,
      ).buildIconWidget(),
      textStyle: context.labelLargeTS.copyWith(
        color: context.colors.foreground,
        fontWeight: FontWeight.w600,
        height: 1.71,
      ),
      shadows: AppShadows.helpChipShadow,
    );
  }
}
