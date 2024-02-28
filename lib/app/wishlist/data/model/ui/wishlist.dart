class WishlistItem {
  final int id;

  final String? name;

  final String? imageUrl;

  final DateTime? date;

  const WishlistItem({
    required this.id,
    this.name,
    this.imageUrl,
    this.date,
  });
}
