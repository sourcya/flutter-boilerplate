import 'package:boilerplate_ui/core/data_state/data_state.dart';
import 'package:boilerplate_ui/core/widgets/empty_view_widget.dart';
import 'package:boilerplate_ui/core/widgets/error_view_widget.dart';
import 'package:boilerplate_ui/core/widgets/loading_view_widget.dart';
import 'package:flutter/material.dart';

class DataStateBuilderWidget<T> extends StatelessWidget {
  final DataState<T> dataState;
  final Widget Function(T data) onSuccess;
  final Function()? onFailure;
  final Function()? onRefresh;
  final String? loadingMessage;
  final String? emptyMessage;
  final String? errorMessage;

  const DataStateBuilderWidget({
    super.key,
    required this.dataState,
    required this.onSuccess,
    this.onFailure,
    this.onRefresh,
    this.loadingMessage,
    this.emptyMessage,
    this.errorMessage,
  });

  @override
  Widget build(BuildContext context) {
    Widget content = Builder(
      builder: (context) {
        if (dataState.isLoading) {
          return LoadingViewWidget(message: loadingMessage);
        } else if (dataState.isError) {
          return ErrorViewWidget(
            retryFunction: onFailure,
            message: errorMessage ?? dataState.error,
          );
        } else if (dataState.isSuccess && dataState.hasData) {
          return onSuccess(dataState.data as T);
        } else {
          return EmptyViewWidget(message: emptyMessage);
        }
      },
    );

    if (onRefresh != null) {
      return RefreshIndicator(
        onRefresh: () async => onRefresh?.call(),
        child: content,
      );
    }

    return content;
  }
}
