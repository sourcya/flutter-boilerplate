part of '../../../imports/app_imports.dart';

/// Avatar + name + email row for profile sheet / anchored profile menu headers.
class DrawerProfileUserHeader extends StatelessWidget {
  final String name;
  final String email;
  final bool isLandscape;

  const DrawerProfileUserHeader({
    super.key,
    required this.name,
    required this.email,
    required this.isLandscape,
  });

  @override
  Widget build(BuildContext context) {
    final scale = DrawerScale(isLandscape);
    final initial = name.capitalizedInitialChar;
    return Row(
      children: [
        Container(
          width: scale.r(32),
          height: scale.r(32),
          clipBehavior: Clip.antiAlias,
          decoration: ShapeDecoration(
            color: context.colors.primaryFixedDim,
            shape: RoundedRectangleBorder(
              borderRadius: 8.0.radius,
            ),
          ),
          child: Center(
            child: CustomText(
              initial,
              textStyle: context.styles.bodyMedium.copyWith(
                fontSize: scale.sp(14),
                fontWeight: FontWeight.w600,
                height: 1,
                color: context.colors.onPrimaryFixed,
              ),
              isTranslatable: false,
              maxLines: 1,
              overflow: TextOverflow.clip,
            ),
          ),
        ),
        8.wBox,
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomText(
                name,
                textStyle: context.styles.bodyMedium.copyWith(
                  fontWeight: FontWeight.w600,
                  height: 1,
                  color: context.isDarkMode ? context.colors.foreground : AppColors.slate.slate700,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              if (email.isNotEmpty) ...[
                2.hBox,
                CustomText(
                  email,
                  textStyle: context.styles.textXs.copyWith(
                    fontWeight: FontWeight.w400,
                    height: 1.33,
                    color: context.isDarkMode
                        ? context.colors.mutedForeground
                        : AppColors.slate.slate700,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  isTranslatable: false,
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }
}
