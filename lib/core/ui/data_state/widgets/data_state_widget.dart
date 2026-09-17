part of '../../ui.dart';

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
  final VoidCallback? onRetryClicked;
  final bool enableCheckingInternet;
  final bool retryOnConnectionRestored;

  const DataStateWidget({
    required this.data,
    this.onInitial,
    this.onLoading,
    this.onSuccess,
    this.onEmpty,
    this.noInternetConnection,
    this.onError,
    this.onNoInternetRetryClicked,
    this.onRetryClicked,
    this.enableCheckingInternet = false,
    this.retryOnConnectionRestored = true,
  });

  @override
  Widget build(BuildContext context) {
    Widget widget = const SizedBox.shrink();
    final onNoInternetRetry = onNoInternetRetryClicked ?? onRetryClicked;
    data.when(
      initial: (data) {
        widget = onInitial?.call(data) ?? const SizedBox.shrink();
      },
      loading: (data) {
        widget = onLoading?.call(data) ?? const CustomLoading();
      },
      success: (data) {
        widget = onSuccess?.call(data) ?? const SizedBox.shrink();
      },
      failure: (error) {
        final message = error.message;
        switch (error) {
          case EmptyDataError _:
            widget =
                onEmpty?.call(message) ??
                EmptyDataWidget(
                  error: message,
                  onRetryClicked: onRetryClicked,
                );
          case NoInternetError _:
            widget =
                noInternetConnection?.call(message) ??
                NoInternetWidget(
                  error: message,
                  onRetryClicked: onNoInternetRetry,
                );
          case DefaultDataError _:
            widget =
                onError?.call(message) ??
                ErrorDataWidget(
                  error: message,
                  onRetryClicked: onRetryClicked,
                );
        }
      },
    );
    return widget;
  }
}
