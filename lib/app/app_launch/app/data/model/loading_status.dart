enum LoadingStatus {
  loading,
  login,
  register,
  logout,
  none;

  // String get displayName => switch(this){
  //   LoadingStatus.loading => AppTrans.loadingStatusLoading,
  //    LoadingStatus.login => AppTrans.loadingStatusLogin,
  //    LoadingStatus.register => AppTrans.loadingStatusRegister,
  //    LoadingStatus.logout => AppTrans.loadingStatusLogout,
  //    LoadingStatus.none => AppTrans.loadingStatusNone,
  // };

  static LoadingStatus fromString(String status) {
    switch (status) {
      case 'loading':
        return LoadingStatus.loading;
      case 'login':
        return LoadingStatus.login;
      case 'register':
        return LoadingStatus.register;
      case 'logout':
        return LoadingStatus.logout;
      case 'none':
        return LoadingStatus.none;
      default:
        return LoadingStatus.none;
    }
  }

  String toShortString() {
    switch (this) {
      case LoadingStatus.loading:
        return 'loading';
      case LoadingStatus.login:
        return 'login';
      case LoadingStatus.register:
        return 'register';
      case LoadingStatus.logout:
        return 'logout';
      case LoadingStatus.none:
        return 'none';
    }
  }
}
