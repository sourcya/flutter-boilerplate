part of '../models.dart';

/// Generic Wrapper class that happens when receiving a valid Result response.
class ResultSuccess<T> extends Result<T> {
  final T data;

  const ResultSuccess(this.data);
}

/// Generic Wrapper class that happens when an error happens.
class ResultError<T> extends Result<T> {
  final ResultException error;

  const ResultError(this.error);
}

/// Generic Wrapper class for the result of Result response.
/// when the Result call is successful it returns [ResultSuccess].
/// else it returns error with [ResultException].
sealed class Result<T> {
  const Result();

  const factory Result.success(T data) = ResultSuccess;

  const factory Result.error(ResultException error) = ResultError;

  /// Returns true if the Result call is successful.
  bool get isSuccess => this is ResultSuccess<T>;

  /// Returns true if the Result call is failed.
  bool get isError => this is ResultError<T>;

  /// Returns the data if the Result call is successful.
  /// Otherwise, it returns null.
  T? get resultData => (this as ResultSuccess<T>?)?.data;

  /// Returns the error if the Result call is failed.
  ResultException? get resultError => (this as ResultError<T>?)?.error;

  /// Helps determining whether the Result call is successful or not.
  void when({
    required Function(T success) success,
    required Function(ResultException error) error,
  }) {
    switch (this) {
      case ResultSuccess _:
        final data = (this as ResultSuccess<T>).data;
        success(data);
      case ResultError _:
        final exception = (this as ResultError<T>).error;
        error(exception);
    }
  }

  /// Maps the Result request whether it's success or error to your desired model.
  S map<S>({
    required S Function(ResultSuccess<T> data) success,
    required S Function(ResultError<T> error) error,
  }) {
    switch (this) {
      case ResultSuccess _:
        return success(this as ResultSuccess<T>);
      case ResultError _:
        return error(this as ResultError<T>);
    }
  }

  /// Maps the Result request whether it's success or error to your desired model asynchronously.
  Future<S> mapAsync<S>({
    required Future<S> Function(ResultSuccess<T> data) success,
    required Future<S> Function(ResultError<T> error) error,
  }) {
    switch (this) {
      case ResultSuccess _:
        return success(this as ResultSuccess<T>);
      case ResultError _:
        return error(this as ResultError<T>);
    }
  }

  /// Maps the Result request whether it's success or error to your desired model asynchronously.
  Future<Result<S>> mapDataAsync<S>({
    required Mapper<T, Result<S>> mapper,
  }) async {
    switch (this) {
      case ResultSuccess _:
        final data = (this as ResultSuccess<T>).data;
        return mapper(data);
      case ResultError _:
        return Result.error((this as ResultError<T>).error);
    }
  }

  /// Maps the Result request whether it's success or error to your desired model asynchronously in an isolate.
  ///
  /// [mapper] is the function that maps the data to your desired model.
  /// [exceptionMessage] is the message that will be shown when an exception occurs.
  /// [useWorkManager] is used to determine whether to use work manager for mapping json in isolate or use [compute] function.
  Future<Result<S>> mapDataAsyncInIsolate<S>({
    required Mapper<T, Result<S>> mapper,
    String? exceptionMessage,
    bool useWorkManager = true,
  }) async {
    try {
      return mapAsyncInIsolate(
        success: (data) async {
          final res = await mapper(data);
          return res;
        },
        error: (error) {
          return Result.error(error);
        },
        useWorkManager: useWorkManager,
      );
    } catch (e) {
      return Result.error(
        const ResultException(message: AppTrans.unableToProcess),
      );
    }
  }

  /// Maps the Result request whether it's success or error to your desired model asynchronously in an isolate.
  ///
  /// [success] is the function that maps the success data to your desired model.
  /// [error] is the function that maps the error data to your desired model.
  /// [useWorkManager] is used to determine whether to use work manager for mapping json in isolate or use [compute] function.
  Future<S> mapAsyncInIsolate<S>({
    required Mapper<T, S> success,
    required Mapper<ResultException, S> error,
    bool useWorkManager = true,
  }) {
    return MapUtils.mapAsyncInIsolate(
      data: this,
      mapper: (Result<T> res) async {
        switch (res) {
          case ResultSuccess():
            return await success(res.data);
          case ResultError():
            return await error(res.error);
        }
      },
      useWorkManager: useWorkManager,
    );
  }
}

class ResultException implements Exception {
  final String message;
  final int? statusCode;

  const ResultException({
    required this.message,
    this.statusCode,
  });

  @override
  String toString() {
    return 'ResultException: $message';
  }
}
