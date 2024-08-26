part of '../imports/wishlist_imports.dart';

class WishlistController extends GetxController {
  final dataState =
      Rx<DataState<List<WishlistItem>>>(const DataState.initial());

  final _repository = WishlistRepository();

  StreamSubscription<List<WishlistItem>>? _watchWishlistItemsSub;

  @override
  void onInit() {
    super.onInit();
    Fimber.d('PlayxRoute Binding Wishlist onInit');

    watchWishlistItems();
  }

  Future<void> watchWishlistItems() async {
    dataState.value = const DataState.loading();
    await Future.delayed(const Duration(seconds: 2));
    _watchWishlistItemsSub?.cancel();
    _watchWishlistItemsSub = _repository.watchAllWishlistItems().listen((data) {
      if (data.isEmpty) {
        dataState.value =
            const DataState<List<WishlistItem>>.error(DataError.empty());
        return;
      }
      dataState.value = DataState.success(data);
    });
  }

  @override
  void onClose() {
    _watchWishlistItemsSub?.cancel();
    super.onClose();
  }
}
