part of '../../imports/login_imports.dart';

class LoginPanelQrCardWidget extends StatelessWidget {
  final IconData icon;
  final String platform;
  final String store;
  final String qrUrl;

  const LoginPanelQrCardWidget({
    super.key,
    required this.icon,
    required this.platform,
    required this.store,
    required this.qrUrl,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => launchUrlString(qrUrl),
      behavior: HitTestBehavior.opaque,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 100.r,
            height: 100.r,
            decoration: ShapeDecoration(
              color: context.colors.cardBackgroundColor,
              shape: RoundedRectangleBorder(borderRadius: 16.radius),
              shadows: const [
                BoxShadow(color: Color(0x26000000), blurRadius: 6),
              ],
            ),
            child: Padding(
              padding: context.paddingAll(8),
              child: SizedBox(
                width: 84.r,
                height: 84.r,
                child: PrettyQrView.data(
                  data: qrUrl,
                  decoration: PrettyQrDecoration(
                    quietZone: PrettyQrQuietZone.standard,
                    shape: PrettyQrSmoothSymbol(
                      color: context.colors.onSurface,
                    ),
                  ),
                ),
              ),
            ),
          ),
          12.hBox,
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconInfo.icon(
                icon,
                size: 20.r,
                color: context.colors.foreground,
              ).buildIconWidget(),
              4.wBox,
              CustomText(
                platform,
                textAlign: TextAlign.center,
                textStyle: context.headlineMediumTS.copyWith(
                  color: context.colors.foreground,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  height: 1.50,
                ),
              ),
            ],
          ),
          4.hBox,
          CustomText(
            store,
            textAlign: TextAlign.center,
            textStyle: context.bodySmallTS.copyWith(
              color: context.colors.mutedForeground,
              fontSize: 12.sp,
              fontWeight: FontWeight.w400,
              height: 1.33,
            ),
          ),
        ],
      ),
    );
  }
}
