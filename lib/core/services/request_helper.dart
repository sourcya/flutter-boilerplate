import 'package:boilerplate_ui/core/data_state/request_state.dart';
import 'package:boilerplate_ui/core/network/error_handler.dart';
import 'package:dio/dio.dart';

class RequestHelper {
  const RequestHelper._();

  static Future<void> execute<R, S extends RequestState>({
    required void Function(S state) emit,
    required S Function({
      required RequestStatus status,
      String? message,
    }) stateFactory,
    required Future<R> Function() request,
    required void Function(R data) onSuccess,
    bool refresh = false,
  }) async {
    if (!refresh) {
      emit(
        stateFactory(
          status: RequestStatus.loading,
        ),
      );
    }

    try {
      final result = await request();

      onSuccess(result);

      emit(
        stateFactory(
          status: RequestStatus.success,
        ),
      );
    } on DioException catch (e) {
      if (e.type == DioExceptionType.cancel) return;

      emit(
        stateFactory(
          status: RequestStatus.failure,
          message: ErrorHandler.message(e),
        ),
      );
    } catch (e) {
      emit(
        stateFactory(
          status: RequestStatus.failure,
          message: ErrorHandler.message(e),
        ),
      );
    }
  }
}