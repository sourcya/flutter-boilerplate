import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoadingViewWidget extends StatelessWidget {
  final String? message;
  final Color? color;
  final double? size;

  const LoadingViewWidget({
    super.key,
    this.message,
    this.color,
    this.size,
  });

  @override
  Widget build(BuildContext context) {
    final indicatorColor = color ?? Theme.of(context).colorScheme.primary;
    final indicatorSize = size ?? 24.0;

    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (Platform.isIOS)
            CupertinoActivityIndicator(
              color: indicatorColor,
              radius: indicatorSize / 1.5,
            )
          else
            SizedBox(
              height: indicatorSize,
              width: indicatorSize,
              child: CircularProgressIndicator(
                strokeWidth: 2.5,
                color: indicatorColor,
              ),
            ),
          if (message != null) ...[
            const SizedBox(height: 12),
            Text(
              message!,
              style: TextStyle(
                color: indicatorColor,
                fontSize: 14,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
