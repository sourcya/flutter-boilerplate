import 'package:playx/playx.dart';

/// Match Validator for text fields
/// checks if the input matches other string
class AreEqual extends TextValidationRule {
  final String Function() other;
  bool caseSensitive;
  String errorMsg;

  AreEqual({
    required this.other,
    this.errorMsg = 'There is no match',
    this.caseSensitive = true,
  }) : super(errorMsg);

  ///  return a bool Either valid or NOT
  @override
  bool isValid(String input) {
    return caseSensitive
        ? _match(input, other())
        : _match(input.toLowerCase(), other().toLowerCase());
  }
}

bool _match(
  String input,
  String other,
) =>
    input == other;
