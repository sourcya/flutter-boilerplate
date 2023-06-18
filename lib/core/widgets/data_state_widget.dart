import 'package:flutter/material.dart';
import 'package:playx/playx.dart';

import '../utils/models/data_error.dart';
import '../utils/models/data_state.dart';
import 'no_data_widget.dart';
import 'no_internet_widget.dart';

typedef DataCallback<T> = Widget Function(T? data);
typedef SuccessDataCallback<T> = Widget Function(T data);

typedef ErrorCallback<T> = Widget Function(String error);

class DataStateWidget<T> extends StatelessWidget {
  final DataState<T> data;
  final DataCallback<T>? onInitial;
  final DataCallback<T>? onLoading;
  final SuccessDataCallback<T>? onSuccess;
  final ErrorCallback<T>? onEmpty;
  final ErrorCallback<T>? onError;
  final ErrorCallback<T>? noInternetConnection;
  final VoidCallback? onNoInternetRetryClicked;

  const DataStateWidget({
    required this.data,
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
    Widget widget = const SizedBox.shrink();
    data.when(
      initial: (data) {
        widget = onInitial?.call(data) ?? const SizedBox.shrink();
      },
      loading: (data) {
        widget = onLoading?.call(data) ?? const CenterLoading();
      },
      success: (data) {
        widget = onSuccess?.call(data) ?? const SizedBox.shrink();
      },
      failure: (error) {
        final message = error.message;
        switch (error) {
          case EmptyDataError _:
            widget = onEmpty?.call(message) ?? const NoDataAnimation();
          case NoInternetError _:
            widget = noInternetConnection?.call(message) ??
                NoInternetAnimation(onRetryClicked: onNoInternetRetryClicked);
          case DefaultDataError _:
            widget =
                noInternetConnection?.call(message) ?? const SizedBox.shrink();
        }
      },
    );
    return widget;
  }
}
