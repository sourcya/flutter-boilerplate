part of '../models.dart';

class IconInfo {
  final IconData? icon;
  final String? svgIcon;
  final String? assetIcon;
  final String? url;
  final Color? color;
  final double? size;

  IconInfo({
    this.icon,
    this.svgIcon,
    this.assetIcon,
    this.url,
    this.color,
    this.size,
  });

  factory IconInfo.icon(IconData icon, {Color? color, double? size}) {
    return IconInfo(icon: icon, color: color, size: size);
  }

  factory IconInfo.asset(String assetIcon, {Color? color, double? size}) {
    return IconInfo(assetIcon: assetIcon, color: color, size: size);
  }
  factory IconInfo.svg(String svgIcon, {Color? color, double? size}) {
    return IconInfo(svgIcon: svgIcon, color: color, size: size);
  }

  factory IconInfo.url(String url, {Color? color, double? size}) {
    return IconInfo(url: url, color: color, size: size);
  }

  IconInfo copyWith({
    IconData? icon,
    CupertinoIcons? cupertinoIcon,
    String? svgIcon,
    String? url,
    Color? color,
    double? size,
  }) {
    return IconInfo(
      icon: icon ?? this.icon,
      svgIcon: svgIcon ?? this.svgIcon,
      url: url ?? this.url,
      color: color ?? this.color,
      size: size ?? this.size,
    );
  }

  Widget buildIconWidget({Color? color, double? size}) {
    final iconSize = size ?? this.size;
    final iconColor = color ?? this.color;
    if (icon != null) {
      return Icon(icon, color: iconColor, size: iconSize);
    } else if (svgIcon != null) {
      return ImageViewer.svgAsset(
        svgIcon!,
        color: iconColor,
        width: iconSize,
        height: iconSize,
      );
    } else if (assetIcon != null) {
      return ImageViewer.asset(
        assetIcon!,
        color: iconColor,
        width: iconSize,
        height: iconSize,
      );
    } else if (url != null) {
      return ImageViewer.cachedNetwork(
        url!,
        color: iconColor,
        width: iconSize,
        height: iconSize,
      );
    } else {
      return const SizedBox.shrink();
    }
  }
}
