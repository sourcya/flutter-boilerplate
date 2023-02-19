import 'package:freezed_annotation/freezed_annotation.dart';

import 'network_exception.dart';

part 'network_result.freezed.dart';

@freezed
abstract class NetworkResult<T> with _$NetworkResult<T> {
  const factory NetworkResult.success(T data) = Success<T>;

  const factory NetworkResult.error(NetworkExceptions exception) = Error<T>;
}
