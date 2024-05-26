import 'package:flutter/cupertino.dart';
import 'package:playx/playx.dart';

import '../../components/custom_text.dart';

class BuildModalTitleWidget extends StatelessWidget {
  final String title;
  final VoidCallback? onTitlePressed;

  const BuildModalTitleWidget({
    required this.title,
    this.onTitlePressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTitlePressed,
      child: CustomText(
        title,
        fontSize: 18.sp,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}
