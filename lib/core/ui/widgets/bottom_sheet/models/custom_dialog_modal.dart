part of '../../../ui.dart';

class CustomWoltModalType extends WoltDialogType {
  final double? customWidth;

  CustomWoltModalType({this.customWidth});

  @override
  BoxConstraints layoutModal(Size availableSize) {
    final double availableWidth = availableSize.width;
    double calculatedWidth;

    if (customWidth != null) {
      // Use custom width but ensure it doesn't exceed screen
      calculatedWidth = customWidth!.clamp(0.0, availableWidth * 0.95);
    } else {
      // Responsive logic based strictly on available width
      if (availableWidth <= 480) {
        // Mobile: Almost full width
        calculatedWidth = availableWidth * 0.9;
      } else if (availableWidth <= 900) {
        // Tablet: Proportional width
        calculatedWidth = availableWidth * 0.7;
      } else {
        // Desktop: Narrower percentage to prevent stretching
        // Capped at a maximum comfortable reading width (e.g., 800)
        calculatedWidth = (availableWidth * 0.5).clamp(450.0, 800.0);
      }
    }

    return BoxConstraints(
      minWidth: calculatedWidth,
      maxWidth: calculatedWidth,
      maxHeight: availableSize.height * 0.9,
    );
  }
}
