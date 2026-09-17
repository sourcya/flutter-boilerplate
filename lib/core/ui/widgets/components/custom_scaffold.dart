part of '../../ui.dart';

class CustomScaffold extends StatelessWidget {
  final Widget? child;
  final WidgetBuilder? childBuilder;
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
  final PreferredSizeWidget? bottom;
  final FloatingActionButtonLocation? floatingActionButtonLocation;
  final List<BreadcrumbItem>? breadcrumbs;
  final bool? attachBreadcrumb;
  final bool addPopScope;
  final VoidCallback? onBackPressed;
  final bool attachPortraitConstraint;
  final AlignmentGeometry bodyAlignment;
  final bool isInitialized;
  final bool showSupportButton;
  final bool showNotificationButton;
  final bool showUserAvatar;
  final bool? showWhatsAppSupport;
  final bool showLeading;
  final bool isWideWeb;

  /// Padding below [LandscapeAppBar]. Defaults to 16 on all sides.
  final EdgeInsetsGeometry? landscapeBodyPadding;

  const CustomScaffold({
    this.child,
    this.childBuilder,
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
    this.includeLoadingOverlay = false,
    this.bottom,
    this.floatingActionButtonLocation,
    this.breadcrumbs,
    this.attachBreadcrumb,
    this.addPopScope = false,
    this.onBackPressed,
    this.attachPortraitConstraint = false,
    this.bodyAlignment = Alignment.center,
    this.isInitialized = true,
    this.showSupportButton = true,
    this.showNotificationButton = false,
    this.showUserAvatar = false,
    this.showWhatsAppSupport,
    this.showLeading = true,
    this.isWideWeb = false,
    this.landscapeBodyPadding,
    super.key,
  }) : assert(
         child != null || childBuilder != null,
         'CustomScaffold requires either child or childBuilder.',
       );

  @override
  Widget build(BuildContext context) {
    final isLandscape = context.isAppLandscape;
    final useLandscapeAppBar = includeAppBar && isLandscape;
    final resolvedScaffoldBackground =
        backgroundColor ?? context.colors.surface;
    final bodyContent = isInitialized
        ? childBuilder?.call(context) ?? child!
        : const CenterLoading.adaptive();
    final selectableBodyContent = WebBodySelectionArea(child: bodyContent);

    final Widget pageBody = AnimatedSwitcher(
      duration: const Duration(milliseconds: 100),
      child: KeyedSubtree(
        key: ValueKey<bool>(isInitialized),
        child: PlayxPlatform.isIOS
            ? Scaffold(
                floatingActionButton: floatingActionButton,
                floatingActionButtonLocation: floatingActionButtonLocation,
                body: selectableBodyContent,
                backgroundColor: resolvedScaffoldBackground,
              )
            : Scaffold(
                backgroundColor: resolvedScaffoldBackground,
                body: selectableBodyContent,
              ),
      ),
    );

    Widget scaffoldChild = useLandscapeAppBar
        ? Padding(
            padding: padding ?? EdgeInsets.zero,
            child: pageBody,
          )
        : Container(
            padding: padding,
            alignment: bodyAlignment,
            child: pageBody,
          );

    if (useLandscapeAppBar) {
      scaffoldChild = Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          LandscapeAppBar(
            title: title ?? AppTrans.appName,
            titleWidget: titleWidget,
            actions: actions,
            breadcrumbs: breadcrumbs,
            attachBreadcrumb: attachBreadcrumb,
            showNotificationButton: showNotificationButton,
            showSupportButton: showSupportButton,
            showWhatsAppSupport: showWhatsAppSupport,
          ),
          Expanded(
            child: Padding(
              padding: landscapeBodyPadding ?? context.paddingAll(16),
              child: scaffoldChild,
            ),
          ),
        ],
      );
    }

    final platformScaffold = PlatformScaffold(
      appBar: includeAppBar && !isLandscape
          ? appBar ??
              buildAppBar(
                title: title,
                titleWidget: titleWidget,
                context: context,
                leading: leading,
                headerLeadingWidget: leadingWidget,
                actions: actions,
                titleSpacing: titleSpacing ?? 0,
                bottom: bottom,
                attachBreadcrumb: attachBreadcrumb,
                breadcrumbs: breadcrumbs,
                onBackPressed: onBackPressed,
                showSupportButton: showSupportButton,
                showNotificationButton: showNotificationButton,
                showWhatsAppSupport: showWhatsAppSupport,
                showUserAvatar: showUserAvatar,
                isWideWeb: isWideWeb,
                showLeading: showLeading,
              )
          : null,
      body: useSafeArea
          ? SafeArea(
              top: !useLandscapeAppBar,
              bottom: includeBottomSafeArea,
              right: context.isPortrait || context.isLtr,
              left: context.isPortrait || context.isRtl,
              child: scaffoldChild,
            )
          : scaffoldChild,
      material: (context, platform) => MaterialScaffoldData(
        floatingActionButton: floatingActionButton,
        floatingActionButtonLocation: floatingActionButtonLocation,
      ),
      cupertino: (ctx, p) => CupertinoPageScaffoldData(),
      backgroundColor: resolvedScaffoldBackground,
    );

    Widget finalScaffold = addPopScope
        ? PopScope(
            canPop: false,
            onPopInvokedWithResult: (didPop, _) {
              if (didPop || kIsWeb) return;
              if (Navigator.of(context).canPop()) {
                Navigator.of(context).pop();
              }
              AppNavigation.navigateFormSplashToHome();
            },
            child: platformScaffold,
          )
        : platformScaffold;

    if (includeLoadingOverlay) {
      finalScaffold = Stack(
        fit: StackFit.expand,
        children: [
          finalScaffold,
          Obx(
            () => LoadingOverlay(
              loadingStatus: AppController.instance.loadingStatus.value,
            ),
          ),
        ],
      );
    }

    if (attachPortraitConstraint) {
      finalScaffold = PortraitConstraint(child: finalScaffold);
    }

    return finalScaffold;
  }
}
