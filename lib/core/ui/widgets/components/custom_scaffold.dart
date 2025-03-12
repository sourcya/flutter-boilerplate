part of '../../ui.dart';

class CustomScaffold extends StatelessWidget {
  final Widget child;
  final String? title;
  final EdgeInsetsGeometry? padding;
  final PlatformAppBar? appBar;
  final Widget? floatingActionButton;
  final AppBarLeadingType leading;
  final bool useSafeArea;
  final bool includeAppBar;
  final bool includeLoadingOverlay;

  const CustomScaffold({
    required this.child,
    this.title,
    this.padding,
    this.appBar,
    this.floatingActionButton,
    this.leading = AppBarLeadingType.none,
    this.useSafeArea = true,
    this.includeLoadingOverlay = false,
    this.includeAppBar = true,
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
              body: child,
            )
          : child,
    );

    final scaffold = PlatformScaffold(
      appBar: includeAppBar
          ? appBar ??
              buildAppBar(
                title: title ?? AppTrans.appName,
                context: context,
                leading: leading,
              )
          : null,
      body: Stack(
        fit: StackFit.expand,
        children: [
          if (useSafeArea) SafeArea(child: scaffoldChild) else scaffoldChild,
          if (includeLoadingOverlay)
            Obx(() {
              return LoadingOverlay(
                isLoading: AppController.instance.loadingStatus.value !=
                    LoadingStatus.none,
                loadingText:
                    AppController.instance.loadingStatus.value.displayName,
              );
            }),
        ],
      ),
      backgroundColor: context.colors.surface,
    );

    return scaffold;
  }
}
