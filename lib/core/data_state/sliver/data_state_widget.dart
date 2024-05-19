import 'package:flutter/material.dart';

import '../../widgets/custom_loading.dart';
import '../../widgets/empty_data_widget.dart';
import '../../widgets/error_widget.dart';
import '../../widgets/no_internet_widget.dart';
import '../models/data_error.dart';
import '../models/data_state.dart';

typedef DataCallback<T> = Widget Function(T? data);
typedef SuccessDataCallback<T> = Widget Function(T data);

typedef ErrorCallback<T> = Widget Function(String error);

class SliverDataStateWidget<T> extends StatelessWidget {
  final DataState<T> data;
  final DataCallback<T>? onInitial;
  final DataCallback<T>? onLoading;
  final SuccessDataCallback<T>? onSuccess;
  final ErrorCallback<T>? onEmpty;
  final ErrorCallback<T>? onError;
  final ErrorCallback<T>? noInternetConnection;
  final VoidCallback? onNoInternetRetryClicked;
  final VoidCallback? onRetryClicked;

  const SliverDataStateWidget({
    required this.data,
    this.onInitial,
    this.onLoading,
    this.onSuccess,
    this.onEmpty,
    this.noInternetConnection,
    this.onError,
    this.onNoInternetRetryClicked,
    this.onRetryClicked,
  });

  @override
  Widget build(BuildContext context) {
    Widget widget = const SliverToBoxAdapter(child: SizedBox.shrink());
    data.when(
      initial: (data) {
        widget = onInitial?.call(data) ??
            const SliverToBoxAdapter(
              child: SizedBox.shrink(),
            );
      },
      loading: (data) {
        widget = onLoading?.call(data) ??
            const SliverFillRemaining(
              child: CustomLoading(),
            );
      },
      success: (data) {
        widget = onSuccess?.call(data) ??
            const SliverToBoxAdapter(
              child: SizedBox.shrink(),
            );
      },
      failure: (error) {
        final message = error.message;
        switch (error) {
          case EmptyDataError _:
            widget = onEmpty?.call(message) ??
                SliverFillRemaining(
                  child: EmptyDataWidget(
                    error: message,
                    onRetryClicked: onRetryClicked,
                  ),
                );
          case NoInternetError _:
            widget = noInternetConnection?.call(message) ??
                SliverFillRemaining(
                  child: NoInternetWidget(
                    error: message,
                    onRetryClicked: onNoInternetRetryClicked,
                  ),
                );
          case DefaultDataError _:
            widget = onError?.call(message) ??
                SliverFillRemaining(
                  child: ErrorDataWidget(
                    error: message,
                    onRetryClicked: onRetryClicked,
                  ),
                );
        }
      },
    );
    return widget;
  }
}
