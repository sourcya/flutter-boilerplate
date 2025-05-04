part of '../../ui.dart';

class RxSliverDataStateWidget<T> extends StatelessWidget {
  final Rx<DataState<T>> rxData;
  final DataCallback<T>? onInitial;
  final DataCallback<T>? onLoading;
  final SuccessDataCallback<T>? onSuccess;
  final ErrorCallback<T>? onEmpty;
  final ErrorCallback<T>? onError;
  final ErrorCallback<T>? noInternetConnection;
  final VoidCallback? onNoInternetRetryClicked;
  final VoidCallback? onRetryClicked;

  const RxSliverDataStateWidget({
    required this.rxData,
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
    return Obx(
      () => SliverDataStateWidget(
        data: rxData.value,
        onInitial: onInitial,
        onLoading: onLoading,
        onSuccess: onSuccess,
        onEmpty: onEmpty,
        noInternetConnection: noInternetConnection,
        onError: onError,
        onNoInternetRetryClicked: onNoInternetRetryClicked,
        onRetryClicked: onRetryClicked,
      ),
    );
  }
}
