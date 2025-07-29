part of '../../ui.dart';

class CustomScaffold extends StatelessWidget {
  final Widget child;
  final String? title;
  final Widget? titleWidget;
  final double? titleSpacing;
  final EdgeInsetsGeometry? padding;
  final PlatformAppBar? appBar;
  final Widget? floatingActionButton;
  final List<Widget>? actions;
  final AppBarLeadingType leading;
  final Widget? leadingWidget;
  final bool useSafeArea;
  final bool includeIosBottomSafeArea;
  final bool includeAppBar;
  final Color? backgroundColor;
  final bool includeLoadingOverlay;

  const CustomScaffold({
    required this.child,
    this.title,
    this.titleWidget,
    this.padding,
    this.appBar,
    this.floatingActionButton,
    this.leading = AppBarLeadingType.drawer,
    this.leadingWidget,
    this.actions,
    this.useSafeArea = true,
    this.includeAppBar = true,
    this.includeIosBottomSafeArea = false,
    this.backgroundColor,
    this.titleSpacing,
    this.includeLoadingOverlay = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final scaffoldChild = Stack(
      children: [
        Container(
          padding: padding,
          alignment: Alignment.center,
          child: GetPlatform.isIOS
              ? Scaffold(
                  floatingActionButton: floatingActionButton,
                  body: child,
                )
              : child,
        ),
        if (includeLoadingOverlay)
          Obx(
            () => LoadingOverlay(
              loadingStatus: AppController.instance.loadingStatus.value,
            ),
          ),
      ],
    );

    final scaffold = PlatformScaffold(
      appBar: includeAppBar
          ? appBar ??
              buildAppBar(
                title: title ?? AppTrans.appName,
                titleWidget: titleWidget,
                context: context,
                leading: leading,
                leadingWidget: leadingWidget,
                actions: actions,
                titleSpacing: titleSpacing,
              )
          : null,
      body: useSafeArea
          ? SafeArea(
              bottom: includeIosBottomSafeArea,
              right: context.isPortrait,
              child: scaffoldChild,
            )
          : scaffoldChild,
      material: (context, platform) => MaterialScaffoldData(
        floatingActionButton: floatingActionButton,
      ),
      cupertino: (ctx, p) => CupertinoPageScaffoldData(),
      backgroundColor: backgroundColor ?? context.colors.surface,
    );

    return scaffold;
  }
}
