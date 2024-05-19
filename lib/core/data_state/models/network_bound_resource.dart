import 'dart:async';

import 'package:playx/playx.dart';

import 'data_state.dart';

/// A class that represents a resource that is provided by the network or the database.

class NetworkBoundResource<ResultType, RequestType> {
  Stream<DataState<ResultType>> asStream({
    required Stream<ResultType> Function() loadFromDb,
    required Future<NetworkResult<RequestType>> Function() fetch,
    required Future<void> Function(RequestType data) saveCallResult,
    required Future<bool> Function(ResultType? data) shouldFetch,
  }) async* {
    yield const DataState.loading();

    final dbResult = await loadFromDb().firstOrNull;

    if (await shouldFetch(dbResult)) {
      final networkResult = await fetch();
      networkResult.when(
        success: (data) async* {
          try {
            await saveCallResult(data);

            yield* loadFromDb().asyncMap((data) => DataState.success(data));
          } catch (e) {
            yield DataState.fromDefaultError();
          }
        },
        error: (error) async* {
          yield DataState.fromNetworkError(error);
        },
      );
    } else {
      yield* loadFromDb().asyncMap((data) => DataState.success(data));
    }
  }

  Future<DataState<ResultType>> asFuture({
    Future<ResultType?> Function()? initialData,
    required Future<ResultType> Function() loadFromDb,
    required Future<NetworkResult<RequestType>> Function() fetch,
    required Future<void> Function(RequestType data) saveCallResult,
    required Future<bool> Function(ResultType? data) shouldFetch,
  }) async {
    ResultType? initialDataResult;
    try {
      if (initialData != null) {
        initialDataResult = await initialData();
      } else {
        initialDataResult = await loadFromDb();
      }
    } catch (_) {
      initialDataResult = null;
    }
    if (await shouldFetch(initialDataResult)) {
      final networkResult = await fetch();

      return networkResult.mapAsync(
        success: (success) async {
          final data = success.data;

          try {
            await saveCallResult(data);
            return DataState.success(await loadFromDb());
          } catch (e) {
            return DataState.fromDefaultError();
          }
        },
        error: (error) async {
          return DataState.fromNetworkError(error.error);
        },
      );
    } else {
      if (initialDataResult != null) {
        return DataState.success(initialDataResult);
      } else {
        return DataState.fromDefaultError();
      }
    }
  }
}
