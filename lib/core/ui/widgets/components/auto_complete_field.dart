part of '../../ui.dart';

class AutoCompleteField<T extends Object> extends StatelessWidget {
  final TextEditingController? controller;
  final String? label;
  final String? hint;
  final List<T> suggestions;
  final String Function(T) displayStringForOption;
  final ValueChanged<T>? onSelected;
  final ValueChanged<String>? onChanged;
  final bool isLoading;
  final String? errorMessage;
  final VoidCallback? onRetry;
  final String emptyMessage;

  const AutoCompleteField({
    super.key,
    this.controller,
    this.label,
    this.hint,
    required this.suggestions,
    required this.displayStringForOption,
    this.onSelected,
    this.onChanged,
    this.isLoading = false,
    this.errorMessage,
    this.onRetry,
    this.emptyMessage = AppTrans.noDataMessage,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null) ...[
          CustomText(label!, fontWeight: FontWeight.w600, fontSize: 13),
          8.hBox,
        ],
        Autocomplete<T>(
          displayStringForOption: displayStringForOption,
          optionsBuilder: (textEditingValue) {
            if (isLoading || errorMessage != null) {
              return const Iterable.empty();
            }
            final query = textEditingValue.text.toLowerCase();
            if (query.isEmpty) return suggestions;
            return suggestions.where(
              (option) => displayStringForOption(option)
                  .toLowerCase()
                  .contains(query),
            );
          },
          onSelected: onSelected,
          fieldViewBuilder: (context, textController, focusNode, onFieldSubmitted) {
            if (controller != null && textController.text != controller!.text) {
              textController.value = controller!.value;
            }
            return CustomTextField(
              controller: textController,
              focus: focusNode,
              hint: hint,
              onChanged: onChanged,
              suffix: isLoading
                  ? Padding(
                      padding: context.paddingAll(10),
                      child: SizedBox(
                        width: 16.r,
                        height: 16.r,
                        child: CenterLoading.adaptive(
                          color: context.colors.primary,
                        ),
                      ),
                    )
                  : null,
            );
          },
          optionsViewBuilder: (context, onSelectedOption, options) {
            if (errorMessage != null) {
              return _panel(
                context,
                child: ErrorDataWidget(
                  error: errorMessage!,
                  onRetryClicked: onRetry,
                ),
              );
            }
            if (options.isEmpty) {
              return _panel(
                context,
                child: Padding(
                  padding: context.paddingAll(16),
                  child: CustomText(
                    emptyMessage,
                    color: context.colors.subtitleTextColor,
                  ),
                ),
              );
            }
            return _panel(
              context,
              child: ListView.builder(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                itemCount: options.length,
                itemBuilder: (context, index) {
                  final option = options.elementAt(index);
                  return ListTile(
                    title: CustomText(
                      displayStringForOption(option),
                      isTranslatable: false,
                    ),
                    onTap: () => onSelectedOption(option),
                  );
                },
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _panel(BuildContext context, {required Widget child}) {
    return Align(
      alignment: AlignmentDirectional.topStart,
      child: Material(
        elevation: 4,
        color: context.colors.cardBackgroundColor,
        borderRadius: BorderRadius.circular(12.r),
        child: ConstrainedBox(
          constraints: BoxConstraints(maxHeight: 220.r, maxWidth: 420.r),
          child: child,
        ),
      ),
    );
  }
}
