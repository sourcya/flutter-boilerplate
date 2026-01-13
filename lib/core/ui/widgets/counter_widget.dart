part of '../ui.dart';

class CounterWidget extends StatefulWidget {
  final double initialValue;
  final double minValue;
  final double maxValue;
  final bool allowDecimal;
  final int decimalPlaces;
  final ValueChanged<double>? onValueChanged;
  final ValueChanged<bool>? onValidationChange;
  final FormFieldValidator<double>? validator;
  final bool includeTextField;
  final bool isMaxWidth;
  final BorderRadius? borderRadius;
  final Border? border;
  final VisualDensity visualDensity;
  final String? label;
  final bool enabled;
  final FocusNode? focusNode;
  final String? hintText;
  final String? suffixText;
  final TextAlign textAlign;
  final EdgeInsetsGeometry? padding;

  final EdgeInsetsGeometry? labelPadding;

  final double? iconSize;

  final bool isSmall;
  final bool isPlainStyle;

  const CounterWidget({
    super.key,
    this.initialValue = 0,
    this.minValue = 0,
    this.maxValue = double.infinity,
    this.allowDecimal = true,
    this.decimalPlaces = 5, // Default, can be changed
    this.onValueChanged,
    this.onValidationChange,
    this.validator,
    this.includeTextField = true,
    this.isMaxWidth = false,
    this.suffixText,
    this.borderRadius,
    this.border,
    this.visualDensity = VisualDensity.standard,
    this.label,
    this.enabled = true,
    this.focusNode,
    this.hintText,
    this.textAlign = TextAlign.center,
    this.padding,
    this.labelPadding,
    this.iconSize,
    this.isSmall = false,
    this.isPlainStyle = false,
  });

  @override
  State<CounterWidget> createState() => _CounterWidgetState();
}

class _CounterWidgetState extends State<CounterWidget> {
  late double _count;
  late TextEditingController textController;
  String? error;

  @override
  void initState() {
    super.initState();
    _count = widget.initialValue.clamp(widget.minValue, widget.maxValue);
    textController = TextEditingController();
    _updateTextControllerFromCount(); // Initialize text field

    if (widget.validator != null) {
      // error = widget.validator!(_count);
      // widget.onValidationChange?.call(error == null);
    }
  }

  void _updateTextControllerFromCount() {
    final formattedValue = toLocalizedEnglishNumber(
      _count,
      widget.allowDecimal ? widget.decimalPlaces : 0,
    );
    textController.value = TextEditingValue(
      text: formattedValue,
      selection: TextSelection.collapsed(offset: formattedValue.length),
    );
  }

  String arabicToWesternNumber(String input) {
    const arabicToWesternMap = {
      '٠': '0',
      '١': '1',
      '٢': '2',
      '٣': '3',
      '٤': '4',
      '٥': '5',
      '٦': '6',
      '٧': '7',
      '٨': '8',
      '٩': '9',
    };
    return input.split('').map((e) => arabicToWesternMap[e] ?? e).join();
  }

  void updateValue(double newValue, {bool updateController = true}) {
    final clampedValue = newValue.clamp(widget.minValue, widget.maxValue);
    if (_count == clampedValue) {
      // If the effective value hasn't changed (e.g. due to clamping),
      // still update the text field if the input was different, like "007" -> 7
      if (updateController) _updateTextControllerFromCount();
      return;
    }

    _count = clampedValue;
    if (widget.validator != null) {
      error = widget.validator!(_count);
      widget.onValidationChange?.call(error == null);
    }
    widget.onValueChanged?.call(_count);
    if (updateController) {
      _updateTextControllerFromCount();
    }
    if (mounted) {
      setState(() {});
    }
  }

  TextEditingValue formatNumber(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (newValue.text.isEmpty) {
      updateValue(
        widget.minValue,
      ); // Or 0, depending on desired behavior for empty input
      return newValue;
    }
    if (newValue.text == "-") {
      // Allow typing "-" as a precursor to a negative number
      // Don't update _count yet, or update to 0 if preferred
      return newValue;
    }

    final westernText = arabicToWesternNumber(newValue.text);
    final parsedValue = int.tryParse(westernText);

    if (parsedValue == null) {
      // updateValue(_count, updateController: false); // Keep current _count, revert text
      return oldValue;
    }

    if (parsedValue < widget.minValue || parsedValue > widget.maxValue) {
      // updateValue(_count, updateController: false); // Keep current _count, revert text
      // To provide better feedback, let the user see what they typed if it's partially valid
      // but then clamp it in the onEditingComplete or onFocusChange or rely on validator.
      // For now, strict reversion:
      return oldValue;
    }

    updateValue(
      parsedValue.toDouble(),
      updateController: false,
    ); // Don't update controller, it will be newValue
    return newValue; // Return newValue as it has passed filters and basic parsing
  }

  TextEditingValue formatDecimalNumber(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (!widget.enabled) return oldValue;

    // 1. Normalize incoming newValue: replace Arabic decimal '٫' with period '.'
    //    This makes the rest of the logic and regex matching simpler.
    final String textToProcess = newValue.text.replaceAll('٫', '.');
    final TextEditingValue currentVal = TextEditingValue(
      text: textToProcess,
      selection: newValue.selection,
      // composing: newValue.composing, // Important if handling IME composing text
    );

    if (currentVal.text.isEmpty) {
      // If user deletes everything, what should _count be?
      // Option A: revert to minValue
      updateValue(widget.minValue, updateController: false);
      // Option B: signify an "empty" state if your _count can be null or have a special "not set" value.
      // For now, let's assume minValue.
      return currentVal; // Return the empty text
    }

    if (currentVal.text == "-" || currentVal.text == ".") {
      // Allow these as intermediate inputs. Don't update _count yet.
      // Or, if text is just "-", _count could be 0 or remain as is.
      // If text is just ".", _count could be 0 or remain as is.
      return currentVal;
    }

    // Prevent "-." or ".-" after normalization
    if (currentVal.text == "-." ||
        (currentVal.text.startsWith(".-") && currentVal.text.length > 1)) {
      return oldValue; // Revert to the actual previous state
    }

    // 2. Convert all numerals to Western for parsing
    final westernText = arabicToWesternNumber(currentVal.text);
    // 3. Try to parse
    final parsedValue = double.tryParse(westernText);

    if (parsedValue == null) {
      // Not a full number yet. Could be "123." or invalid.
      if (westernText.endsWith('.') &&
          westernText.indexOf('.') == westernText.lastIndexOf('.')) {
        // It's like "123." or just "."
        final beforeDot = westernText.substring(0, westernText.length - 1);
        // Check if the part before the dot is a valid number and within bounds (optional for intermediate state)
        final tempParse = double.tryParse(
          beforeDot.isEmpty ? "0" : beforeDot,
        ); // For ".", tempParse is 0
        if (tempParse != null) {
          // Optional: Check bounds even for intermediate "123."
          // if (tempParse >= widget.minValue && tempParse <= widget.maxValue) {
          // Don't update _count yet, let user finish.
          return currentVal; // Allow user to continue typing (e.g. "123.")
          // } else {

          //     return oldValue;
          // }
        }
        // If "abc." -> tempParse is null, falls through
      }
      return oldValue; // Revert to the actual previous state
    }

    // 4. Parsed successfully. Check bounds.
    // The regex already limits decimal places for TYPING, but pasted text might exceed it.
    // However, the regex is applied by FilteringTextInputFormatter BEFORE this function.
    // So, we mostly trust the number of decimal places from the regex.
    // The main concern here is min/max value.

    if (parsedValue < widget.minValue || parsedValue > widget.maxValue) {
      // updateValue(_count, updateController: false); // Keep current _count, revert text
      return oldValue; // Revert to the actual previous state
    }

    // 5. Valid number and within bounds. Update internal _count.
    // DO NOT update the textController from _count here. `currentVal` is what the user sees.
    updateValue(parsedValue, updateController: false);

    return currentVal; // Return the text as typed (and dot-normalized), which is now validated.
  }

  void _onEditingComplete() {
    // Final processing when editing is done (e.g. user presses done or focus changes)
    String currentText = arabicToWesternNumber(textController.text);

    // Handle cases like ".", "-", or empty string if they are still in the field
    if (currentText.isEmpty || currentText == "." || currentText == "-") {
      updateValue(
        widget.minValue.clamp(widget.minValue, widget.maxValue),
      ); // Or some other default
      _updateTextControllerFromCount();
      return;
    }
    // Handle if text ends with "." like "123." -> "123"
    if (currentText.endsWith('.') &&
        currentText.indexOf('.') == currentText.lastIndexOf('.')) {
      currentText = currentText.substring(0, currentText.length - 1);
      if (currentText.isEmpty || currentText == "-") {
        // e.g. if original was just "." or "-."
        updateValue(widget.minValue.clamp(widget.minValue, widget.maxValue));
        _updateTextControllerFromCount();
        return;
      }
    }

    double? finalValue = double.tryParse(currentText);

    if (finalValue == null) {
      // This shouldn't happen if formatters are working, but as a fallback:
      updateValue(_count); // Reset to last known good _count
    } else {
      // Clamp and format properly
      finalValue = finalValue.clamp(widget.minValue, widget.maxValue);
      // Ensure correct number of decimal places after editing complete
      final String formattedFinalValue = finalValue.toStringAsFixed(
        widget.allowDecimal ? widget.decimalPlaces : 0,
      );
      finalValue = double.parse(
        formattedFinalValue,
      ); // re-parse to avoid precision issues from toStringAsFixed

      updateValue(finalValue); // This will call _updateTextControllerFromCount
    }
    _updateTextControllerFromCount(); // Ensure controller reflects the final _count
    // Validate one last time
    if (widget.validator != null) {
      error = widget.validator!(_count);
      widget.onValidationChange?.call(error == null);
      if (mounted) {
        setState(() {});
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final inputFormatters = widget.allowDecimal
        ? [
            FilteringTextInputFormatter.deny(
              ',',
              replacementString: '.',
            ),
            FilteringTextInputFormatter.allow(
              // Allow optional "-", digits (Arabic or Eng), optional [.\٫] (period OR Arabic decimal separator),
              // and 0 to X decimal places
              RegExp(
                r'^-?[٠-٩\d]*[.\٫]?[٠-٩\d]{0,'
                '${widget.decimalPlaces}'
                r'}$',
              ),
            ),
            TextInputFormatter.withFunction(formatDecimalNumber),
          ]
        : [
            FilteringTextInputFormatter.allow(
              RegExp(r'^-?[٠-٩\d]+$'),
            ),
            TextInputFormatter.withFunction(formatNumber),
          ];

    final Widget fieldWidget = TextFormField(
      controller: textController,
      enabled: widget.enabled,
      focusNode: widget.focusNode,
      textAlign: widget.textAlign,
      keyboardType: TextInputType.numberWithOptions(
        decimal: widget.allowDecimal,
        signed: true, // Allows negative num// bers
      ),
      style: TextStyle(
        fontSize: 16.sp,
        fontWeight: FontWeight.w500,
        fontFamily: fontFamily(context: context),
        color: widget.enabled
            ? (widget.isPlainStyle
                  ? context.colors.onSurface
                  : context.colors.onPrimaryContainer)
            : Colors.grey,
      ),
      inputFormatters: inputFormatters,
      decoration: InputDecoration(
        border: InputBorder.none,
        enabledBorder: InputBorder.none,
        focusedBorder: InputBorder.none,
        errorBorder: OutlineInputBorder(
          borderRadius: widget.borderRadius ?? Style.fieldBorderRadius,
          borderSide: BorderSide(color: context.colors.error, width: 1.0.r),
        ),
        hintText: widget.hintText,
        suffixText: widget.suffixText,
        suffixStyle: TextStyle(
          fontSize: 16.sp,
          fontWeight: FontWeight.w500,
          color: widget.enabled
              ? (widget.isPlainStyle
                    ? context.colors.onSurface
                    : context.colors.onPrimaryContainer)
              : Colors.grey,
          fontFamily: fontFamily(context: context),
        ),
        // Remove internal padding of TextFormField to make it fit better
        isDense: true,
        contentPadding: EdgeInsets.zero,
      ),
      textInputAction: TextInputAction.done,
      onTapOutside: (_) => FocusManager.instance.primaryFocus?.unfocus(),
      onFieldSubmitted: (_) {
        // Handle submission, e.g. when user presses "done" on keyboard
        FocusManager.instance.primaryFocus?.unfocus();
      },
      onChanged: (text) {
        // `onChanged` gives the final text after formatters.
        // We've already updated _count within the formatters or will do so in onEditingComplete.
        // However, direct validation feedback can be useful here.
        // The formatters handle most of the live updates to _count.
        // For live validation based on the formatted text:
        final westernText = arabicToWesternNumber(text);
        final currentValue = widget.allowDecimal
            ? double.tryParse(westernText)
            : int.tryParse(westernText)?.toDouble();
        if (currentValue != null && widget.validator != null) {
          setState(() {
            error = widget.validator!(currentValue);
          });
          widget.onValidationChange?.call(error == null);
        } else if (currentValue == null &&
            text.isNotEmpty &&
            text != "-" &&
            text != ".") {
          // If text is invalid but not just an initial "-", ".", trigger validation error
          if (widget.validator != null) {
            // Cannot pass null to validator, so handle this state
            setState(() {
              error = "Invalid input"; // Or a more specific message
            });
            widget.onValidationChange?.call(false);
          }
        }
      },
      onEditingComplete: _onEditingComplete, // Process final value
      // style: TextStyle(fontSize: 16.sp), // Example style
    );

    return Container(
      padding: widget.padding ?? EdgeInsets.symmetric(horizontal: 12.0.r),
      // Original padding from question
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.label != null)
            Padding(
              padding: EdgeInsets.only(bottom: 4.0.r),
              child: CustomText(widget.label!),
            ),
          Container(
            decoration: BoxDecoration(
              borderRadius: widget.isPlainStyle
                  ? null
                  : BorderRadius.circular(36.r),
              color: widget.isPlainStyle
                  ? null
                  : context.colors.primary.withValues(alpha: .4),
              // border:
              //     widget.border ?? Border.all(color: Colors.grey, width: 1.0.r),
            ),
            child: widget.includeTextField
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildIconButton(
                        icon: widget.isPlainStyle
                            ? IconInfo.icon(Icons.add)
                            : IconInfo.icon(Icons.add_circle_outline_rounded),
                        onPressed: !widget.enabled || _count >= widget.maxValue
                            ? null
                            : () {
                                setState(() {
                                  // Increment logic needs to consider decimal stepping if necessary
                                  // For simplicity, incrementing by 1 or a defined step.
                                  const double step = 1.0;
                                  updateValue(_count + step);
                                });
                              },
                      ),
                      Expanded(
                        flex: 2,
                        child: Padding(
                          padding: widget.visualDensity == VisualDensity.compact
                              ? EdgeInsets.zero
                              : widget.labelPadding ??
                                    EdgeInsets.symmetric(
                                      horizontal: 4.0.r,
                                      vertical: 4.r,
                                    ),
                          child: fieldWidget,
                        ),
                      ),
                      _buildIconButton(
                        icon: widget.isPlainStyle
                            ? IconInfo.icon(Icons.remove)
                            : IconInfo.icon(Icons.remove_circle_outline),
                        onPressed: !widget.enabled || _count <= widget.minValue
                            ? null
                            : () {
                                setState(() {
                                  const double step = 1.0;
                                  updateValue(_count - step);
                                });
                              },
                      ),
                    ],
                  )
                : Row(
                    // Not including text field
                    mainAxisSize: widget.isMaxWidth
                        ? MainAxisSize.max
                        : MainAxisSize.min,
                    mainAxisAlignment: widget.isMaxWidth
                        ? MainAxisAlignment.spaceEvenly
                        : MainAxisAlignment.start,
                    children: [
                      _buildIconButton(
                        icon: widget.isPlainStyle
                            ? IconInfo.icon(Icons.add)
                            : IconInfo.icon(Icons.add_circle_outline_rounded),
                        onPressed: !widget.enabled || _count >= widget.maxValue
                            ? null
                            : () {
                                setState(() {
                                  const double step = 1.0;
                                  updateValue(_count + step);
                                });
                              },
                      ),
                      Padding(
                        padding:
                            widget.labelPadding ??
                            EdgeInsets.symmetric(
                              vertical: 4.r,
                              horizontal: 8.r,
                            ),
                        // Increased horizontal padding
                        child: CustomText(
                          toLocalizedEnglishNumber(
                            _count,
                            widget.allowDecimal ? widget.decimalPlaces : 0,
                          ),
                        ),
                      ),
                      _buildIconButton(
                        icon: widget.isPlainStyle
                            ? IconInfo.icon(Icons.remove)
                            : IconInfo.icon(Icons.remove_circle_outline),
                        onPressed: !widget.enabled || _count <= widget.minValue
                            ? null
                            : () {
                                setState(() {
                                  const double step = 1.0;
                                  updateValue(_count - step);
                                });
                              },
                      ),
                    ],
                  ),
          ),
          if (error != null && error!.isNotEmpty)
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8.0.r, vertical: 4.r),
              alignment: AlignmentDirectional.centerStart,
              child: CustomText(
                error!,
                color: context.colors.error,
                fontSize: 12.sp,
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildIconButton({required IconInfo icon, VoidCallback? onPressed}) {
    return IconButton(
      visualDensity: widget.visualDensity,
      onPressed: widget.enabled ? onPressed : null,
      style: widget.isSmall
          ? ButtonStyle(
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              padding: WidgetStatePropertyAll(
                EdgeInsets.symmetric(horizontal: 8.r, vertical: 4.r),
              ),
            )
          : null, // And this sstyle
      icon: icon.buildIconWidget(
        color: widget.isPlainStyle ? context.colors.onSurface : null,
        // color: widget.enabled && onPressed != null
        //     ? context.colors.primary.withValues(alpha: .8)
        //     : Colors.grey,
        size: widget.iconSize ?? (widget.isPlainStyle ? 20.r : 30.r),
      ),
    );
  }

  @override
  void didUpdateWidget(covariant CounterWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    bool needsUpdate = false;
    if (oldWidget.initialValue != widget.initialValue) {
      _count = widget.initialValue.clamp(widget.minValue, widget.maxValue);
      needsUpdate = true;
    }
    if (oldWidget.minValue != widget.minValue ||
        oldWidget.maxValue != widget.maxValue) {
      _count = _count.clamp(widget.minValue, widget.maxValue);
      needsUpdate = true;
    }
    if (oldWidget.allowDecimal != widget.allowDecimal ||
        oldWidget.decimalPlaces != widget.decimalPlaces) {
      needsUpdate = true; // Re-format based on new decimal settings
    }

    if (needsUpdate) {
      // Update text controller and potentially re-validate
      _updateTextControllerFromCount();
      if (widget.validator != null) {
        error = widget.validator!(_count);
        // setState(() {
        // });
        // widget.onValidationChange?.call(error == null);
      }
    }
  }

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }
}

// Helper function for number localization (moved outside for clarity or use your existing one)
String toLocalizedEnglishNumber(double value, int decimalPlaces) {
  // Determine current locale or use a fixed one for testing
  // For simplicity, this example doesn't rely on device locale but you can adapt it.
  // final String locale = Localizations.localeOf(context).languageCode == 'ar' ? 'ar_EG' : 'en_US';
  const String locale =
      'en'; // Or 'ar_EG' for Arabic default. Could be a widget param.

  // Use toStringAsFixed to control decimal places *before* formatting
  // to prevent too many or too few based on NumberFormat's own rounding.
  final String fixedValueString = value.toStringAsFixed(decimalPlaces);
  final double valueToFormat = double.parse(
    fixedValueString,
  ); // Convert back to double to avoid parsing issues in NumberFormat

  if (decimalPlaces == 0) {
    return NumberFormat(
      '0', // No decimal places
      locale,
    ).format(valueToFormat);
  }

  if (locale == 'ar') {
    return NumberFormat(
      '#.#' * decimalPlaces + '0' * (decimalPlaces == 0 ? 1 : 0),
      // Ensures correct decimal display for Arabic
      locale,
    ).format(valueToFormat);
  } else {
    return NumberFormat(
      '0.${'#' * decimalPlaces}',
      // Ensures correct decimal display for English
      locale,
    ).format(valueToFormat);
  }
}
