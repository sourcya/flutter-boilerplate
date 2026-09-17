part of '../../../ui.dart';

abstract class SpacingConstants {
  const SpacingConstants._();

  static const double rawNone = 0;
  static const double rawPx = 1;
  static const double rawXxs = 2;
  static const double rawXs = 4;
  static const double rawXs2 = 6;
  static const double rawSm = 8;
  static const double rawSmd = 12;
  static const double rawMd = 16;
  static const double rawMdl = 20;
  static const double rawLg = 24;
  static const double rawXl = 32;
  static const double rawXxl = 40;
  static const double rawXxxl = 48;
  static const double rawHuge = 64;

  static double get none => rawNone;
  static double get px => rawPx.r;
  static double get xxs => rawXxs.r;
  static double get xs => rawXs.r;
  static double get xs2 => rawXs2.r;
  static double get sm => rawSm.r;
  static double get smd => rawSmd.r;
  static double get md => rawMd.r;
  static double get mdl => rawMdl.r;
  static double get lg => rawLg.r;
  static double get xl => rawXl.r;
  static double get xxl => rawXxl.r;
  static double get xxxl => rawXxxl.r;
  static double get huge => rawHuge.r;

  static double get iconText => sm;
  static double get cardInternal => md;
  static double get formField => md;
  static double get screenHorizontal => md;
  static double get screenVertical => md;
}

typedef Spacing = SpacingConstants;
