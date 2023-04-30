import 'package:freezed_annotation/freezed_annotation.dart';

part 'result.freezed.dart';

/// Generic wrapper for result with success and error states.
@freezed
abstract class Result<T> with _$Result<T> {
  const factory Result.success(T data) = Success<T>;

  const factory Result.error(String message) = Error<T>;
}