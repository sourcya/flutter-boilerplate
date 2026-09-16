import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:playx/playx.dart';

extension GetUtilsExtensions on GetInterface {
  T? findOrNull<T>() {
    if (isRegistered<T>()) {
      return find<T>();
    } else {
      return null;
    }
  }
}

extension StringAvatarExtensions on String {
  /// First visible character of [displayName] for avatar chips (Unicode-safe).
  String get capitalizedInitialChar {
    final trimmed = this;
    if (trimmed.isEmpty) return '';
    final chars = trimmed.characters;
    if (chars.isEmpty) return '';
    return chars.first.toUpperCase();
  }
}

/// Normalizes nullable filter/query strings: null or empty → null.
extension NullableStringFilterExtensions on String? {
  String? get toNullIfEmpty {
    final value = this;
    if (value == null || value.isEmpty) return null;
    return value;
  }
}

extension JsonStringExtensions on String {
  String get toIndentedJson {
    try {
      final decoded = json.decode(this) as Object?;
      return const JsonEncoder.withIndent('  ').convert(decoded);
    } catch (_) {
      return this;
    }
  }

  String get toFormattedJson {
    try {
      final decoded = json.decode(this);
      return const JsonEncoder.withIndent('  ').convert(decoded as Object?);
    } catch (_) {
      return this;
    }
  }
}

extension DimensionsExt on num {
  SizedBox get hBox => SizedBox(height: toDouble(this).r);
  SizedBox get wBox => SizedBox(width: toDouble(this).r);
  BorderRadius get radius => BorderRadius.circular(toDouble(this).r);
  Radius get radiusCircular => Radius.circular(toDouble(this).r);

  double get clampedR {
    final double value = (this * 1.0).r;
    final double maxValue = this * 1.1;
    return value > maxValue ? maxValue : value;
  }
}

extension PaddingExt on BuildContext {
  EdgeInsetsDirectional paddingOnly({
    double end = 0,
    double top = 0,
    double start = 0,
    double bottom = 0,
  }) {
    return EdgeInsetsDirectional.only(
      end: end.r,
      top: top.r,
      start: start.r,
      bottom: bottom.r,
    );
  }

  EdgeInsetsDirectional paddingSymmetric({
    double horizontal = 0,
    double vertical = 0,
  }) {
    return EdgeInsetsDirectional.symmetric(
      horizontal: horizontal.r,
      vertical: vertical.r,
    );
  }

  EdgeInsetsDirectional paddingAll(double value) {
    return EdgeInsetsDirectional.all(value.r);
  }

  EdgeInsets paddingZero() => EdgeInsets.zero;
}

extension IntExtensions on int? {
  int? get nonIntZero => (this == null || this == 0) ? null : this;
}

extension DoubleExtensions on double? {
  double? get nonDoubleZero => (this == null || this == 0) ? null : this;
}

extension CrossAxisCountExt on BuildContext {
  /// Returns the number of grid columns based on the current screen width.
  ///
  /// - 3 columns when width >= 1400
  /// - 2 columns when width >= 840
  /// - 1 column otherwise
  int crossAxisCount({
    double wideBreakpoint = 1400,
    double mediumBreakpoint = 840,
  }) {
    final width = this.width;
    if (width >= wideBreakpoint) return 3;
    if (width >= mediumBreakpoint) return 2;
    return 1;
  }
}

extension BoolExtensions on Widget {
  Widget expandIf(bool condition) => condition ? Expanded(child: this) : this;
}
