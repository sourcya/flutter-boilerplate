export 'package:boilerplate_ui/core/data_state/request_status.dart';

import 'package:boilerplate_ui/core/data_state/request_status.dart';

abstract class RequestState {
  final RequestStatus? status;
  final String? message;

  const RequestState({
    this.status,
    this.message,
  });
}