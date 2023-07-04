import 'exceptions/network_exception.dart';

class Success<T> extends NetworkResult<T> {
  final T data;

  const Success(this.data);
}

class Error<T> extends NetworkResult<T> {
  final NetworkException error;

  const Error(this.error);
}

/// Generic Wrapper class for the result of network response.
/// when the network call is successful it returns success.
/// else it returns error with [NetworkException].
sealed class NetworkResult<T> {
  const NetworkResult();

  const factory NetworkResult.success(T data) = Success;

  const factory NetworkResult.error(NetworkException error) = Error;

  void when({
    required Function(T data) success,
    required Function(NetworkException error) error,
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

  NetworkResult<S> map<S>({
    required NetworkResult<S> Function(Success<T> data) success,
    required NetworkResult<S> Function(Error<T> error) error,
  }) {
    switch (this) {
      case Success _:
        return success(this as Success<T>);
      case Error _:
        return error(this as Error<T>);
    }
  }
}
