part of '../imports/login_view_imports.dart';

class OtpLoginBinding extends PlayxBinding {
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
    if (!Get.isRegistered<OtpLoginController>()) {
      Get.put(OtpLoginController(authRepository: authRepository));
    }
  }

  @override
  Future<void> onExit(
    BuildContext context,
  ) async {
    if (Get.isRegistered<OtpLoginController>()) {
      Get.delete<OtpLoginController>();
    }
  }
}
