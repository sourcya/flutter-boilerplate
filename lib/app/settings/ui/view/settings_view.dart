part of '../imports/settings_imports.dart';

class SettingsView extends GetView<SettingsController> {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(title : AppTrans.settings.tr ),
      body: Container(
        padding: EdgeInsets.only(right: 2.w,left: 2.w, top: 4.h, bottom:4.h),
        child:  const OptimizedScrollView(
          child: Column(
            children: [
              BuildSettingsLanguageWidget(),
              BuildSettingsThemeWidget(),
              BuildSettingsLogOutWidget(),
              KeyboardVisibilityPadding(),
            ],
          ),
        ),
      ),
    );
  }
}
