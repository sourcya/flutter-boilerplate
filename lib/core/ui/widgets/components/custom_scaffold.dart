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
  final bool includeBottomSafeArea;
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
    this.leading = AppBarLeadingType.none,
    this.leadingWidget,
    this.actions,
    this.useSafeArea = true,
    this.includeAppBar = true,
    this.includeBottomSafeArea = false,
    this.backgroundColor,
    this.titleSpacing,
    this.includeLoadingOverlay = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final scaffoldChild = Container(
      padding: padding,
      alignment: Alignment.center,
      child: PlayxPlatform.isIOS
          ? Scaffold(
              floatingActionButton: floatingActionButton,
              backgroundColor: context.colors.surface,
              body: child,
            )
          : child,
    );

    final scaffold = Stack(
      children: [
        PlatformScaffold(
          appBar: includeAppBar
              ? appBar ??
                  buildAppBar(
                    title: title,
                    titleWidget: titleWidget,
                    context: context,
                    leadingType: leading,
                    leadingWidget: leadingWidget,
                    actions: actions,
                    titleSpacing: 0,
                  )
              : null,
          body: useSafeArea
              ? SafeArea(
                  bottom: includeBottomSafeArea,
                  right: context.isPortrait,
                  child: scaffoldChild,
                )
              : scaffoldChild,
          material: (context, platform) => MaterialScaffoldData(
            floatingActionButton: floatingActionButton,
          ),
          cupertino: (ctx, p) => CupertinoPageScaffoldData(),
          backgroundColor: backgroundColor ?? context.colors.surface,
        ),
        if (includeLoadingOverlay)
          Obx(
            () => LoadingOverlay(
              loadingStatus: AppController.instance.loadingStatus.value,
            ),
          ),
      ],
    );

    return scaffold;
  }
}
