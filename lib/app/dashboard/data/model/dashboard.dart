import 'package:playx/playx.dart';

class DashboardItem extends Equatable {
  final int id;
  final String imageUrl;
  final String name;
  final String description;
  final String category;
  final bool isFavorite;

  const DashboardItem({
    required this.id,
    required this.imageUrl,
    required this.name,
    required this.description,
    this.category = 'Operations',
    this.isFavorite = false,
  });

  DashboardItem copyWith({
    int? id,
    String? imageUrl,
    String? name,
    String? description,
    String? category,
    bool? isFavorite,
  }) {
    return DashboardItem(
      id: id ?? this.id,
      imageUrl: imageUrl ?? this.imageUrl,
      name: name ?? this.name,
      description: description ?? this.description,
      category: category ?? this.category,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }

  @override
  List<Object?> get props => [
        id,
        imageUrl,
        name,
        description,
        category,
        isFavorite,
      ];

  @override
  String toString() =>
      'DashboardItem(id: $id, name: $name, category: $category)';
}
