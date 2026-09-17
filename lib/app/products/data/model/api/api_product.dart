import 'package:playx/playx.dart';

/// Raw product JSON model as returned by `GET /products` on dummyjson.com.
///
/// All fields are nullable since this is a raw API contract - it should not
/// assume the backend always returns every field.
class ApiProduct {
  final int? id;
  final String? title;
  final String? description;
  final String? category;
  final num? price;
  final num? rating;
  final String? thumbnail;

  const ApiProduct({
    this.id,
    this.title,
    this.description,
    this.category,
    this.price,
    this.rating,
    this.thumbnail,
  });

  factory ApiProduct.fromJson(dynamic source) {
    final json = source as Map<String, dynamic>;
    return ApiProduct(
      id: asIntOrNull(json, 'id'),
      title: asStringOrNull(json, 'title'),
      description: asStringOrNull(json, 'description'),
      category: asStringOrNull(json, 'category'),
      price: asNumOrNull(json, 'price'),
      rating: asNumOrNull(json, 'rating'),
      thumbnail: asStringOrNull(json, 'thumbnail'),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'category': category,
      'price': price,
      'rating': rating,
      'thumbnail': thumbnail,
    };
  }
}
