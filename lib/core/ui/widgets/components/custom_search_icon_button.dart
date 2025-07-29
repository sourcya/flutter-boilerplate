part of '../../ui.dart';

class CustomSearchIconButton extends StatelessWidget {
  final ValueNotifier<bool> shouldShowSearch;
  final TextEditingController searchController;
  final RxString? search;

  const CustomSearchIconButton({
    required this.shouldShowSearch,
    required this.searchController,
    this.search,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      transitionBuilder: (child, animation) {
        return FadeTransition(opacity: animation, child: child);
      },
      child: ValueListenableBuilder(
        valueListenable: shouldShowSearch,
        builder: (context, value, child) {
          return value
              ? IconButton(
                  visualDensity: VisualDensity.compact,
                  onPressed: () {
                    if (search?.value.isNotEmpty == true) {
                      search?.value = '';
                    }
                    if (searchController.text.isNotEmpty) {
                      searchController.clear();
                    }
                    shouldShowSearch.value = false;
                  },
                  icon: Icon(
                    Icons.close,
                    color: context.colors.onAppBar,
                    size: PlayxPlatform.isIOS ? 26 : null,
                  ),
                )
              : IconButton(
                  visualDensity: VisualDensity.compact,
                  icon: Icon(
                    Icons.search,
                    color: context.colors.onAppBar,
                    size: PlayxPlatform.isIOS ? 26 : null,
                  ),
                  onPressed: () {
                    shouldShowSearch.value = true;
                  },
                );
        },
      ),
    );
  }
}
