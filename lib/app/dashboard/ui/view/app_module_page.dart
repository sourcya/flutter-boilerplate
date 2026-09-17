part of '../imports/dashboard_imports.dart';

class AppModulePage extends StatelessWidget {
  const AppModulePage({required this.title, super.key});

  final String title;

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      title: title,
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
