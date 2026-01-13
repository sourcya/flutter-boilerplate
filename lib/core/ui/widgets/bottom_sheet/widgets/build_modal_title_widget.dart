part of '../../../ui.dart';

class BuildModalTitleWidget extends StatelessWidget {
  final String title;
  final VoidCallback? onClose;
  final double? fontSize;
  final VoidCallback? onTitlePressed;
  final bool showCloseButton;

  const BuildModalTitleWidget({
    super.key,
    required this.title,
    this.onClose,
    this.showCloseButton = false,
    this.fontSize,
    this.onTitlePressed,
  });

  const BuildModalTitleWidget.withCloseButton({
    super.key,
    required this.title,
    this.onClose,
    this.showCloseButton = true,
    this.fontSize,
    this.onTitlePressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: showCloseButton
          ? EdgeInsets.symmetric(
              horizontal: 16.r,
              vertical: 12.h,
            )
          : null,
      decoration: showCloseButton
          ? BoxDecoration(
              // color: context.colors.surface,
              border: Border(
                bottom: BorderSide(
                  color: context.colors.outlineVariant.withValues(alpha: 0.3),
                ),
              ),
            )
          : null,
      child: Row(
        children: [
          Expanded(
            child: CustomInkWell(
              onTap: onTitlePressed,
              child: CustomText(
                title,
                textStyle: context.textTheme.titleLarge?.copyWith(
                  fontSize: fontSize?.sp ?? 18.sp,
                  fontWeight: FontWeight.w600,
                  color: context.colors.onSurface,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          if (showCloseButton)
            IconButton(
              icon: Icon(
                Icons.close,
                color: context.colorScheme.surface,
              ),
              onPressed: onClose ?? () => Navigator.pop(context),
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
            ),
        ],
      ),
    );
  }
}
