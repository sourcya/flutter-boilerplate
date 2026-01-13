part of '../../ui.dart';

class CustomLoading extends StatelessWidget {
  final EdgeInsets? padding;
  const CustomLoading({super.key, this.padding});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      alignment: Alignment.center,
      padding: padding ?? EdgeInsets.only(bottom: dimens.appBarHeight),
      child: Lottie.asset(
        Assets.animations.loading,
        height: context.isLandscape ? context.height * .2 : context.height * .2,
        fit: BoxFit.fill,
      ),
    );
  }
}
