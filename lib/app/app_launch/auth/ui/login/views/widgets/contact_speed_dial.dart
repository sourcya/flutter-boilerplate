part of '../../imports/login_imports.dart';

class ContactSpeedDial extends GetView<LoginController> {
  const ContactSpeedDial({super.key});

  @override
  Widget build(BuildContext context) {
    final isRtl = PlayxLocalization.isCurrentLocaleRtl();
    final dialWidth = min(
      max(context.width * 0.62, 260.r),
      context.width - 32.r - 56.r,
    );
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        boxShadow: AppShadows.surfaceShadow(context.colors.cardShadowColor),
      ),
      clipBehavior: Clip.antiAlias,
      child: SpeedDial(
        shape: const CircleBorder(),
        elevation: 0,
        buttonSize: Size(56.r, 56.r),
        switchLabelPosition: isRtl,
        activeChild: IconInfo.icon(
          Icons.close,
          size: 24.r,
          color: context.colors.onPrimary,
        ).buildIconWidget(),
        spacing: 10,
        spaceBetweenChildren: 8,
        backgroundColor: context.colors.primary,
        foregroundColor: context.colors.onPrimary,
        overlayColor: context.colors.overlayBackground,
        overlayOpacity: 0.7,
        children: [
          SpeedDialChild(
            labelWidget: _ContactDialLabel(
              width: dialWidth,
              icon: Assets.icons.icCall,
              title: Constants.telephoneNumber,
            ),
            onTap: () => controller.onTelephoneContact(context: context),
          ),
          SpeedDialChild(
            labelWidget: _ContactDialLabel(
              width: dialWidth,
              icon: Assets.icons.icPhone,
              title: Constants.phoneNumber,
            ),
            onTap: () => controller.onPhoneContact(context: context),
          ),
          SpeedDialChild(
            labelWidget: _ContactDialLabel(
              width: dialWidth,
              icon: Assets.icons.icSupport,
              title: Constants.contactWhatsappNumber,
            ),
            onTap: () => controller.onWhatsappContact(context: context),
          ),
        ],
        child: IconInfo.svg(
          Assets.icons.icInfo,
          size: 20.r,
          color: context.colors.onPrimary,
        ).buildIconWidget(),
      ),
    );
  }
}

class _ContactDialLabel extends StatelessWidget {
  final double width;
  final String icon;
  final String title;

  const _ContactDialLabel({
    required this.width,
    required this.icon,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      padding: context.paddingSymmetric(horizontal: 16, vertical: 16),
      decoration: BoxDecoration(
        color: context.colors.surfaceContainer,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        children: [
          IconInfo.svg(
            icon,
            size: 24.r,
            color: context.colors.onSurface,
          ).buildIconWidget(),
          8.wBox,
          Flexible(
            child: CustomText(
              title,
              isTranslatable: false,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textStyle: context.bodyMediumTS.copyWith(
                fontWeight: FontWeight.w500,
                fontSize: 15.sp,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
