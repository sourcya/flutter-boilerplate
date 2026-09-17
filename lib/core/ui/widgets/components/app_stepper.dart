part of '../../ui.dart';

enum AppStepperStepStatus { completed, active, upcoming }

class AppStepperStep {
  const AppStepperStep({
    required this.number,
    required this.label,
    required this.status,
  });

  final int number;
  final String label;
  final AppStepperStepStatus status;

  bool get isCompleted => status == AppStepperStepStatus.completed;
}

/// Figma facility-form stepper. Horizontal by default.
class AppStepper extends StatelessWidget {
  const AppStepper({
    super.key,
    required this.steps,
    this.isVertical = false,
    this.isExpandHorizontal = false,
    this.accentColor,
    this.upcomingColor,
  });

  final List<AppStepperStep> steps;
  final bool isVertical;

  /// When true, horizontal steps and connectors expand to fill available width.
  final bool isExpandHorizontal;

  /// Active/completed step color. Defaults to [AppColors.stepperAccent].
  final Color? accentColor;

  /// Upcoming step color. Defaults to theme muted foreground.
  final Color? upcomingColor;

  /// Builds steps from a zero-based [currentIndex].
  static List<AppStepperStep> fromLabels({
    required List<String> items,
    required int currentIndex,
  }) {
    return [
      for (int index = 0; index < items.length; index++)
        AppStepperStep(
          number: index + 1,
          label: items[index],
          status: index < currentIndex
              ? AppStepperStepStatus.completed
              : index == currentIndex
              ? AppStepperStepStatus.active
              : AppStepperStepStatus.upcoming,
        ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    if (steps.isEmpty) return const SizedBox.shrink();

    final activeColor = accentColor ?? context.colors.primary;
    final inactiveColor = upcomingColor ?? context.colors.mutedForeground;
    final indicatorSurface = context.isDarkMode
        ? context.colors.settingsChipSurface
        : AppColors.stepperIndicatorSurface;
    final completedIconColor = context.isDarkMode
        ? context.colors.onPrimary
        : AppColors.stepperCompletedIcon;

    Widget segment(Widget child, {required bool isConnector}) {
      if (isVertical) return child;
      if (isExpandHorizontal) {
        return Expanded(child: child);
      }
      if (isConnector) {
        return SizedBox(width: 32.r, child: child);
      }
      return ConstrainedBox(
        constraints: BoxConstraints(minWidth: 64.r),
        child: child,
      );
    }

    final children = <Widget>[];
    for (int i = 0; i < steps.length; i++) {
      if (i > 0) {
        final connectorColor = steps[i - 1].isCompleted
            ? activeColor
            : inactiveColor;

        children.add(
          segment(
            isVertical
                ? Padding(
                    padding: context.paddingOnly(start: 16),
                    child: SizedBox(
                      height: 32.r,
                      width: 1.r,
                      child: ColoredBox(color: connectorColor),
                    ),
                  )
                : SizedBox(
                    height: 32.r,
                    child: Center(
                      child: Divider(
                        height: 1.r,
                        thickness: 1.r,
                        color: connectorColor,
                      ),
                    ),
                  ),
            isConnector: true,
          ),
        );
      }

      final step = steps[i];
      final isUpcoming = step.status == AppStepperStepStatus.upcoming;
      final stepColor = isUpcoming ? inactiveColor : activeColor;

      final indicator = Container(
        width: 32.r,
        height: 32.r,
        padding: context.paddingAll(6),
        clipBehavior: Clip.antiAlias,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: step.isCompleted ? activeColor : indicatorSurface,
          borderRadius: 12.radius,
          border: Border.all(color: stepColor, width: 1.r),
        ),
        child: step.isCompleted
            ? IconInfo.icon(
                Icons.check,
              ).buildIconWidget(size: 16.r, color: completedIconColor)
            : CustomText(
                '${step.number}',
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: stepColor,
                isTranslatable: false,
              ),
      );

      final title = CustomText(
        step.label,
        fontSize: 14.sp,
        fontWeight: FontWeight.w600,
        color: stepColor,
        textAlign: isVertical ? TextAlign.start : TextAlign.center,
        maxLines: isVertical ? 3 : 2,
        overflow: TextOverflow.ellipsis,
        isTranslatable: false,
      );

      children.add(
        segment(
          isVertical
              ? Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 12.r,
                  children: [
                    indicator,
                    Expanded(
                      child: Padding(
                        padding: context.paddingOnly(top: 6),
                        child: title,
                      ),
                    ),
                  ],
                )
              : Column(
                  mainAxisSize: MainAxisSize.min,
                  spacing: 4.r,
                  children: [indicator, title],
                ),
          isConnector: false,
        ),
      );
    }

    if (isVertical) {
      return Flex(
        direction: Axis.vertical,
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 8.r,
        children: children,
      );
    }

    if (isExpandHorizontal) {
      return SizedBox(
        width: context.width,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: children,
        ),
      );
    }

    return Center(
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: children,
        ),
      ),
    );
  }
}
