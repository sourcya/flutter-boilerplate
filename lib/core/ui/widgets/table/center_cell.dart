part of '../../ui.dart';

/// Centers [child] within a table [DataCell].
class CenterCell extends StatelessWidget {
  final Widget child;

  const CenterCell({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentDirectional.center,
      child: child,
    );
  }
}
