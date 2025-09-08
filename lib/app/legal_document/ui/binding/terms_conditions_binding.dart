part of '../imports/legal_imports.dart';

class TermsConditionsBinding extends PlayxBinding {
  @override
  Future<void> onEnter(BuildContext context, GoRouterState state) async {
    Get.put<TermsConditionsController>(
      TermsConditionsController(
        getIt.get<ILegalContentRepository>(instanceName: "live"),
      ),
    );
  }

  @override
  Future<void> onExit(BuildContext context) async {
    await Get.delete<TermsConditionsController>();
  }
}
