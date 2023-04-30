import 'package:flutter/cupertino.dart';

///Widget that displays a simple circle indicator like in ios
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
