part of '../imports/dashboard_imports.dart';

class DashboardController extends GetxController {
  final _wishlistRepository = WishlistRepository();

  final List<DashboardItem> _items = List.generate(
    20,
    (index) => DashboardItem(
      id: index + 1,
      imageUrl:
          'https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885_1280.jpg',
      name: 'Lorem ipsum #${index + 1}',
      description:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, consectetur adipiscing elit sed diam nonum y eirmod tempor invidunt ut labore et dol',
    ),
  );

  final dataState =
      Rx<DataState<List<DashboardItem>>>(const DataState.initial());

  @override
  void onInit() {
    super.onInit();
    getDashboardItems();
  }

  Future<void> getDashboardItems() async {
    dataState.value = const DataState.loading();
    final wishlistItems = await _wishlistRepository.getAllWishlistItems();

    for (final item in _items) {
      final isFavorite = wishlistItems.any((element) => element.id == item.id);
      item.isFavorite = isFavorite;
    }

    dataState.value = DataState.success(_items);
  }

  void onFavoriteChanged(bool isFavorite, DashboardItem item) {
    if (isFavorite) {
      _wishlistRepository.insertWishlistItem(
        WishlistItem(
          id: item.id,
          imageUrl: item.imageUrl,
          name: item.name,
        ),
      );
    } else {
      _wishlistRepository.deleteWishlistItem(
        WishlistItem(
          id: item.id,
          imageUrl: item.imageUrl,
          name: item.name,
        ),
      );
    }
  }
}
