part of '../imports/wishlist_imports.dart';

class WishlistController extends GetxController {
  final dataState = const DataState<String>.initial().obs;

  @override
  void onInit() {
    super.onInit();
    updateData();
  }

  void updateData() {
    dataState.value = const DataState<String>.loading();
    Future.delayed(const Duration(seconds: 2), () async {
      dataState.value = const DataState.error(DataError.error());
    });
  }

  @override
  void onClose() {
    super.onClose();
  }
}
