part of '../imports/dashboard_imports.dart';

class DashboardView extends GetView<DashboardController> {
  const DashboardView({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      title: AppTrans.dashboard,
      backgroundColor: context.isWideLayout
          ? context.colors.surface
          : context.colors.bgMuted50,
      bodyAlignment: Alignment.topCenter,
      isWideWeb: context.isWideLayout,
      showWhatsAppSupport: true,
      child: SingleChildScrollView(
        padding: context.paddingAll(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
              AppTrans.dashboardWelcomeTitle,
              fontSize: 22.sp,
              fontWeight: FontWeight.w700,
            ),
            8.hBox,
            CustomText(
              AppTrans.dashboardWelcomeSubtitle,
              color: context.colors.mutedForeground,
            ),
            16.hBox,
            CustomCard(
              child: Padding(
                padding: context.paddingAll(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      AppTrans.productsTitle,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                    ),
                    8.hBox,
                    CustomText(
                      AppTrans.productsSubtitle,
                      color: context.colors.mutedForeground,
                    ),
                    16.hBox,
                    const CustomElevatedButton(
                      label: AppTrans.viewProducts,
                      isMaxWidth: false,
                      onPressed: AppNavigation.navigateToProducts,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
