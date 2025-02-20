part of '../../ui.dart';

class CustomScaffold extends StatelessWidget {
  final Widget child;
  final String? title;
  final EdgeInsetsGeometry? padding;
  final PlatformAppBar? appBar;
  final Widget? floatingActionButton;
  final AppBarLeadingType leading;
  final bool useSafeArea;
  final bool includeThemeSwitchingArea;

  const CustomScaffold({
    required this.child,
    this.title,
    this.padding,
    this.appBar,
    this.floatingActionButton,
    this.leading = AppBarLeadingType.none,
    this.useSafeArea = true,
    this.includeThemeSwitchingArea = true,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final scaffoldChild = Container(
      padding: padding,
      alignment: Alignment.center,
      child: GetPlatform.isIOS
          ? Scaffold(
              floatingActionButton: floatingActionButton,
              body: child,
            )
          : child,
    );

    final scaffold = PlatformScaffold(
      appBar: appBar ??
          buildAppBar(
            title: title ?? AppTrans.appName,
            context: context,
            leading: leading,
          ),
      body: useSafeArea ? SafeArea(child: scaffoldChild) : scaffoldChild,
      backgroundColor: context.colors.surface,
    );

    return includeThemeSwitchingArea
        ? PlayxThemeSwitchingArea(
            child: scaffold,
          )
        : scaffold;
  }
}
