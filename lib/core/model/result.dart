import 'package:playx/playx.dart';

import 'result_error.dart';

class Success<T> extends Result<T> {
  final T data;

  const Success(this.data);
}

class Error<T> extends Result<T> {
  final ResultError error;

  const Error(this.error);
}

/// Generic Wrapper class for the result of any type.
sealed class Result<T> {
  const Result();

  const factory Result.success(T data) = Success;

  const factory Result.error(ResultError error) = Error;

  factory Result.networkResult(NetworkResult<T> result) {
    return result.map(
      success: (success) {
        return Result.success(success.data);
      },
      error: (error) {
        return Result.error(ResultError.fromNetworkError(error.error));
      },
    );
  }

  void when({
    required Function(T success) success,
    required Function(ResultError error) error,
  }) {
    switch (this) {
      case Success _:
        final data = (this as Success<T>).data;
        success(data);
      case Error _:
        final exception = (this as Error<T>).error;
        error(exception);
    }
  }

  S map<S>({
    required S Function(Success<T> data) success,
    required S Function(Error<T> error) error,
  }) {
    switch (this) {
      case Success _:
        return success(this as Success<T>);
      case Error _:
        return error(this as Error<T>);
    }
  }
}
