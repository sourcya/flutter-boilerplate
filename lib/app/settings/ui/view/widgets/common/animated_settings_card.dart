part of '../../../imports/settings_imports.dart';

class AnimatedSettingsCard extends StatefulWidget {
  final String title;
  final IconData icon;
  final Widget child;
  final int delay;

  const AnimatedSettingsCard({
    super.key,
    required this.title,
    required this.icon,
    required this.child,
    this.delay = 0,
  });

  @override
  State<AnimatedSettingsCard> createState() => _AnimatedSettingsCardState();
}

class _AnimatedSettingsCardState extends State<AnimatedSettingsCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _expandAnimation;
  bool _isExpanded = true;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _expandAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      decoration: BoxDecoration(
        color: context.colors.surfaceContainer,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: context.colors.shadow.withValues(alpha: 0.08),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          // Header
          InkWell(
            onTap: () {
              setState(() {
                _isExpanded = !_isExpanded;
                if (_isExpanded) {
                  _controller.forward();
                } else {
                  _controller.reverse();
                }
              });
              HapticFeedback.lightImpact();
            },
            borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
            child: Container(
              padding: EdgeInsets.all(16.r),
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(8.r),
                    decoration: BoxDecoration(
                      color: context.colors.primary.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: Icon(
                      widget.icon,
                      size: 20.r,
                      color: context.colors.primary,
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: CustomText(
                      widget.title,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  AnimatedRotation(
                    turns: _isExpanded ? 0 : -0.5,
                    duration: const Duration(milliseconds: 300),
                    child: Icon(
                      Icons.expand_more,
                      size: 24.r,
                      color: context.colors.onSurface.withValues(alpha: 0.6),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Content
          SizeTransition(
            sizeFactor: _expandAnimation,
            child: Padding(
              padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 16.h),
              child: widget.child,
            ),
          ),
        ],
      ),
    )
        .animate(delay: widget.delay.ms)
        .fadeIn(duration: 600.ms)
        .slideX(begin: -0.1, end: 0)
        .then()
        .shimmer(
          duration: 1500.ms,
          color: context.colors.primary.withValues(alpha: 0.1),
        );
  }
}
