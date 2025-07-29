part of '../../ui.dart';

class StrokeText extends StatelessWidget {
  final String text;
  final Color strokeColor;
  final double strokeWidth;
  final TextStyle? textStyle;
  final TextAlign? textAlign;
  final TextDirection? textDirection;
  final TextScaler? textScaler;
  final TextOverflow? overflow;
  final int? maxLines;

  const StrokeText({
    super.key,
    required this.text,
    this.strokeColor = Colors.amber, // Default stroke color
    this.strokeWidth = 3, // Default stroke width
    this.textStyle,
    this.textAlign,
    this.textDirection,
    this.textScaler,
    this.overflow,
    this.maxLines,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(double.infinity, (textStyle?.fontSize ?? 24) * 1.5),
      painter: _TextPainterWithStroke(
        text: text,
        strokeColor: strokeColor,
        strokeWidth: strokeWidth,
        textStyle: textStyle,
        textAlign: textAlign,
        textDirection: textDirection,
        textScaler: textScaler,
        overflow: overflow,
        maxLines: maxLines,
      ),
    );
  }
}

class _TextPainterWithStroke extends CustomPainter {
  final String text;
  final Color strokeColor;
  final double strokeWidth;
  final TextStyle? textStyle;
  final TextAlign? textAlign;
  final TextDirection? textDirection;
  final TextScaler? textScaler;
  final TextOverflow? overflow;
  final int? maxLines;

  _TextPainterWithStroke({
    required this.text,
    required this.strokeColor,
    required this.strokeWidth,
    this.textStyle,
    this.textAlign,
    this.textDirection,
    this.textScaler,
    this.overflow,
    this.maxLines,
  });

  @override
  void paint(Canvas canvas, Size size) {
    const defaultTextStyle = TextStyle(
      fontSize: 24,
      color: Colors.black,
    );

    final mergedTextStyle = defaultTextStyle.merge(textStyle);

    final strokeTextStyle = mergedTextStyle.copyWith(
      foreground: Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = strokeWidth
        ..color = strokeColor
        ..blendMode = BlendMode.srcOver,
    );

    final mainTextStyle = mergedTextStyle.copyWith(
      color: mergedTextStyle.color ?? Colors.black,
    );

    final strokePainter = TextPainter(
      text: TextSpan(text: text, style: strokeTextStyle),
      textAlign: textAlign ?? TextAlign.start,
      textDirection: textDirection ?? TextDirection.ltr,
      textScaler: textScaler ?? TextScaler.noScaling,
      maxLines: maxLines,
      ellipsis: overflow == TextOverflow.ellipsis ? '...' : null,
    );

    final mainTextPainter = TextPainter(
      text: TextSpan(text: text, style: mainTextStyle),
      textAlign: textAlign ?? TextAlign.start,
      textDirection: textDirection ?? TextDirection.ltr,
      textScaler: textScaler ?? TextScaler.noScaling,
      maxLines: maxLines,
      ellipsis: overflow == TextOverflow.ellipsis ? '...' : null,
    );

    strokePainter.layout(maxWidth: size.width);
    mainTextPainter.layout(maxWidth: size.width);

    final offset = _calculateOffset(strokePainter, size);

    // Draw the stroke first
    strokePainter.paint(canvas, offset);

    // Then draw the main text
    mainTextPainter.paint(canvas, offset);
  }

  // Helper method to calculate the offset based on text alignment
  Offset _calculateOffset(TextPainter painter, Size size) {
    switch (painter.textAlign) {
      case TextAlign.center:
        return Offset(
          (size.width - painter.width) / 2,
          (size.height - painter.height) / 2,
        );
      case TextAlign.end:
        return Offset(
          size.width - painter.width,
          (size.height - painter.height) / 2,
        );
      case TextAlign.left:
        return Offset(
          0,
          (size.height - painter.height) / 2,
        );
      case TextAlign.right:
        return Offset(
          size.width - painter.width,
          (size.height - painter.height) / 2,
        );
      case TextAlign.justify:
      case TextAlign.start:
        return Offset(
          0,
          (size.height - painter.height) / 2,
        );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
