import 'package:flutter/material.dart';
import 'package:playx/playx.dart';

import '../resources/colors/app_colors.dart';
import '../widgets/components/custom_card.dart';
import '../widgets/components/custom_text.dart';

class LoadingOverlay extends StatelessWidget {
  final bool isLoading;
  final String? loadingText;

  const LoadingOverlay({super.key, required this.isLoading, this.loadingText});

  @override
  Widget build(BuildContext context) {
    if (!isLoading) return const SizedBox.shrink();
    return Container(
      color: Colors.black.withOpacity(0.7),
      height: double.infinity,
      child: Center(
        child: CustomCard(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: 8.0.r, vertical: 16.r),
                child: CenterLoading.adaptive(
                  color: context.colors.primary,
                ),
              ),
              if (loadingText != null && loadingText!.isNotEmpty) ...[
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 8.0.r,
                    vertical: 8.r,
                  ),
                  child: CustomText(
                    loadingText ?? '',
                    fontSize: 16.sp,
                    color: context.colors.onSurface,
                  ),
                ),
                SizedBox(height: 16.r),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
