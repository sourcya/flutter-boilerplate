part of '../../ui.dart';

class MenuIconButton extends StatelessWidget {
  const MenuIconButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        AppController.instance.toggleDrawer();
      },
      icon: ValueListenableBuilder<AdvancedDrawerValue>(
        valueListenable: AppController.instance.drawerController,
        builder: (_, value, __) {
          return AnimatedRotation(
            turns: value.visible
                ? (context.isRtl ? 0 : .5)
                : (context.isRtl ? .5 : 0),
            duration: const Duration(milliseconds: 200),
            child: ImageViewer.svgAsset(
              Assets.icons.expand,
              color: context.colors.onAppBar,
              width: context.isTablet ? 20.r : 24,
              height: context.isTablet ? 20.r : 24,
            ),
          );
        },
      ),
    );
  }
}
