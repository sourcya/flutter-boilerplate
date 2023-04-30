import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../resources/colors.dart';

/// Widget that shows an icon from icon data, svg, image or text.
class IconViewer extends StatelessWidget {
  final IconData? icon;
  final String? svgIcon;
  final String? iconImage;
  final String? text;
  final bool isSelected;
  final Color? iconColor;
  final Color? iconBackgroundColor;
  final Color? selectedIconColor;
  final Color? selectedIconBackgroundColor;
  final BoxFit fit;
  final double width;
  final double height;

  const IconViewer({
    this.icon,
    this.svgIcon,
    this.iconImage,
    this.text,
    this.iconColor = AppColors.white,
    this.iconBackgroundColor = AppColors.secondaryLight,
    this.selectedIconColor,
    this.selectedIconBackgroundColor,
    super.key,
    this.isSelected = false,
    this.fit = BoxFit.scaleDown,
    this.width = 40,
    this.height = 40,
  });

  @override
  Widget build(BuildContext context) {
    if (icon != null) {
      return isSelected
          ? Container(
              width: width,
              height: height,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: selectedIconBackgroundColor,
                //  color: Color(0xFFF0F3F8),
              ),
              child: Icon(
                icon,
                color: selectedIconColor,
                key: key,
              ),
            )
          : Container(
              width: width,
              height: height,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: iconBackgroundColor,
              ),
              child: Icon(
                icon,
                color: iconColor,
                key: key,
              ),
            );
    } else if (svgIcon != null) {
      return isSelected
          ? Container(
              width: fit == BoxFit.cover ? null : width,
              height: fit == BoxFit.cover ? null : height,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: selectedIconBackgroundColor,
                //  color: Color(0xFFF0F3F8),
              ),
              child: SvgPicture.asset(
                svgIcon!,
                width: fit == BoxFit.cover ? null : 24,
                height: fit == BoxFit.cover ? null : 24,
                colorFilter: selectedIconColor == null
                    ? null
                    : ColorFilter.mode(
                        selectedIconColor!,
                        BlendMode.srcIn,
                      ),
                fit: fit,
                key: key,
              ),
            )
          : Container(
              width: fit == BoxFit.cover ? null : width,
              height: fit == BoxFit.cover ? null : height,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: iconBackgroundColor,
              ),
              child: SvgPicture.asset(
                svgIcon!,
                width: fit == BoxFit.cover ? null : 24,
                height: fit == BoxFit.cover ? null : 24,
                colorFilter: iconColor == null
                    ? null
                    : ColorFilter.mode(
                        iconColor!,
                        BlendMode.srcIn,
                      ),
                fit: fit,
                key: key,
              ),
            );
    } else if (iconImage != null) {
      return isSelected
          ? Container(
              width: width,
              height: height,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: selectedIconBackgroundColor,
              ),
              child: Image.asset(
                iconImage!,
                color: selectedIconColor,
                key: key,
              ),
            )
          : Image.asset(
              iconImage!,
              color: iconColor,
              key: key,
            );
    } else if (text != null) {
      return isSelected
          ? Container(
              width: width,
              height: height,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: selectedIconBackgroundColor,
              ),
              alignment: Alignment.center,
              padding: const EdgeInsets.all(2),
              child: Text(
                text ?? '',
                style: TextStyle(
                  fontSize: 8,
                  color: selectedIconColor,
                ),
              ),
            )
          : Container(
              width: width,
              height: height,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: iconBackgroundColor,
              ),
              alignment: Alignment.center,
              padding: const EdgeInsets.all(2),
              child: Text(
                text ?? '',
                style: TextStyle(
                  fontSize: 8,
                  color: iconColor,
                ),
              ),
            );
    } else {
      return Container();
    }
  }
}
