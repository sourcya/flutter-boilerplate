import 'package:flutter/material.dart';

/// OrientationWidget : Widget that can be used to build different widgets for different orientations.
abstract class CustomOrientationWidget extends StatelessWidget {
  const CustomOrientationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final child = MediaQuery.of(context).orientation == Orientation.landscape
        ? buildLandscape(context)
        : buildPortrait(
            context,
          );
    final widget = buildWidget(context, child);
    return widget ?? child;
  }

  Widget? buildWidget(BuildContext context, Widget child) => null;

  /// Builds the widget for portrait orientation.
  Widget buildPortrait(BuildContext context);

  /// Builds the widget for landscape orientation.
  Widget buildLandscape(BuildContext context);
}
