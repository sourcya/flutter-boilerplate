part of '../../../imports/app_imports.dart';

/// Operator-style avatar (32×32, 8px corners) with the user's initial.
class DrawerBodyUserProfileAvatar extends StatelessWidget {
  final String initial;

  const DrawerBodyUserProfileAvatar({
    super.key,
    required this.initial,
  });

  @override
  Widget build(BuildContext context) {
    final scale = DrawerScale.of(context);
    final size = scale.r(32);

    return Container(
      width: size,
      height: size,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(scale.r(8)),
        color: context.colors.primaryFixedDim,
      ),
      child: Center(
        child: CustomText(
          initial,
          fontSize: scale.sp(14),
          fontWeight: FontWeight.w600,
          height: 1,
          color: context.colors.onPrimaryFixed,
          isTranslatable: false,
          maxLines: 1,
          textOverflow: TextOverflow.clip,
        ),
      ),
    );
  }
}
