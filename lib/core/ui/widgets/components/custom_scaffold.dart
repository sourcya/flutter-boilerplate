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

  final FloatingActionButtonLocation? floatingActionButtonLocation;
  final List<BreadcrumbItem>? breadcrumbs;
  final bool? attachBreadcrumb;
  final bool addPopScope;
  final bool? showWhatsAppSupport;

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
    this.includeBottomSafeArea = false,
    this.backgroundColor,
    this.titleSpacing,
    this.floatingActionButtonLocation,
    this.breadcrumbs,
    this.attachBreadcrumb,
    this.addPopScope = false,
    this.showWhatsAppSupport,
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
              floatingActionButtonLocation: floatingActionButtonLocation,
              body: child,
            )
          : Scaffold(
              // floatingActionButton: floatingActionButton,
              // floatingActionButtonLocation: floatingActionButtonLocation,
              body: child,
            ),
    );

    final scaffold = Stack(
      fit: StackFit.expand,
      children: [
        PlayxThemeSwitchingArea(
          child: PlatformScaffold(
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
                        attachBreadcrumb: attachBreadcrumb,
                        breadcrumbs: breadcrumbs,
                        showWhatsAppSupport: showWhatsAppSupport,
                      )
                : null,
            body: useSafeArea
                ? SafeArea(
                    bottom: includeBottomSafeArea,
                    right: context.isPortrait || (context.isLtr),
                    left: context.isPortrait || (context.isRtl),
                    child: scaffoldChild,
                  )
                : scaffoldChild,
            material: (context, platform) => MaterialScaffoldData(
              floatingActionButton: floatingActionButton,
              floatingActionButtonLocation: floatingActionButtonLocation,
            ),
            cupertino: (ctx, p) => CupertinoPageScaffoldData(),
            backgroundColor: backgroundColor ?? context.colors.surface,
          ),
        ),
        if (includeLoadingOverlay)
          Obx(
            () => LoadingOverlay(
              loadingStatus: AppController.instance.loadingStatus.value,
            ),
          ),
      ],
    );

    return addPopScope
        ? PopScope(
            canPop: false,
            onPopInvokedWithResult: (didPop, r) {
              if (didPop || kIsWeb) return;
              if (Navigator.of(context).canPop()) {
                Navigator.of(context).pop();
              }
              AppNavigation.navigateToHome();
              return;
            },
            child: scaffold,
          )
        : scaffold;
  }
}
