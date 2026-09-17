part of '../../../ui.dart';

abstract class Gap {
  const Gap._();

  static SizedBox get none => const SizedBox.shrink();
  static SizedBox get xs => SizedBox.square(dimension: Spacing.xs);
  static SizedBox get sm => SizedBox.square(dimension: Spacing.sm);
  static SizedBox get smd => SizedBox.square(dimension: Spacing.smd);
  static SizedBox get md => SizedBox.square(dimension: Spacing.md);
  static SizedBox get lg => SizedBox.square(dimension: Spacing.lg);
  static SizedBox get xl => SizedBox.square(dimension: Spacing.xl);
  static SizedBox custom(double size) => SizedBox.square(dimension: size.r);
}

abstract class HGap {
  HGap._();

  static SizedBox get none => const SizedBox.shrink();
  static SizedBox get xs => SizedBox(width: Spacing.xs);
  static SizedBox get sm => SizedBox(width: Spacing.sm);
  static SizedBox get md => SizedBox(width: Spacing.md);
  static SizedBox get lg => SizedBox(width: Spacing.lg);
  static SizedBox get xl => SizedBox(width: Spacing.xl);
  static SizedBox custom(double width) => SizedBox(width: width.r);
}

abstract class VGap {
  VGap._();

  static SizedBox get none => const SizedBox.shrink();
  static SizedBox get xs => SizedBox(height: Spacing.xs);
  static SizedBox get sm => SizedBox(height: Spacing.sm);
  static SizedBox get md => SizedBox(height: Spacing.md);
  static SizedBox get lg => SizedBox(height: Spacing.lg);
  static SizedBox get xl => SizedBox(height: Spacing.xl);
  static SizedBox custom(double height) => SizedBox(height: height.r);
}
