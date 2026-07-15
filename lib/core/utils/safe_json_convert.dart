import 'package:boilerplate_ui/core/utils/safe_convert.dart';

/// Internal helper to safely get a value from a JSON map by key.
/// Returns null if the JSON is null, not a map, or if the key is missing.
dynamic _getJsonValueOrNull(dynamic json, String key) {
  if (json == null) return null;
  if (json is Map && json.containsKey(key)) return json[key];
  return null;
}

// ----------------------- INT -----------------------

/// Returns an int if the value at [key] can be converted, otherwise null.
int? asIntOrNull(dynamic json, String key) {
  final value = _getJsonValueOrNull(json, key);
  return toIntOrNull(value);
}

/// Returns an int for the value at [key].
/// Throws a [FormatException] if the value cannot be converted.
int asInt(dynamic json, String key) {
  final value = _getJsonValueOrNull(json, key);
  return toInt(value);
}

/// Returns an int for the value at [key], or [fallback] if conversion fails.
int asIntOr(dynamic json, String key, {int fallback = 0}) {
  final value = _getJsonValueOrNull(json, key);
  return toIntOr(value, fallback: fallback);
}

// ----------------------- DOUBLE -----------------------

/// Returns a double if the value at [key] can be converted, otherwise null.
double? asDoubleOrNull(dynamic json, String key) {
  final value = _getJsonValueOrNull(json, key);
  return toDoubleOrNull(value);
}

/// Returns a double for the value at [key].
/// Throws a [FormatException] if the value cannot be converted.
double asDouble(dynamic json, String key) {
  final value = _getJsonValueOrNull(json, key);
  return toDouble(value);
}

/// Returns a double for the value at [key], or [fallback] if conversion fails.
double asDoubleOr(dynamic json, String key, {double fallback = 0.0}) {
  final value = _getJsonValueOrNull(json, key);
  return toDoubleOr(value, fallback: fallback);
}

// ----------------------- BOOL -----------------------

/// Returns a bool if the value at [key] can be converted, otherwise null.
bool? asBoolOrNull(dynamic json, String key) {
  final value = _getJsonValueOrNull(json, key);
  return toBoolOrNull(value);
}

/// Returns a bool for the value at [key].
/// Throws a [FormatException] if the value cannot be converted.
bool asBool(dynamic json, String key) {
  final value = _getJsonValueOrNull(json, key);
  return toBool(value);
}

/// Returns a bool for the value at [key], or [fallback] if conversion fails.
bool asBoolOr(dynamic json, String key, {bool fallback = false}) {
  final value = _getJsonValueOrNull(json, key);
  return toBoolOr(value, fallback: fallback);
}

// ----------------------- STRING -----------------------

/// Returns a String if the value at [key] can be converted, otherwise null.
String? asStringOrNull(dynamic json, String key) {
  final value = _getJsonValueOrNull(json, key);
  return toStringOrNull(value);
}

/// Returns a String for the value at [key].
/// Throws a [FormatException] if the value cannot be converted.
String asString(dynamic json, String key) {
  final value = _getJsonValueOrNull(json, key);
  return toStringSafe(value);
}

/// Returns a String for the value at [key], or [fallback] if conversion fails.
String asStringOr(dynamic json, String key, {String fallback = ''}) {
  final value = _getJsonValueOrNull(json, key);
  return toStringOr(value, fallback: fallback);
}

// ----------------------- DATETIME -----------------------

/// Returns a DateTime if the value at [key] can be parsed, otherwise null.
DateTime? asDateTimeOrNull(dynamic json, String key) {
  final value = _getJsonValueOrNull(json, key);
  return toDateTimeOrNull(value);
}

/// Returns a DateTime for the value at [key].
/// Throws a [FormatException] if the value cannot be parsed.
DateTime asDateTime(dynamic json, String key) {
  final value = _getJsonValueOrNull(json, key);
  return toDateTime(value);
}

/// Returns a DateTime for the value at [key], or [fallback] if parsing fails.
DateTime asDateTimeOr(dynamic json, String key, {required DateTime fallback}) {
  final value = _getJsonValueOrNull(json, key);
  return toDateTimeOr(value, fallback: fallback);
}

/// Returns a local [DateTime] if the value at [key] can be parsed, otherwise null.
DateTime? asLocalDateTimeOrNull(dynamic json, String key) {
  final value = _getJsonValueOrNull(json, key);
  return toLocalDateTimeOrNull(value);
}

/// Returns a local [DateTime] for the value at [key].
/// Throws a [FormatException] if the value cannot be parsed.
DateTime asLocalDateTime(dynamic json, String key) {
  final value = _getJsonValueOrNull(json, key);
  return toLocalDateTime(value);
}

/// Returns a local [DateTime] for the value at [key], or [fallback] if parsing fails.
DateTime asLocalDateTimeOr(dynamic json, String key,
    {required DateTime fallback}) {
  final value = _getJsonValueOrNull(json, key);
  return toLocalDateTimeOr(value, fallback: fallback);
}

// ----------------------- GENERIC -----------------------

/// Converts the value at [key] to type T.
/// Returns null if conversion fails.
T? asTOrNull<T>(dynamic json, String key,
    {T Function(dynamic json)? fromJson}) {
  final value = _getJsonValueOrNull(json, key);
  try {
    if (fromJson != null) return fromJson(value);
    if (value is T) return value;
    if (0 is T) return toIntOrNull(value) as T?;
    if ('' is T) return toStringOrNull(value) as T?;
    if (false is T) return toBoolOrNull(value) as T?;
    if (DateTime.now() is T) return toDateTimeOrNull(value) as T?;
  } catch (_) {
    return null;
  }
  return null;
}

/// Converts the value at [key] to type T, or returns [fallback] if conversion fails.
T asTOr<T>(dynamic json, String key,
    {T Function(dynamic json)? fromJson, required T fallback}) {
  return asTOrNull(json, key, fromJson: fromJson) ?? fallback;
}

/// Converts the value at [key] to type T.
/// Throws a [FormatException] if the value cannot be converted.
T asT<T>(dynamic json, String key, {T Function(dynamic json)? fromJson}) {
  return asTOrNull(json, key, fromJson: fromJson) ??
      (throw FormatException('Invalid <$T> value for key: $key'));
}
