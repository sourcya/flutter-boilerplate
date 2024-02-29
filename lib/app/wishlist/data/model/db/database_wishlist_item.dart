import 'package:objectbox/objectbox.dart';

@Entity()
class DatabaseWishlistItem {
  @Id(assignable: true)
  int id;

  String? name;

  String? imageUrl;

  @Property(type: PropertyType.date)
  DateTime? date;

  DatabaseWishlistItem({required this.id, this.name, this.imageUrl, this.date});
}
