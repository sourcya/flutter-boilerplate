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
      child: const SizedBox.expand(),
    );
  }
}
