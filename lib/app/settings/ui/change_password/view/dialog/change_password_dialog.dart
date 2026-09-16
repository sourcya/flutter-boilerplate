part of '../../imports/change_password_imports.dart';

void showChangePasswordDialog(BuildContext context) {
  if (Get.isRegistered<ChangePasswordController>()) {
    Get.delete<ChangePasswordController>(force: true);
  }
  final controller = Get.put(ChangePasswordController());

  if (context.isAppPortrait && AppUtils.isMobile()) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.transparent,
      builder: (_) => ChangePasswordBottomSheet(controller: controller),
    ).whenComplete(() {
      if (Get.isRegistered<ChangePasswordController>()) {
        Get.delete<ChangePasswordController>();
      }
    });
    return;
  }

  showDialog<void>(
    context: context,
    barrierColor: context.colors.modalBarrier,
    builder: (_) => ChangePasswordDialog(controller: controller),
  ).whenComplete(() {
    if (Get.isRegistered<ChangePasswordController>()) {
      Get.delete<ChangePasswordController>();
    }
  });
}

class ChangePasswordDialog extends StatelessWidget {
  final ChangePasswordController controller;

  const ChangePasswordDialog({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppColors.transparent,
      insetPadding: context
          .paddingSymmetric(horizontal: 16.0, vertical: 24.0)
          .resolve(Directionality.of(context)),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minWidth: 320.0.r,
          maxWidth: 696.0.r,
        ),
        child: Container(
          clipBehavior: Clip.antiAlias,
          decoration: ShapeDecoration(
            color: context.colors.elevatedSurface,
            shape: RoundedRectangleBorder(
              side: BorderSide(
                color: context.colors.cardBorderColor,
              ),
              borderRadius: 16.0.radius,
            ),
            shadows: AppShadows.drawer(context),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const ChangePasswordHeaderWidget(isWideLayout: true),
              Flexible(
                child: SingleChildScrollView(
                  child: ChangePasswordContentWidget(
                    controller: controller,
                    isWideLayout: true,
                    padding: context.paddingOnly(
                      start: 24.0,
                      end: 24.0,
                      bottom: 24.0,
                    ),
                  ),
                ),
              ),
              ChangePasswordFooterWidget(
                controller: controller,
                isWideLayout: true,
                padding: context.paddingOnly(start: 24.0, end: 24.0, bottom: 24.0),
                height: 64.r,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ChangePasswordBottomSheet extends StatelessWidget {
  final ChangePasswordController controller;

  const ChangePasswordBottomSheet({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: context.paddingOnly(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Container(
        constraints: BoxConstraints(
          maxHeight: context.height * 0.85,
        ),
        decoration: BoxDecoration(
          color: context.colors.elevatedSurface,
          borderRadius: BorderRadius.only(
            topLeft: 24.0.radiusCircular,
            topRight: 24.0.radiusCircular,
          ),
          boxShadow: AppShadows.bottomSheet(context),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const ChangePasswordDragHandleWidget(),
            Flexible(
              child: SingleChildScrollView(
                child: Padding(
                  padding: context.paddingSymmetric(
                    horizontal: 16.0,
                    vertical: 12.0,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const ChangePasswordHeaderWidget(isBottomSheet: true),
                      24.hBox,
                      ChangePasswordContentWidget(
                        controller: controller,
                        isWideLayout: true,
                        padding: context.paddingZero(),
                      ),
                      24.hBox,
                      ChangePasswordFooterWidget(
                        controller: controller,
                        isWideLayout: true,
                        padding: context.paddingZero(),
                        alignEnd: true,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            context.mediaQueryPadding.bottom.hBox,
          ],
        ),
      ),
    );
  }
}
