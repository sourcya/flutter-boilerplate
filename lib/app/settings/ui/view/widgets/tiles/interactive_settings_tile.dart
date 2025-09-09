part of '../../../imports/settings_imports.dart';

class InteractiveSettingsTile extends StatefulWidget {
  final String title;
  final String? subtitle;
  final IconData icon;
  final VoidCallback? onTap;
  final bool showToggle;
  final bool toggleValue;
  final ValueChanged<bool>? onToggleChanged;
  final IconData? trailingIcon;
  final bool isDangerous;
  final String semanticLabel;

  const InteractiveSettingsTile({
    super.key,
    required this.title,
    this.subtitle,
    required this.icon,
    this.onTap,
    this.showToggle = false,
    this.toggleValue = false,
    this.onToggleChanged,
    this.trailingIcon,
    this.isDangerous = false,
    required this.semanticLabel,
  });

  @override
  State<InteractiveSettingsTile> createState() =>
      _InteractiveSettingsTileState();
}

class _InteractiveSettingsTileState extends State<InteractiveSettingsTile>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  bool _isPressed = false;
  bool _isHovered = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 0.95,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: !widget.showToggle,
      enabled: widget.showToggle,
      label: widget.semanticLabel,
      toggled: widget.toggleValue,
      child: AnimatedBuilder(
        animation: _scaleAnimation,
        builder: (context, child) {
          return Transform.scale(
            scale: _scaleAnimation.value,
            child: GestureDetector(
              onTapDown: (_) {
                setState(() => _isPressed = true);
                _controller.forward();
                HapticFeedback.lightImpact();
              },
              onTapUp: (_) {
                setState(() => _isPressed = false);
                _controller.reverse();
              },
              onTapCancel: () {
                setState(() => _isPressed = false);
                _controller.reverse();
              },
              onTap: widget.showToggle ? null : widget.onTap,
              child: MouseRegion(
                onEnter: (_) => setState(() => _isHovered = true),
                onExit: (_) => setState(() => _isHovered = false),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  margin: EdgeInsets.symmetric(vertical: 6.h),
                  padding: EdgeInsets.all(16.r),
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
                              color: widget.isDangerous
                                  ? Colors.red.withValues(alpha: 0.2)
                                  : context.colors.primary
                                      .withValues(alpha: 0.2),
                              blurRadius: 12,
                              offset: const Offset(0, 4),
                            ),
                          ]
                        : [],
                  ),
                  child: Row(
                    children: [
                      // Icon
                      Container(
                        width: 44.r,
                        height: 44.r,
                        decoration: BoxDecoration(
                          color: _getIconBackgroundColor(context),
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        child: Icon(
                          widget.icon,
                          size: 22.r,
                          color: _getIconColor(context),
                        ),
                      ).animate(target: _isPressed ? 1 : 0).scale(
                            begin: const Offset(1, 1),
                            end: const Offset(1.1, 1.1),
                            duration: 100.ms,
                          ),

                      SizedBox(width: 16.w),

                      // Content
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
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
                                color: context.colors.onSurface
                                    .withValues(alpha: 0.7),
                                maxLines: 2,
                                textOverflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ],
                        ),
                      ),

                      // Trailing
                      if (widget.showToggle)
                        AnimatedToggle(
                          value: widget.toggleValue,
                          onChanged: widget.onToggleChanged,
                        )
                      else if (widget.trailingIcon != null)
                        Icon(
                          widget.trailingIcon,
                          size: 16.r,
                          color:
                              context.colors.onSurface.withValues(alpha: 0.6),
                        )
                            .animate(target: _isHovered ? 1 : 0)
                            .moveX(begin: 0, end: 4, duration: 200.ms),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
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
    if (_isHovered || _isPressed) {
      return context.colors.primary.withValues(alpha: 0.3);
    }
    return context.colors.outline.withValues(alpha: 0.2);
  }

  Color _getIconBackgroundColor(BuildContext context) {
    if (widget.isDangerous) {
      return Colors.red.shade100;
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
