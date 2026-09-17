part of '../../ui.dart';

class CustomSearchBar extends StatelessWidget {
  final TextEditingController controller;
  final String? hint;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onClear;
  final bool autofocus;

  const CustomSearchBar({
    super.key,
    required this.controller,
    this.hint,
    this.onChanged,
    this.onClear,
    this.autofocus = false,
  });

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<TextEditingValue>(
      valueListenable: controller,
      builder: (context, value, _) {
        return CustomTextField(
          controller: controller,
          hint: hint ?? AppTrans.searchHint,
          autofocus: autofocus,
          onChanged: onChanged,
          prefix: Padding(
            padding: context.paddingSymmetric(horizontal: 8),
            child: Icon(
              Icons.search,
              size: 20.r,
              color: context.colors.subtitleTextColor,
            ),
          ),
          suffix: value.text.isEmpty
              ? null
              : IconButton(
                  tooltip: AppTrans.clear.tr(context: context),
                  icon: Icon(
                    Icons.close,
                    size: 18.r,
                    color: context.colors.subtitleTextColor,
                  ),
                  onPressed: () {
                    controller.clear();
                    onClear?.call();
                    onChanged?.call('');
                  },
                ),
        );
      },
    );
  }
}
