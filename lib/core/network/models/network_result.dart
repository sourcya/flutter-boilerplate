import 'package:freezed_annotation/freezed_annotation.dart';

import 'network_exception.dart';

part 'network_result.freezed.dart';

/// Generic Wrapper class for the result of network response.
/// when the network call is successful it returns success.
/// else it returns error with [NetworkException].
@freezed
abstract class NetworkResult<T> with _$NetworkResult<T> {
  const factory NetworkResult.success(T data) = Success<T>;

  const factory NetworkResult.error(NetworkException exception) = Error<T>;
}
