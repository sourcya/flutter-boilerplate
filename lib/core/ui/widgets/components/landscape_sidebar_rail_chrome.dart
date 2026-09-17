part of '../../ui.dart';

/// Sidebar chrome: rounded panel + end bump toggle (landscape rail + portrait drawer).
class LandscapeSidebarRailChrome extends StatelessWidget {
  const LandscapeSidebarRailChrome({
    super.key,
    required this.child,
    required this.expanded,
    required this.onToggle,
    required this.cornerRadius,
    required this.bumpProtrusion,
    required this.sidebarBackground,
    this.leadingCornerRadius,
  });

  final Widget child;
  final bool expanded;
  final VoidCallback onToggle;
  final double cornerRadius;
  final double bumpProtrusion;
  final Color sidebarBackground;
  final double? leadingCornerRadius;

  @override
  Widget build(BuildContext context) {
    final iconInner = 16.0.r;
    final pad = 2.0.r;
    final borderW = 4.0.r;
    final radius = 6.0.r;
    final handle = iconInner + 2 * pad + 2 * borderW;
    final rtl = context.isRtl;
    final icon = rtl
        ? (expanded
            ? Icons.keyboard_double_arrow_right
            : Icons.keyboard_double_arrow_left)
        : (expanded
            ? Icons.keyboard_double_arrow_left
            : Icons.keyboard_double_arrow_right);
    final mq = MediaQuery.of(context);
    final drawerTopPad = max(0.0, mq.viewPadding.top - 12.0.r);
    final isPhoneLandscape = context.isAppLandscape && context.isMobileOrWeb;
    final bumpLogoOffset = isPhoneLandscape ? 44.0.r : 26.0.r;
    final bumpCenterY = drawerTopPad + bumpLogoOffset;
    final tabR = bumpProtrusion;
    final handleInsetEnd = max(0.0, (tabR * 0.92) - (handle / 2.5));
    final handleTop = max(0.0, bumpCenterY - handle / 2.5);

    return ClipPath(
      clipper: _RailBumpClipper(
        bumpProtrusion: bumpProtrusion,
        cornerRadius: cornerRadius,
        leadingCornerRadius: leadingCornerRadius ?? cornerRadius,
        bumpCenterY: bumpCenterY,
        rtl: rtl,
      ),
      child: Material(
        color: sidebarBackground,
        child: Stack(
          fit: StackFit.expand,
          clipBehavior: Clip.none,
          children: [
            Positioned.fill(
              child: Padding(
                padding: EdgeInsetsDirectional.only(end: tabR * 1.05),
                child: child,
              ),
            ),
            PositionedDirectional(
              top: handleTop,
              end: handleInsetEnd,
              child: Material(
                color: AppColors.transparent,
                child: InkWell(
                  onTap: onToggle,
                  borderRadius: radius.radius,
                  child: Container(
                    padding: context.paddingAll(pad),
                    decoration: ShapeDecoration(
                      color: AppColors.basewhite,
                      shape: RoundedRectangleBorder(
                        borderRadius: radius.radius,
                        side: BorderSide(
                          width: borderW,
                          strokeAlign: BorderSide.strokeAlignOutside,
                          color: context.colors.sidebarBackground,
                        ),
                      ),
                    ),
                    child: Icon(
                      icon,
                      size: iconInner,
                      color: context.colors.black,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _RailBumpClipper extends CustomClipper<Path> {
  _RailBumpClipper({
    required this.bumpProtrusion,
    required this.cornerRadius,
    required this.leadingCornerRadius,
    required this.bumpCenterY,
    required this.rtl,
  });

  final double bumpProtrusion;
  final double cornerRadius;
  final double leadingCornerRadius;
  final double bumpCenterY;
  final bool rtl;

  Path _pathLtr(Size size) {
    final w = size.width;
    final h = size.height;
    if (w <= 0 || h <= 0) {
      return Path();
    }

    final bp = bumpProtrusion;
    final r = cornerRadius;
    final lr = leadingCornerRadius;
    final flatW = max(0.0, w - bp);
    if (flatW <= 0) {
      return Path()
        ..addRRect(
          RRect.fromRectAndRadius(Offset.zero & size, Radius.circular(r)),
        );
    }

    final tr = Radius.circular(min(r, max(4.0, flatW * 0.45)));
    final tl = lr > 0 ? Radius.circular(lr) : Radius.zero;
    final bl = lr > 0 ? Radius.circular(lr) : Radius.zero;

    final body = Path()
      ..addRRect(
        RRect.fromRectAndCorners(
          Rect.fromLTWH(0, 0, flatW, h),
          topLeft: tl,
          topRight: tr,
          bottomLeft: bl,
          bottomRight: Radius.circular(r),
        ),
      );

    final safeRadius = min(bp, h / 2);
    final cy = bumpCenterY.clamp(safeRadius, h - safeRadius);
    if (safeRadius <= 0) {
      return body;
    }

    final bump = Path()
      ..addOval(
        Rect.fromCircle(center: Offset(flatW, cy), radius: safeRadius),
      );

    return Path.combine(PathOperation.union, body, bump);
  }

  @override
  Path getClip(Size size) {
    final path = _pathLtr(size);
    if (!rtl) return path;
    if (size.width <= 0 || size.height <= 0) {
      return path;
    }
    final m = Matrix4.identity()
      ..translateByDouble(size.width, 0, 0, 1)
      ..scaleByDouble(-1.0, 1.0, 1.0, 1);
    return path.transform(m.storage);
  }

  @override
  bool shouldReclip(covariant _RailBumpClipper oldClipper) {
    return oldClipper.bumpProtrusion != bumpProtrusion ||
        oldClipper.cornerRadius != cornerRadius ||
        oldClipper.leadingCornerRadius != leadingCornerRadius ||
        oldClipper.bumpCenterY != bumpCenterY ||
        oldClipper.rtl != rtl;
  }
}
