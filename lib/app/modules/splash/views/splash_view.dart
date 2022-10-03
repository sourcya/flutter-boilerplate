import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/app/modules/splash/controllers/splash_controller.dart';
import 'package:playx/playx.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              width: context.width,
              height: context.height,
              color: context.primaryColor,
            ),
            Container(
              width: context.width,
              height: context.height,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  end: const Alignment(0.0, .999),
                  begin: const Alignment(0.0, .8),
                  colors: const [
                    Color(0xFF00354f),
                    Color(0xFF08344c),
                    // Colors.white,
                  ].map((e) => e.withOpacity(.8)).toList(),
                ),
              ),
            ),
            const Center(
              child: Text('Splash'),
            ),
          ],
        ),
      ),
    );
  }
}
