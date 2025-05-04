part of '../imports/register_imports.dart';

class RegisterView extends GetView<RegisterController> {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    return Title(
      title: AppTrans.registerText.tr(context: context),
      color: context.colors.primary,
      child: BackButtonListener(
        onBackButtonPressed: () async {
          if (controller.currentLoginMethod.value == LoginMethod.email) {
            controller.currentLoginMethod.value = null;
            return true;
          } else {
            return false;
          }
        },
        child: CustomScaffold(
          includeAppBar: false,
          includeLoadingOverlay: true,
          child: OptimizedScrollView(
            child: SafeArea(
              child: Column(
                children: [
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        vertical: 4.r,
                        horizontal: 4.r,
                      ),
                      alignment: Alignment.center,
                      child: Column(
                        children: [
                          Stack(
                            children: [
                              Align(
                                child: Padding(
                                  padding: EdgeInsets.only(
                                    top: 16.0.r,
                                  ),
                                  child: const BuildRegisterLottieAnimation(),
                                ),
                              ),
                              const BuildRegisterBackButton(),
                            ],
                          ),
                          Expanded(
                            child: Obx(() {
                              return AnimatedSwitcher(
                                duration: const Duration(milliseconds: 500),
                                transitionBuilder: (
                                  Widget child,
                                  Animation<double> animation,
                                ) {
                                  return SlideTransition(
                                    position: Tween<Offset>(
                                      begin: const Offset(1, 0),
                                      end: Offset.zero,
                                    ).animate(animation),
                                    child: child,
                                  );
                                },
                                child: controller.currentLoginMethod.value ==
                                        LoginMethod.email
                                    ? const BuildRegisterWithEmailWidget()
                                    : const BuildChooseRegisterMethodWidget(),
                              );
                            }),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 12.r),
                  const BuildRegisterHaveAccountWidget(),
                  SizedBox(height: 12.r),
                  Container(
                    alignment: Alignment.bottomCenter,
                    child: AppVersion(
                      textStyle: TextStyle(
                        color: context.colors.onSurface,
                        fontSize: 12.sp,
                        fontFamily: fontFamily,
                      ),
                    ),
                  ),
                  SizedBox(height: 12.r),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
