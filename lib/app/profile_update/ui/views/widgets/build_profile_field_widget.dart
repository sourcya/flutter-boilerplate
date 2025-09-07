part of '../../imports/profile_imports.dart';

class BuildProfileFieldWidget extends GetView<EditProfileController> {
  final String fieldName;
  final String label;
  final TextEditingController textController;
  final FocusNode focus;
  final FocusNode? nextFocus;
  final IconData icon;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;

  const BuildProfileFieldWidget({
    super.key,
    required this.fieldName,
    required this.label,
    required this.textController,
    required this.focus,
    required this.icon,
    this.nextFocus,
    this.keyboardType,
    this.textInputAction,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      // Force reactive rebuild by accessing reactive properties
      final _ = controller.isFormValid.value; // This ensures rebuilds

      final isValid = controller.isFieldValid(fieldName);
      final hasError = textController.text.isNotEmpty && !isValid;
      final errorMessage =
          hasError ? controller.getFieldErrorMessage(fieldName) : null;

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 4.w, bottom: 8.h),
            child: CustomText(
              label,
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              color: context.colors.onSurface,
            ),
          ),
          AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16.r),
              border: Border.all(
                color: hasError
                    ? Colors.red.withValues(alpha: 0.6)
                    : isValid && textController.text.isNotEmpty
                        ? Colors.green.withValues(alpha: 0.6)
                        : context.colors.outline.withValues(alpha: 0.3),
                width: hasError || (isValid && textController.text.isNotEmpty)
                    ? 2
                    : 1,
              ),
            ),
            child: CustomTextField(
              controller: textController,
              focus: focus,
              nextFocus: nextFocus,
              type: keyboardType ?? TextInputType.text,
              textInputAction: textInputAction ??
                  (nextFocus != null
                      ? TextInputAction.next
                      : TextInputAction.done),
              onChanged: (value) {
                controller.onFieldChanged(fieldName, value);
              },
              contentPadding: EdgeInsets.symmetric(
                horizontal: 16.w,
                vertical: 16.h,
              ),
              prefix: Container(
                margin: EdgeInsets.only(right: 12.w),
                child: Icon(
                  icon,
                  size: 20.r,
                  color: hasError
                      ? Colors.red.withValues(alpha: 0.7)
                      : isValid && textController.text.isNotEmpty
                          ? Colors.green.withValues(alpha: 0.7)
                          : context.colors.onSurface.withValues(alpha: 0.6),
                ),
              ),
              suffix: textController.text.isNotEmpty
                  ? Icon(
                      isValid ? Icons.check_circle : Icons.error,
                      size: 20.r,
                      color: isValid
                          ? Colors.green.withValues(alpha: 0.7)
                          : Colors.red.withValues(alpha: 0.7),
                    )
                  : null,
              fillColor: context.colors.surface,
              borderColor: Colors.transparent,
              focusedBorderColor: Colors.transparent,
              borderRadius: BorderRadius.circular(16.r),
            ),
          ),
          AnimatedSize(
            duration: const Duration(milliseconds: 200),
            child: errorMessage != null
                ? Container(
                    margin: EdgeInsets.only(top: 8.h, left: 4.w),
                    child: CustomText(
                      errorMessage,
                      fontSize: 12.sp,
                      color: Colors.red.withValues(alpha: 0.8),
                      fontWeight: FontWeight.w500,
                    ),
                  )
                : const SizedBox.shrink(),
          ),
        ],
      );
    });
  }
}
