part of '../imports/legal_imports.dart';

class PrivacyPolicyBinding extends PlayxBinding {
  @override
  Future<void> onEnter(BuildContext context, GoRouterState state) async {
    Get.put<PrivacyPolicyController>(
      PrivacyPolicyController(
          getIt.get<ILegalContentRepository>(instanceName: "test")),
    );
  }

  @override
  Future<void> onExit(BuildContext context) async {
    await Get.delete<PrivacyPolicyController>();
  }
}
