part of '../../ui.dart';

class RxDataStateWidget<T> extends StatelessWidget {
  final Rx<DataState<T>> rxData;
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

  const RxDataStateWidget({
    required this.rxData,
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
        onRetryClicked: onRetryClicked,
        enableCheckingInternet: enableCheckingInternet,
        retryOnConnectionRestored: retryOnConnectionRestored,
      ),
    );
  }
}
