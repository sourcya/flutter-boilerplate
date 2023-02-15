import 'package:flutter/cupertino.dart';

class CenterLoading extends StatelessWidget {
  final Color? color;
  const CenterLoading({
    super.key,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CupertinoActivityIndicator(color: color),
    );
  }
}
