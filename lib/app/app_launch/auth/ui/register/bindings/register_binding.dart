part of '../imports/register_imports.dart';

class RegisterBinding extends PlayxBinding {
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

    if (!Get.isRegistered<RegisterController>()) {
      Get.put(RegisterController(authRepository: authRepository));
    }
  }

  @override
  Future<void> onExit(
    BuildContext context,
  ) async {
    if (Get.isRegistered<RegisterController>()) {
      Get.delete<RegisterController>();
    }
  }
}
