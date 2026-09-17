part of '../../ui.dart';

class CustomPopupMenuItem<T> {
  final T? value;
  final String title;
  final IconInfo? icon;
  final Color? textColor;
  final VoidCallback? onTap;
  final Widget? customWidget;
  final Widget? trailing;

  const CustomPopupMenuItem({
    this.value,
    required this.title,
    this.icon,
    this.textColor,
    this.onTap,
    this.customWidget,
    this.trailing,
  });

  factory CustomPopupMenuItem.onEdit({
    T? value,
    String? title,
    VoidCallback? onTap,
    Color? iconColor,
  }) {
    return CustomPopupMenuItem(
      value: value,
      title: title ?? AppTrans.edit,
      onTap: onTap,
      icon: IconInfo.svg(
        Asset.icons.icEdit,
        size: 18.r,
        color: iconColor,
      ),
      textColor: iconColor,
    );
  }

  factory CustomPopupMenuItem.onDelete({
    T? value,
    String? title,
    VoidCallback? onTap,
    Color? color = AppColors.semanticDestructive,
  }) {
    return CustomPopupMenuItem(
      value: value,
      title: title ?? AppTrans.delete,
      textColor: color,
      icon: IconInfo.svg(
        Asset.icons.icDelete,
        size: 18.r,
        color: color,
      ),
      onTap: onTap,
    );
  }

  factory CustomPopupMenuItem.viewDetails({
    T? value,
    String? title,
    VoidCallback? onTap,
    Color? iconColor,
  }) {
    return CustomPopupMenuItem(
      value: value,
      title: title ?? AppTrans.viewDetails,
      icon: IconInfo.svg(
        Asset.icons.icEye,
        size: 18.r,
        color: iconColor,
      ),
      textColor: iconColor,
      onTap: onTap,
    );
  }

  factory CustomPopupMenuItem.share({
    T? value,
    String? title,
    VoidCallback? onTap,
    Color? iconColor,
  }) {
    return CustomPopupMenuItem(
      value: value,
      title: title ?? AppTrans.shareReportText,
      icon: IconInfo.svg(
        Asset.icons.icLink,
        size: 18.r,
        color: iconColor,
      ),
      textColor: iconColor,
      onTap: onTap,
    );
  }
}

class CustomPopupMenu<T> extends StatelessWidget {
  final List<CustomPopupMenuItem<T>> items;
  final ValueChanged<T>? onSelected;
  final Widget? customChild;
  final IconData iconData;
  final double? iconSize;
  final double radius;
  final Color? iconColor;
  final BoxDecoration? buttonDecoration;
  final Offset offset;
  final bool showBorder;

  const CustomPopupMenu({
    super.key,
    required this.items,
    this.onSelected,
    this.customChild,
    this.iconData = Icons.more_vert,
    this.iconSize,
    this.radius = 12.0,
    this.iconColor,
    this.buttonDecoration,
    this.offset = const Offset(0, 40),
    this.showBorder = true,
  });
  const CustomPopupMenu.table({
    super.key,
    required this.items,
    this.onSelected,
    this.customChild,
    this.iconData = Icons.more_vert,
    this.iconSize,
    this.radius = 8.0,
    this.iconColor,
    this.buttonDecoration,
    this.offset = const Offset(0, 40),
    this.showBorder = true,
  });

  @override
  Widget build(BuildContext context) {
    final menuBorderColor = context.isDarkMode
        ? context.colors.outline
        : context.colors.outlineVariant;
    return Theme(
      data: Theme.of(context).copyWith(
        popupMenuTheme: PopupMenuThemeData(
          color: context.colors.cardColor,
          menuPadding: EdgeInsets.zero,
          surfaceTintColor: context.colors.cardColor,
          shape: RoundedRectangleBorder(
            side: BorderSide(color: menuBorderColor),
            borderRadius: BorderRadius.circular(radius.r),
          ),
          shadowColor: context.colors.cardShadowColor,
          elevation: 6.r,
        ),
      ),
      child: PopupMenuButton<T>(
        offset: offset,
        onSelected: onSelected,
        padding: EdgeInsets.zero,
        elevation: 6.r,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius.r),
        ),
        itemBuilder: (ctx) =>
            items.map((item) => _CustomPopupMenuEntry<T>(context: ctx, item: item)).toList(),
        child:
            customChild ??
            _CustomPopupMenuDefaultChild(
              iconData: iconData,
              iconSize: iconSize,
              radius: radius,
              iconColor: iconColor,
              buttonDecoration: buttonDecoration,
              showBorder: showBorder,
            ),
      ),
    );
  }
}

class _CustomPopupMenuDefaultChild extends StatelessWidget {
  final IconData iconData;
  final double? iconSize;
  final Color? iconColor;
  final BoxDecoration? buttonDecoration;
  final bool showBorder;
  final double radius;

  const _CustomPopupMenuDefaultChild({
    required this.iconData,
    this.iconSize,
    this.iconColor,
    this.radius = 12.0,
    this.buttonDecoration,
    required this.showBorder,
  });

  @override
  Widget build(BuildContext context) {
    final fallbackIconColor =
        iconColor ??
        (context.isDarkMode ? context.colors.cardForeground : context.colors.foreground);
    return Container(
      padding: context.paddingAll(8),
      decoration:
          buttonDecoration ??
          (showBorder
              ? BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(radius.r)),
                  border: Border.all(color: context.colors.actionButtonBorder),
                  color: context.colors.cardColor,
                )
              : BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(radius.r)),
                )),
      child: Icon(
        iconData,
        size: iconSize ?? (context.isAppPortrait ? 16.r : 22.r),
        color: fallbackIconColor,
      ),
    );
  }
}

class _CustomPopupMenuEntry<T> extends PopupMenuItem<T> {
  _CustomPopupMenuEntry({
    required BuildContext context,
    required CustomPopupMenuItem<T> item,
  }) : super(
         value: item.value,
         enabled: item.onTap != null,
         onTap: item.onTap,
         padding: EdgeInsets.zero,
         child:
             item.customWidget ??
             Padding(
               padding: context.paddingSymmetric(
                 vertical: 12,
                 horizontal: 8,
               ),
               child: Row(
                 children: [
                   if (item.icon != null) ...[
                     item.icon!.buildIconWidget(
                       size: item.icon!.size ?? 16.r,
                       color: item.icon!.color ?? context.colors.onSurface,
                     ),
                     8.wBox,
                   ],
                   CustomText(
                     item.title,
                     color: item.textColor ?? context.colors.cardForeground,
                     fontSize: 16.sp,
                     fontWeight: FontWeight.w400,
                   ),
                   if (item.trailing != null) ...[
                     const Spacer(),
                     8.wBox,
                     item.trailing!,
                   ],
                 ],
               ),
             ),
       );
}
