class UserModel {
  final int id;
  final String name;
  final String email;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
  });

  static UserModel fromMap(Map<String, dynamic> user) {
    throw UnimplementedError();
  }

  Map<String, dynamic> toMap() {
    return {};
  }
}
