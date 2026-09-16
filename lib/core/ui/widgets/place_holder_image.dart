part of '../ui.dart';

class PlaceholderImageWidget extends StatelessWidget {
  final String? path;
  final EdgeInsetsGeometry? padding;
  const PlaceholderImageWidget({super.key, this.path, this.padding});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          padding ?? context.paddingSymmetric(horizontal: 8.0, vertical: 8.0),
      child: ImageViewer.svgAsset(
        path ?? Assets.images.placeholder,
      ),
    );
  }
}
