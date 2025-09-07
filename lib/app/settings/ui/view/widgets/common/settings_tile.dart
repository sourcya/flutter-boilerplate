part of '../../../imports/settings_imports.dart';

class BuildSettingsTile extends StatefulWidget {
  final String title;
  final String? subtitle;
  final IconData? icon;
  final String? svgIcon;
  final VoidCallback onTap;
  final bool? isSelected;
  final ValueChanged<bool?>? onSelectionChanged;
  final EdgeInsetsGeometry? padding;
  final double? size;
  final bool showToggle;
  final String? badgeText;
  final Color? badgeColor;
  final IconData? trailingIcon;
  final bool isDangerous;
  final Widget? customTrailing;

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
    this.showToggle = false,
    this.badgeText,
    this.badgeColor,
    this.trailingIcon,
    this.isDangerous = false,
    this.customTrailing,
  });

  @override
  State<BuildSettingsTile> createState() => _BuildSettingsTileState();
}

class _BuildSettingsTileState extends State<BuildSettingsTile>
    with TickerProviderStateMixin {
  late AnimationController _scaleController;
  late AnimationController _shimmerController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _shimmerAnimation;

  bool _isPressed = false;
  bool _isHovered = false;

  @override
  void initState() {
    super.initState();
    _scaleController = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
    );
    _shimmerController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 0.95,
    ).animate(CurvedAnimation(
      parent: _scaleController,
      curve: Curves.easeInOut,
    ));

    _shimmerAnimation = Tween<double>(
      begin: -1.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _shimmerController,
      curve: Curves.easeInOut,
    ));

    // Start shimmer animation for important items
    if (widget.showToggle && widget.isSelected == true) {
      _shimmerController.repeat();
    }
  }

  @override
  void dispose() {
    _scaleController.dispose();
    _shimmerController.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(BuildSettingsTile oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.showToggle &&
        widget.isSelected == true &&
        !_shimmerController.isAnimating) {
      _shimmerController.repeat();
    } else if (widget.isSelected != true) {
      _shimmerController.stop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _scaleAnimation,
      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnimation.value,
          child: GestureDetector(
            onTapDown: (_) {
              setState(() => _isPressed = true);
              _scaleController.forward();
              HapticFeedback.lightImpact();
            },
            onTapUp: (_) {
              setState(() => _isPressed = false);
              _scaleController.reverse();
            },
            onTapCancel: () {
              setState(() => _isPressed = false);
              _scaleController.reverse();
            },
            onTap: widget.onTap,
            child: MouseRegion(
              onEnter: (_) => setState(() => _isHovered = true),
              onExit: (_) => setState(() => _isHovered = false),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                margin: EdgeInsets.symmetric(horizontal: 4.w, vertical: 6.h),
                decoration: BoxDecoration(
                  color: _getBackgroundColor(context),
                  borderRadius: BorderRadius.circular(16.r),
                  border: Border.all(
                    color: _getBorderColor(context),
                    width: 1.5,
                  ),
                  boxShadow: _isHovered || _isPressed
                      ? [
                          BoxShadow(
                            color:
                                context.colors.primary.withValues(alpha: 0.2),
                            blurRadius: 12,
                            offset: const Offset(0, 4),
                          ),
                        ]
                      : [],
                ),
                child: Stack(
                  children: [
                    // Shimmer overlay for active toggles
                    if (widget.showToggle && widget.isSelected == true)
                      AnimatedBuilder(
                        animation: _shimmerAnimation,
                        builder: (context, child) {
                          return Positioned.fill(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(16.r),
                              child: Container(
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment(
                                        -1.0 + _shimmerAnimation.value, 0.0),
                                    end: Alignment(
                                        1.0 + _shimmerAnimation.value, 0.0),
                                    colors: [
                                      Colors.transparent,
                                      context.colors.primary
                                          .withValues(alpha: 0.1),
                                      Colors.transparent,
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    // Main content
                    Padding(
                      padding: widget.padding ??
                          EdgeInsets.symmetric(
                              horizontal: 16.w, vertical: 16.h),
                      child: Row(
                        children: [
                          // Leading icon
                          _buildLeadingIcon(context),
                          SizedBox(width: 16.w),

                          // Content
                          Expanded(child: _buildContent(context)),

                          // Trailing elements
                          _buildTrailing(context),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildLeadingIcon(BuildContext context) {
    return Hero(
      tag: '${widget.title}_icon',
      child: Container(
        width: 44.r,
        height: 44.r,
        decoration: BoxDecoration(
          color: _getIconBackgroundColor(context),
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Center(
          child: IconViewer(
            icon: widget.icon,
            svgIcon: widget.svgIcon ?? '',
            iconColor: _getIconColor(context),
            width: widget.size ?? 22.r,
            height: widget.size ?? 22.r,
          ),
        ),
      ).animate(target: _isPressed ? 1 : 0).scale(
            begin: const Offset(1, 1),
            end: const Offset(1.1, 1.1),
            duration: 100.ms,
          ),
    );
  }

  Widget _buildContent(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CustomText(
          widget.title,
          fontSize: 16.sp,
          fontWeight: FontWeight.w600,
          color: widget.isDangerous
              ? Colors.red.shade700
              : context.colors.onSurface,
        ),
        if (widget.subtitle != null) ...[
          SizedBox(height: 4.h),
          CustomText(
            widget.subtitle!,
            fontSize: 13.sp,
            color: context.colors.onSurface.withValues(alpha: 0.7),
            height: 1.3,
            maxLines: 2,
            textOverflow: TextOverflow.ellipsis,
          ),
        ],
      ],
    );
  }

  Widget _buildTrailing(BuildContext context) {
    final List<Widget> trailingWidgets = [];

    // Badge
    if (widget.badgeText != null) {
      trailingWidgets.add(
        Container(
          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
          decoration: BoxDecoration(
            color: widget.badgeColor ?? context.colors.primary,
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: CustomText(
            widget.badgeText!,
            fontSize: 10.sp,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ).animate().fadeIn(delay: 200.ms).scale(),
      );
    }

    // Toggle Switch
    if (widget.showToggle && widget.isSelected != null) {
      trailingWidgets.add(
        AnimatedToggleSwitch(
          value: widget.isSelected!,
          onChanged: widget.onSelectionChanged,
        ),
      );
    }

    // Custom trailing widget
    if (widget.customTrailing != null) {
      trailingWidgets.add(widget.customTrailing!);
    }

    // Trailing icon
    if (widget.trailingIcon != null) {
      trailingWidgets.add(
        Icon(
          widget.trailingIcon,
          size: 16.r,
          color: context.colors.onSurface.withValues(alpha: 0.6),
        ).animate(target: _isHovered ? 1 : 0).moveX(
              begin: 0,
              end: 4,
              duration: 200.ms,
            ),
      );
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: trailingWidgets
          .map((widget) => Padding(
                padding: EdgeInsets.only(left: 8.w),
                child: widget,
              ))
          .toList(),
    );
  }

  Color _getBackgroundColor(BuildContext context) {
    if (widget.isDangerous && (_isHovered || _isPressed)) {
      return Colors.red.shade50;
    }
    if (_isPressed) {
      return context.colors.primary.withValues(alpha: 0.1);
    }
    if (_isHovered) {
      return context.colors.surfaceContainer;
    }
    return context.colors.surface;
  }

  Color _getBorderColor(BuildContext context) {
    if (widget.isDangerous && (_isHovered || _isPressed)) {
      return Colors.red.shade200;
    }
    if (widget.isSelected == true && widget.showToggle) {
      return context.colors.primary.withValues(alpha: 0.5);
    }
    if (_isHovered || _isPressed) {
      return context.colors.primary.withValues(alpha: 0.3);
    }
    return context.colors.outline.withValues(alpha: 0.2);
  }

  Color _getIconBackgroundColor(BuildContext context) {
    if (widget.isDangerous) {
      return Colors.red.shade100;
    }
    if (widget.isSelected == true && widget.showToggle) {
      return context.colors.primary.withValues(alpha: 0.2);
    }
    return context.colors.primary.withValues(alpha: 0.1);
  }

  Color _getIconColor(BuildContext context) {
    if (widget.isDangerous) {
      return Colors.red.shade700;
    }
    return context.colors.primary;
  }
}

class AnimatedToggleSwitch extends StatefulWidget {
  final bool value;
  final ValueChanged<bool?>? onChanged;

  const AnimatedToggleSwitch({
    super.key,
    required this.value,
    this.onChanged,
  });

  @override
  State<AnimatedToggleSwitch> createState() => _AnimatedToggleSwitchState();
}

class _AnimatedToggleSwitchState extends State<AnimatedToggleSwitch>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  // late Animation<double> _thumbAnimation;
  late Animation<Color?> _trackAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );

    // _thumbAnimation = Tween<double>(
    //   begin: 0.0,
    //   end: 1.0,
    // ).animate(CurvedAnimation(
    //   parent: _controller,
    //   curve: Curves.easeInOut,
    // ));

    if (widget.value) {
      _controller.value = 1.0;
    }
  }

  @override
  void didUpdateWidget(AnimatedToggleSwitch oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.value != oldWidget.value) {
      if (widget.value) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _trackAnimation = ColorTween(
      begin: context.colors.outline.withValues(alpha: 0.3),
      end: context.colors.primary,
    ).animate(_controller);

    return GestureDetector(
      onTap: () {
        // ignore: prefer_null_aware_method_calls
        if (widget.onChanged != null) widget.onChanged!(!widget.value);
      },
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Container(
            width: 48.w,
            height: 28.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14.r),
              color: _trackAnimation.value,
            ),
            child: Stack(
              children: [
                AnimatedPositioned(
                  duration: const Duration(milliseconds: 200),
                  curve: Curves.easeInOut,
                  left: widget.value ? 20.w : 2.w,
                  top: 2.h,
                  child: Container(
                    width: 24.r,
                    height: 24.r,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.2),
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                  ).animate().scale(
                        begin: const Offset(0.8, 0.8),
                        end: const Offset(1, 1),
                        duration: 200.ms,
                      ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
