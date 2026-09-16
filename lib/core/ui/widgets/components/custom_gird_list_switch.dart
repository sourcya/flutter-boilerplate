part of '../../ui.dart';

class CustomGirdListSwitch extends StatelessWidget {
  final RxBool isGridView;
  final bool hideOnSmallScreenWidth;

  const CustomGirdListSwitch({
    required this.isGridView,
    this.hideOnSmallScreenWidth = true,
  });

  @override
  Widget build(BuildContext context) {
    if (hideOnSmallScreenWidth && context.width < 840) {
      return const SizedBox.shrink();
    }
    return Obx(() {
      final isGrid = isGridView.value;
      return AnimatedSwitcher(
        duration: 300.milliseconds,
        key: ValueKey(isGrid),
        child: IconButton(
          onPressed: () {
            isGridView.value = !isGrid;
          },
          icon: Icon(
            isGrid ? Icons.list : Icons.grid_view,
            color: kIsWeb ? context.colors.onSurface : context.colors.onAppBar,
            size: PlayxPlatform.isIOS ? 24 : null,
          ),
        ),
      );
    });
  }
}
