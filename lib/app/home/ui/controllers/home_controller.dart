import 'package:flutter/material.dart';
import 'package:flutter_boilerplate/core/utils/models/data_error.dart';
import 'package:flutter_boilerplate/core/utils/models/data_state.dart';
import 'package:playx/playx.dart';

import '../../../../core/navigation/app_navigation.dart';
import '../../../../core/preferences/preference_manger.dart';
import '../../../auth/data/models/user.dart';

class HomeController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late TabController tabC;
  AppNavigation appNavigation = AppNavigation.instance;

  MyPreferenceManger preferenceManger = MyPreferenceManger.instance;
  //example for data state;
  Rx<DataState<User>> userState = Rx(const DataState.initial());

  @override
  Future<void> onInit() async {
    tabC = TabController(length: 3, vsync: this);
    super.onInit();
    getCachedUser();
  }

  void onTapTab(int value) {
    tabC.animateTo(value);
    update();
  }

  Future<void> getCachedUser() async {
    userState.value = const DataState.loading();
    await 5.delay();
    final user = await preferenceManger.getSavedUser();
    if (user == null) {
      userState.value = const DataState.error(EmptyDataError());
    } else {
      userState.value = const DataState.error(DataError.noInternetError());

      await 3.delay();

      userState.value = DataState.success(user);
    }
  }

  Future<void> signOut() async {
    await preferenceManger.signOut();
    appNavigation.navigateFormSplashToHome();
  }
}
