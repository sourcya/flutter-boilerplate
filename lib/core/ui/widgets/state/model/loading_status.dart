part of '../../../ui.dart';

sealed class LoadingStatus {
  final String displayName;

  const LoadingStatus({required this.displayName});

  const factory LoadingStatus.loading({String? displayName}) =
      LoadingStatusLoading;

  const factory LoadingStatus.login({String? displayName}) = LoadingStatusLogin;

  const factory LoadingStatus.register({String? displayName}) =
      LoadingStatusRegister;

  const factory LoadingStatus.logout({String? displayName}) =
      LoadingStatusLogout;

  const factory LoadingStatus.idle({String? displayName}) = LoadingStatusIdle;

  factory LoadingStatus.fromString(String status) {
    switch (status) {
      case 'loading':
        return const LoadingStatusLoading();
      case 'login':
        return const LoadingStatusLogin();
      case 'register':
        return const LoadingStatusRegister();
      case 'logout':
        return const LoadingStatusLogout();
      case 'idle':
        return const LoadingStatusIdle();
      default:
        return const LoadingStatusIdle();
    }
  }

  String toShortString();
  bool get isLoading => this is LoadingStatusLoading;
  bool get isIdle => this is LoadingStatusIdle;
  bool get isLogin => this is LoadingStatusLogin;
  bool get isRegister => this is LoadingStatusRegister;
  bool get isLogout => this is LoadingStatusLogout;
}

class LoadingStatusLoading extends LoadingStatus {
  const LoadingStatusLoading({String? displayName})
      : super(displayName: displayName ?? AppTrans.loadingStatusLoading);

  @override
  String toShortString() => 'loading';
}

class LoadingStatusLogin extends LoadingStatus {
  const LoadingStatusLogin({String? displayName})
      : super(displayName: displayName ?? AppTrans.loadingStatusLogin);

  @override
  String toShortString() => 'login';
}

class LoadingStatusRegister extends LoadingStatus {
  const LoadingStatusRegister({String? displayName})
      : super(displayName: displayName ?? AppTrans.loadingStatusRegister);

  @override
  String toShortString() => 'register';
}

class LoadingStatusLogout extends LoadingStatus {
  const LoadingStatusLogout({String? displayName})
      : super(displayName: displayName ?? AppTrans.loadingStatusLogout);

  @override
  String toShortString() => 'logout';
}

class LoadingStatusIdle extends LoadingStatus {
  const LoadingStatusIdle({String? displayName})
      : super(displayName: displayName ?? '');

  @override
  String toShortString() => 'idle';
}
