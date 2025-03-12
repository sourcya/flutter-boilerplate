part of '../imports/login_imports.dart';

///Getx binding to initialize login controller.
class LoginBinding extends PlayxBinding {
  @override
  Future<void> onEnter(BuildContext context, GoRouterState state) async {
    final authRepository = AuthRepository(
      remoteAuthDataSource: TestAuthDataSource(
        client: ApiClient.client,
      ),
      auth0DataSource: Auth0AuthDataSource(
        client: ApiClient.client,
        auth0: ApiClient.auth0,
        auth0Web: ApiClient.auth0Web,
      ),
      preferenceManger: MyPreferenceManger.instance,
    );
    if (!Get.isRegistered<LoginController>()) {
      Get.put(LoginController(
        authRepository: authRepository,
      ));
    }
  }

  @override
  Future<void> onExit(
    BuildContext context,
  ) async {
    if (Get.isRegistered<LoginController>()) {
      Get.delete<LoginController>();
    }
  }
}
