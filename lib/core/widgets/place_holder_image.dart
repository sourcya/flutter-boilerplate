import 'package:flutter/material.dart';
import 'package:playx/playx.dart';

import '../resources/assets/assets.dart';

class PlaceholderImageWidget extends StatelessWidget {
  final String? path;
  final EdgeInsetsGeometry? padding;
  const PlaceholderImageWidget({super.key, this.path, this.padding});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          padding ?? EdgeInsets.symmetric(horizontal: 8.0.r, vertical: 8.0.r),
      child: ImageViewer.svgAsset(
        path ?? Assets.images.placeholder,
      ),
    );
  }
}
