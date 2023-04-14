import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../resources/colors.dart';

class IconViewer extends StatelessWidget {
  IconData? icon;
  String? svgIcon;
  String? iconImage;
  String? text;
  Key? key;
  bool isSelected;
  Color? iconColor;
  Color? iconBackgroundColor;
  Color? selectedIconColor;
  Color? selectedIconBackgroundColor;
  BoxFit fit;

  IconViewer({
    this.icon,
    this.svgIcon,
    this.iconImage,
    this.text,
    this.iconColor = AppColors.white,
    this.iconBackgroundColor = AppColors.secondaryLight,
    this.selectedIconColor,
    this.selectedIconBackgroundColor,
    this.key,
    this.isSelected = false,
    this.fit = BoxFit.scaleDown,
  });

  @override
  Widget build(BuildContext context) {
    if (icon != null) {
      return isSelected
          ? Container(
              width: 40,
              height: 40,
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
              width: 40,
              height: 40,
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
              width: fit == BoxFit.cover ? null : 40,
              height: fit == BoxFit.cover ? null : 40,
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
              width: fit == BoxFit.cover ? null : 40,
              height: fit == BoxFit.cover ? null : 40,
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
              width: 40,
              height: 40,
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
              width: 40,
              height: 40,
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
              width: 40,
              height: 40,
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
