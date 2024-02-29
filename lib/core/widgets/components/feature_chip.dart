import 'package:flutter/material.dart';
import 'package:playx/playx.dart';

import '../../resources/style/style.dart';

class FeatureChip extends StatelessWidget {
  final String? label;
  final IconData? icon;
  final String? svgIcon;
  final String? imageUrl;
  final Color? backgroundColor;
  final Color? color;
  final EdgeInsetsGeometry? padding;

  const FeatureChip({
    this.label,
    this.color = Colors.black,
    this.icon,
    this.svgIcon,
    this.backgroundColor,
    this.padding,
    this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: label?.isNotEmpty == true,
      child: Padding(
        padding: padding ??
            EdgeInsets.symmetric(
              horizontal: 2.w,
            ),
        child: Chip(
          shape: Style.featureChipRoundedRectangleBorder,
          label: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (icon != null ||
                  svgIcon?.isNotEmpty == true ||
                  imageUrl?.isNotEmpty == true) ...[
                SizedBox(
                  width: 24,
                  height: 24,
                  child: icon != null
                      ? IconViewer(
                          icon: icon,
                          iconColor: color,
                          width: 16,
                          height: 16,
                          iconSize: 18,
                        )
                      : svgIcon?.isNotEmpty == true
                          ? IconViewer.svg(svgIcon: svgIcon)
                          : imageUrl?.isNotEmpty == true
                              ? Container(
                                  width: 100,
                                  height: 100,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.white,
                                    image: DecorationImage(
                                      image: CachedNetworkImageProvider(
                                        imageUrl!,
                                      ),
                                      fit: BoxFit.contain,
                                    ),
                                  ),
                                )
                              : const SizedBox.shrink(),
                ),
                SizedBox(
                  width: 4.w,
                ),
              ],
              Text(
                label ?? '',
                style: TextStyle(color: color),
              ),
            ],
          ),
          backgroundColor: backgroundColor,
          padding: EdgeInsets.symmetric(
            horizontal: 4.w,
          ),
          labelPadding:
              padding ?? EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
        ),
      ),
    );
  }
}
