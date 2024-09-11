part of '../../../imports/settings_imports.dart';

class BuildSettingsTile extends StatelessWidget {
  final String title;
  final String? subtitle;
  final IconData? icon;
  final String? svgIcon;
  final void Function() onTap;
  final bool? isSelected;
  final void Function(bool?)? onSelectionChanged;
  final EdgeInsetsGeometry? padding;
  final double? size;

  const BuildSettingsTile({
    super.key,
    required this.title,
    this.subtitle,
    this.icon,
    this.svgIcon,
    required this.onTap,
    this.isSelected,
    this.onSelectionChanged,
    this.padding,
    this.size,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: CustomCard(
        margin: AppUtils.isDarkMode()
            ? EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h)
            : EdgeInsets.symmetric(horizontal: 6.w, vertical: 4.h),
        padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 2.h),
        isChild: true,
        child: Padding(
          padding: padding ??
              EdgeInsets.symmetric(horizontal: 8.0.w, vertical: 12.0.h),
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 4.0.w, vertical: 4.h),
                child: IconViewer(
                  icon: icon,
                  svgIcon: svgIcon ?? '',
                  iconColor: context.colors.primary,
                  width: size ?? 24.w,
                  height: size ?? 24.w,
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: EdgeInsets.only(
                        right: 2.w,
                        left: 2.w,
                        top: 4.h,
                        bottom: 2.h,
                      ),
                      child: CustomText(
                        title,
                      ),
                    ),
                    if (subtitle != null)
                      Container(
                        padding: EdgeInsets.only(
                          right: 2.w,
                          left: 2.w,
                          top: 4.h,
                          bottom: 4.h,
                        ),
                        child: CustomText(
                          subtitle!,
                          color: context.colors.subtitleTextColor,
                          fontSize: 14.sp,
                        ),
                      ),
                  ],
                ),
              ),
              if (isSelected != null)
                Checkbox(
                  value: isSelected,
                  fillColor: const WidgetStatePropertyAll(Colors.transparent),
                  activeColor: context.colors.onSurface,
                  checkColor: context.colors.primary,
                  onChanged: onSelectionChanged,
                ),
              SizedBox(width: 10.w),
            ],
          ),
        ),
      ),
    );
  }
}
