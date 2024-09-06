part of '../imports/login_imports.dart';

// login screen widget.
class LoginView extends GetView<LoginController> {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          OptimizedScrollView(
            child: SafeArea(
              child: Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 5,
                  horizontal: 5,
                ),
                alignment: Alignment.center,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const BuildLoginLottieAnimation(),
                    const BuildLoginTitleWidget(),
                    Obx(() {
                      return AnimatedSwitcher(
                        duration: const Duration(milliseconds: 350),
                        child: controller.currentLoginMethod.value ==
                                LoginMethod.email
                            ? const BuildLoginWithEmailWidget()
                            : const BuildChooseLoginMethodWidget(),
                      );
                    }),
                    const Spacer(),
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
          Obx(() {
            return LoadingOverlay(
              isLoading: controller.isLoading.value,
              loadingText: AppTrans.loggingInText,
            );
          }),
        ],
      ),
    );
  }
}
