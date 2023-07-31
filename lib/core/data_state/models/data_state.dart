
import 'data_error.dart';

class Initial<T> extends DataState<T> {
  /// If you want to init ui with initial data
  final T? data;

  const Initial({this.data});
}

class Loading<T> extends DataState<T> {
  /// If you want to show data while loading
  final T? data;

  const Loading({this.data});
}

class Success<T> extends DataState<T> {
  final T data;

  const Success(this.data);
}

class Failure<T> extends DataState<T> {
  final DataError error;

  const Failure(this.error);
}

/// Generic Wrapper class for the result of any type.
sealed class DataState<T> {
  const DataState();

  const factory DataState.initial({T? data}) = Initial;

  const factory DataState.loading({T? data}) = Loading;

  const factory DataState.success(T data) = Success;

  const factory DataState.error(DataError error) = Failure;

  void when({
    required Function(T? data) initial,
    required Function(T? data) loading,
    required Function(T data) success,
    required Function(DataError error) failure,
  }) {
    switch (this) {
      case Initial _:
        final data = (this as Initial<T>).data;
        initial(data);
      case Loading _:
        final data = (this as Loading<T>).data;
        loading(data);
      case Success _:
        final data = (this as Success<T>).data;
        success(data);
      case Failure _:
        final exception = (this as Failure<T>).error;
        failure(exception);
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
}
