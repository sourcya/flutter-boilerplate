part of '../ui.dart';

/// Builds portrait vs landscape UI using [BuildContext.isAppLandscape].
abstract class CustomOrientationWidget extends StatelessWidget {
  final bool isInitialized;

  const CustomOrientationWidget({
    this.isInitialized = true,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final child = context.isAppLandscape
        ? buildLandscape(context)
        : buildPortrait(context);
    return buildWidget(context, child) ?? child;
  }

  Widget? buildWidget(BuildContext context, Widget child) => null;

  Widget buildPortrait(BuildContext context);

  Widget buildLandscape(BuildContext context);
}
