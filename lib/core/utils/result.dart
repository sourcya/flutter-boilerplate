class Success<T> extends Result<T> {
  final T data;

  const Success(this.data);
}

class Error<T> extends Result<T> {
  final String error;

  const Error(this.error);
}

/// Generic Wrapper class for the result of any type.
sealed class Result<T> {
  const Result();

  const factory Result.success(T data) = Success;

  const factory Result.error(String error) = Error;

  void when({
    required Function(T success) success,
    required Function(String error) error,
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

  Result<S> map<S>({
    required Result<S> Function(Success<T> data) success,
    required Result<S> Function(Error<T> error) error,
  }) {
    switch (this) {
      case Success _:
        return success(this as Success<T>);
      case Error _:
        return error(this as Error<T>);
    }
  }
}
