import '../network/models/network_exception.dart';

abstract class NetworkResult<T> {
  T? data;
  NetworkException? error;

  NetworkResult({required this.data, this.error});
}

class Success<T> extends NetworkResult<T> {
  Success(T data) : super(data: data, error: null);
}

class Error<T> extends NetworkResult<T> {
  Error(NetworkException error) : super(data: null, error: error);
}
