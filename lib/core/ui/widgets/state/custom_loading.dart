part of '../../ui.dart';

class CustomLoading extends StatelessWidget {
  final EdgeInsetsGeometry margin;
  const CustomLoading({
    this.margin = const EdgeInsets.only(bottom: Dimens.bottomNavBarHeight),
  });

  @override
  Widget build(BuildContext context) {
    return CenterLoading.adaptive(
      color: context.colors.primary,
    );
    // return  Center(
    //   child: Container(
    //       height: context.height *.3,
    //     margin:margin ,
    //     // child:Lottie.asset(Assets.animations.loadingAnimation),
    //   ),
    // );
  }
}
