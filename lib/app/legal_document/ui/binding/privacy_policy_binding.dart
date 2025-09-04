part of '../imports/legal_imports.dart';

class PrivacyPolicyBinding extends PlayxBinding {
  @override
  Future<void> onEnter(BuildContext context, GoRouterState state) async {
    final repository = LegalContentRepository.instance;
    Get.put(PrivacyPolicyController(repository));
  }

  @override
  Future<void> onExit(BuildContext context) async {
    await Get.delete<PrivacyPolicyController>();
  }
}
