import 'package:flutter/material.dart';
import 'package:playx/playx.dart';

import '../utils/models/data_state.dart';
import 'data_state_widget.dart';

typedef DataCallback<T> = Widget Function(T? data);
typedef SuccessDataCallback<T> = Widget Function(T data);
typedef ErrorCallback<T> = Widget Function(String error);

class RxDataStateWidget<T> extends StatelessWidget {
  final Rx<DataState<T>> rxData;
  final DataCallback<T>? onInitial;
  final DataCallback<T>? onLoading;
  final SuccessDataCallback<T>? onSuccess;
  final ErrorCallback<T>? onEmpty;
  final ErrorCallback<T>? onError;
  final ErrorCallback<T>? noInternetConnection;
  final VoidCallback? onNoInternetRetryClicked;

  const RxDataStateWidget({
    required this.rxData,
    this.onInitial,
    this.onLoading,
    this.onSuccess,
    this.onEmpty,
    this.noInternetConnection,
    this.onError,
    this.onNoInternetRetryClicked,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => DataStateWidget(
        data: rxData.value,
        onInitial: onInitial,
        onLoading: onLoading,
        onSuccess: onSuccess,
        onEmpty: onEmpty,
        noInternetConnection: noInternetConnection,
        onError: onError,
        onNoInternetRetryClicked: onNoInternetRetryClicked,
      ),
    );
  }
}
