import 'package:flutter/cupertino.dart';
import 'package:playx/playx.dart';

import '../../components/custom_text.dart';

class BuildModalTitleWidget extends StatelessWidget {
  final String title;

  const BuildModalTitleWidget({
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return CustomText(
      title,
      fontSize: 18.sp,
      fontWeight: FontWeight.w600,
    );
  }
}
