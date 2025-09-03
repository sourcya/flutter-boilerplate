part of '../imports/wishlist_imports.dart';

class WishlistController extends GetxController {
  final WishlistRepository _repository;
  WishlistController({required WishlistRepository repository})
      : _repository = repository;

  final dataState =
      Rx<DataState<List<WishlistItem>>>(const DataState.initial());

  StreamSubscription<List<WishlistItem>>? _watchWishlistItemsSub;

  @override
  void onInit() {
    super.onInit();
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
