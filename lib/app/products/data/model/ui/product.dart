import 'package:playx/playx.dart';

/// UI-facing product model used across the Products feature.
///
/// Non-nullable with sensible defaults, so views never need null-checks.
class Product extends Equatable {
  final int id;
  final String title;
  final String description;
  final String category;
  final double price;
  final double rating;
  final String thumbnail;

  const Product({
    this.id = 0,
    this.title = '',
    this.description = '',
    this.category = '',
    this.price = 0,
    this.rating = 0,
    this.thumbnail = '',
  });

  Product copyWith({
    int? id,
    String? title,
    String? description,
    String? category,
    double? price,
    double? rating,
    String? thumbnail,
  }) {
    return Product(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      category: category ?? this.category,
      price: price ?? this.price,
      rating: rating ?? this.rating,
      thumbnail: thumbnail ?? this.thumbnail,
    );
  }

  @override
  List<Object?> get props => [
        id,
        title,
        description,
        category,
        price,
        rating,
        thumbnail,
      ];

  @override
  String toString() => 'Product(id: $id, title: $title, category: $category)';
}
