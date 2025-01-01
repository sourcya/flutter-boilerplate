import 'package:flutter_boilerplate/core/data_state/models/data_error.dart';
import 'package:flutter_boilerplate/core/data_state/models/data_state.dart';
import 'package:playx/playx.dart';

class RxDataState<T> extends Rx<DataState<T>> {
  RxDataState(super.initial);

  RxDataState.initial() : super(const DataState.initial());

  RxDataState.loading() : super(const DataState.loading());

  RxDataState.error(DataError error) : super(DataState.error(error));

  RxDataState.success(T data) : super(DataState.success(data));

  RxDataState<T> copyWith(DataState<T> dataState) {
    value = dataState;
    return this;
  }
}
