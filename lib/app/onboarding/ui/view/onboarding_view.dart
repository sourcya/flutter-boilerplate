import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:playx/playx.dart';

import '../../../../core/resources/colors/app_color_scheme.dart';
import '../../../../core/resources/translation/app_translations.dart';
import '../controller/onboarding_controller.dart';
import 'widgets/onboarding_page.dart';

class OnBoardingView extends GetView<OnBoardingController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: OptimizedScrollView(
          child: Column(
            children: [
              SizedBox(
                height: context.height * .82,
                child: PageView(
                  controller: controller.pageController,
                  onPageChanged: controller.onPageChanged,
                  children: List.generate(
                      controller.pages.length,
                      (index) =>
                          OnBoardingPage(onboarding: controller.pages[index]),),
                ),
              ),
              Expanded(
                child: Container(
                  padding:  EdgeInsets.symmetric(vertical: 8.h, horizontal: 8.w),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Obx(() {
                          return DotsIndicator(
                            dotsCount: controller.pages.length,
                            position: controller.currentIndex.value,
                            decorator: DotsDecorator(
                              activeSize:  Size(24.0.w, 12.0.h),
                              activeShape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0.r),
                              ),
                            ),
                          );
                        }),
                        Padding(
                          padding:  EdgeInsets.all(8.0.r),
                          child: SizedBox(
                            width: context.width * .3,
                            child: ElevatedButton(
                              onPressed: controller.handleNextOrSkip,
                              // controller.isCompleted.value
                              //     ? controller.handleSkip
                              //     : null,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: colorScheme.primary,
                                padding:  EdgeInsets.symmetric(
                                  vertical: 12.h,
                                  horizontal: 8.w,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                              ),
                              child: Obx(() {
                                return Text(
                                  controller.isCompleted.value
                                      ? AppTrans.skip.tr
                                      : AppTrans.next.tr,
                                  style:  TextStyle(fontSize: 18.sp),
                                );
                              }),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
