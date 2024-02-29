class DashboardItem {
  final int id;
  final String imageUrl;
  final String name;
  final String description;
  bool isFavorite;
  DashboardItem({
    required this.id,
    required this.imageUrl,
    required this.name,
    required this.description,
    this.isFavorite = false,
  });
}
