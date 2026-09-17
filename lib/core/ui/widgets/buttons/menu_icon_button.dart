part of '../../ui.dart';

class MenuIconButton extends StatelessWidget {
  const MenuIconButton({super.key});

  @override
  Widget build(BuildContext context) {
    if (!context.isAppPortrait) {
      return const SizedBox.shrink();
    }

    return AppBarIconButton(
      icon: IconInfo.svg(Assets.icons.icMenu),
      onTap: () {
        ScaffoldState? targetScaffold;
        context.visitAncestorElements((element) {
          if (element is StatefulElement && element.state is ScaffoldState) {
            final state = element.state as ScaffoldState;
            if (state.hasDrawer) {
              targetScaffold = state;
              return false;
            }
          }
          return true;
        });

        if (targetScaffold != null) {
          targetScaffold?.openDrawer();
          return;
        }
        final scaffold = Scaffold.maybeOf(context);
        if (scaffold != null && scaffold.hasDrawer) {
          scaffold.openDrawer();
          return;
        }
        AppController.instance.toggleDrawer();
      },
    );
  }
}
