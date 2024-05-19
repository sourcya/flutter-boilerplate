import 'package:playx/playx.dart';

import 'data_error.dart';

class Initial<T> extends DataState<T> {
  /// If you want to init ui with initial data
  @override
  final T? data;

  const Initial({this.data});
}

class Loading<T> extends DataState<T> {
  /// If you want to show data while loading
  @override
  final T? data;

  const Loading({this.data});
}

class Success<T> extends DataState<T> {
  @override
  final T data;

  const Success(this.data);
}

class Failure<T> extends DataState<T> {
  final DataError error;

  const Failure(this.error);
}

class NetworkError<T> extends Failure<T> {
  final NetworkException exception;

  NetworkError(this.exception) : super(DataError.fromNetworkError(exception));
}

/// Generic Wrapper class for the result of any type.
sealed class DataState<T> {
  const DataState();

  const factory DataState.initial({T? data}) = Initial;

  const factory DataState.loading({T? data}) = Loading;

  const factory DataState.success(T data) = Success;

  const factory DataState.error(DataError error) = Failure;

  factory DataState.fromNetworkResult(NetworkResult<T> result) => result.map(
        success: (success) => Success(success.data),
        error: (error) => NetworkError(error.error),
      );

  factory DataState.fromNetworkError(NetworkException error) = NetworkError;

  factory DataState.fromEmptyError({String? error}) =>
      Failure(DataError.empty(error: error));

  factory DataState.fromDefaultError({String? error}) =>
      Failure(DataError.error(error: error));

  factory DataState.fromNoInternetError({String? error}) =>
      Failure(DataError.noInternetError(error: error));

  bool get isSuccess => this is Success;

  bool get isLoading => this is Loading;

  bool hasError() => this is Failure;

  T? get data {
    if (this is Initial<T>) {
      return this.data;
    }
    if (this is Loading<T>) {
      return this.data;
    }
    if (this is Success<T>) {
      return this.data;
    }
    return null;
  }

  void when({
    Function(T? data)? initial,
    Function(T? data)? loading,
    Function(T data)? success,
    Function(DataError error)? failure,
  }) {
    switch (this) {
      case Initial _:
        final data = (this as Initial<T>).data;
        initial?.call(data);
      case Loading _:
        final data = (this as Loading<T>).data;
        loading?.call(data);
      case Success _:
        final data = (this as Success<T>).data;
        success?.call(data);
      case Failure _:
        final exception = (this as Failure<T>).error;
        failure?.call(exception);
    }
  }

  DataState<S> map<S>({
    required DataState<S> Function(Initial<T> initial) initial,
    required DataState<S> Function(Loading<T> loading) loading,
    required DataState<S> Function(Success<T> success) success,
    required DataState<S> Function(Failure<T> error) error,
  }) {
    switch (this) {
      case Initial _:
        return initial(this as Initial<T>);
      case Loading _:
        return loading(this as Loading<T>);
      case Success _:
        return success(this as Success<T>);
      case Failure _:
        return error(this as Failure<T>);
    }
  }

  Future<DataState<S>> asyncMap<S>({
    required Future<DataState<S>> Function(Initial<T> initial) initial,
    required Future<DataState<S>> Function(Loading<T> loading) loading,
    required Future<DataState<S>> Function(Success<T> success) success,
    required Future<DataState<S>> Function(Failure<T> error) error,
  }) async {
    switch (this) {
      case Initial _:
        return await initial(this as Initial<T>);
      case Loading _:
        return await loading(this as Loading<T>);
      case Success _:
        return await success(this as Success<T>);
      case Failure _:
        return await error(this as Failure<T>);
    }
  }

  DataState<S> mapData<S>({
    required S Function(T data) dataMapper,
  }) {
    switch (this) {
      case Success _:
        return Success(dataMapper((this as Success<T>).data));
      case Failure _:
        return Failure((this as Failure<T>).error);
      case Loading _:
        final data = (this as Loading<T>).data;
        return Loading(data: data == null ? null : dataMapper(data));
      case Initial _:
        final data = (this as Initial<T>).data;
        return Initial(data: data == null ? null : dataMapper(data));
    }
  }

  Future<DataState<S>> asyncMapData<S>({
    required Future<S> Function(T data) dataMapper,
  }) async {
    switch (this) {
      case Success _:
        return Success(await dataMapper((this as Success<T>).data));
      case Failure _:
        return Failure((this as Failure<T>).error);
      case Loading _:
        final oldData = (this as Loading<T>).data;
        return Loading(
          data: oldData == null ? null : await dataMapper(oldData),
        );
      case Initial _:
        final oldData = (this as Initial<T>).data;
        return Initial(
          data: oldData == null ? null : await dataMapper(oldData),
        );
    }
  }
}
