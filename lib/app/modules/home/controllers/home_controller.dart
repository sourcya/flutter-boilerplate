import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late TabController tabC;

  @override
  void onInit() {
    tabC = TabController(length: 3, vsync: this);
    super.onInit();
  }

  void onTapTab(int value) {
    tabC.animateTo(value);
    update();
  }
}
