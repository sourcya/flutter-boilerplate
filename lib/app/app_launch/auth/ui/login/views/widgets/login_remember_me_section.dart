part of '../../imports/login_imports.dart';

class LoginRememberMeSection extends GetView<LoginController> {
  const LoginRememberMeSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Obx(
            () => _RememberMeCheckboxRow(
              value: controller.rememberMe.value,
              onChanged: controller.onRememberMeChanged,
              onLabelTap: controller.toggleRememberMe,
            ),
          ),
        ),
        const LoginForgotPassword(),
      ],
    );
  }
}

class _RememberMeCheckboxRow extends StatelessWidget {
  const _RememberMeCheckboxRow({
    required this.value,
    required this.onChanged,
    required this.onLabelTap,
  });

  final bool value;
  final ValueChanged<bool?> onChanged;
  final VoidCallback onLabelTap;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;

    final checkboxSkin = CheckboxThemeData(
      shape: RoundedRectangleBorder(borderRadius: 4.radius),
      side: BorderSide(color: c.primary),
      splashRadius: 18.r,
      visualDensity: VisualDensity.compact,
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      fillColor: WidgetStateProperty.resolveWith((states) {
        if (!states.contains(WidgetState.selected)) {
          return c.inputBackgroundColor;
        }
        return c.primary;
      }),
      checkColor: WidgetStatePropertyAll(c.primaryActionText),
      overlayColor: const WidgetStatePropertyAll(AppColors.transparent),
    );

    return MergeSemantics(
      child: CheckboxTheme(
        data: checkboxSkin,
        child: Padding(
          padding: context.paddingSymmetric(vertical: 4, horizontal: 2),
          child: Row(
            children: [
              ConstrainedBox(
                constraints: BoxConstraints.tightFor(
                  width: 16.r,
                  height: 16.r,
                ),
                child: Checkbox(
                  value: value,
                  onChanged: onChanged,
                ),
              ),
              8.wBox,
              Expanded(
                child: InkWell(
                  borderRadius: 8.radius,
                  onTap: onLabelTap,
                  child: CustomText(
                    AppTrans.rememberMe,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    textStyle: context.bodyMediumTS.copyWith(
                      color: c.foreground,
                      height: 1.43,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
