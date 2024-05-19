import 'package:playx/playx.dart';

import 'data_error.dart';
import 'data_state.dart';

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
