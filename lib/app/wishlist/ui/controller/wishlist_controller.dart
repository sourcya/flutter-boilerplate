part of '../imports/wishlist_imports.dart';

class WishlistController extends GetxController {
  final dataState =
      Rx<DataState<List<WishlistItem>>>(const DataState.initial());

  final _repository = WishlistRepository();

  StreamSubscription<List<WishlistItem>>? _watchWishlistItemsSub;

  @override
  void onInit() {
    super.onInit();
    watchWishlistItems();
  }

  void watchWishlistItems() {
    dataState.value = const DataState.loading();
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
