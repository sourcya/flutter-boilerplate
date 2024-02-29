import 'package:flutter/material.dart';
import 'package:playx/playx.dart';

abstract class OrientationWidget extends StatelessWidget {
  const OrientationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return context.isLandscape
        ? buildLandscape(context)
        : buildPortrait(
            context,
          );
  }

  Widget buildPortrait(BuildContext context);

  Widget buildLandscape(BuildContext context);
}
