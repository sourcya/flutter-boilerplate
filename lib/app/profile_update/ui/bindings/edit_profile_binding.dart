part of '../imports/profile_imports.dart';

class EditProfileBinding extends PlayxBinding {
  @override
  Future<void> onEnter(BuildContext context, GoRouterState state) async {
    Get.put(EditProfileController());
  }

  @override
  Future<void> onExit(BuildContext context) async {
    await Get.delete<EditProfileController>();
  }
}
