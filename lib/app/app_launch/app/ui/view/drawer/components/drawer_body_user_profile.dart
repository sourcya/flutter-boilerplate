part of '../../../imports/app_imports.dart';

/// Presentational row at the bottom of the drawer body: avatar plus the
/// user's display name / email, with a settings glyph on the trailing edge.
/// Becomes icon-only when the drawer collapses to the rail.
class DrawerBodyUserProfile extends StatelessWidget {
  final bool extended;
  final String? name;
  final String? email;

  const DrawerBodyUserProfile({
    super.key,
    required this.extended,
    this.name,
    this.email,
  });

  @override
  Widget build(BuildContext context) {
    final scale = DrawerScale.of(context);
    final currentEmail = email;
    final initial = name?.capitalizedInitialChar ?? '';

    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeOutCubic,
      margin: context.paddingOnly(
        start: extended ? 0 : 8,
        end: extended ? 0 : 8,
        bottom: 8,
      ),
      width: extended ? context.width : null,
      clipBehavior: extended ? Clip.antiAlias : Clip.none,
      padding: extended ? context.paddingOnly(start: 6, end: 12) : context.paddingZero(),
      decoration: extended
          ? ShapeDecoration(
              shape: RoundedRectangleBorder(
                borderRadius: 6.0.radius,
              ),
            )
          : null,
      child: extended
          ? Row(
              children: [
                DrawerBodyUserProfileAvatar(initial: initial),
                Flexible(
                  child: DrawerExpandableRowTransition(
                    expanded: extended,
                    child: Padding(
                      padding: context.paddingOnly(start: 8),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomText(
                                  name ?? '',
                                  textStyle: context.styles.bodyMedium.copyWith(
                                    fontWeight: FontWeight.w600,
                                    height: 1,
                                    color: context.colors.onSurface,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  isResponsive: false,
                                  isTranslatable: false,
                                ),
                                if (currentEmail != null && currentEmail.isNotEmpty) ...[
                                  2.hBox,
                                  CustomText(
                                    currentEmail,
                                    textStyle: context.styles.textXs.copyWith(
                                      fontWeight: FontWeight.w400,
                                      height: 1.33,
                                      color: context.colors.subtitleTextColor,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    isResponsive: false,
                                    isTranslatable: false,
                                  ),
                                ],
                              ],
                            ),
                          ),
                          4.wBox,
                          IconInfo.svg(
                            Assets.icons.settings,
                            size: 16.r,
                            color: context.colors.onSurface,
                          ).buildIconWidget(),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            )
          : Center(
              child: Container(
                margin: context.paddingSymmetric(vertical: 2),
                width: scale.railChromeTileHeight,
                height: scale.railChromeTileHeight,
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  color: context.colors.primaryFixedDim,
                  borderRadius: scale.railChromeBorderRadius.radius,
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
            ),
    );
  }
}
