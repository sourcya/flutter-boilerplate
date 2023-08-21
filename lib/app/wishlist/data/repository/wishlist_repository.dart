class WishlistRepository {

  static final WishlistRepository _instance =
  WishlistRepository._internal();

  factory WishlistRepository() {
    return _instance;
  }

  WishlistRepository._internal();


}
