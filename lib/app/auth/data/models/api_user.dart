import 'user.dart';

/// Api user model.
class ApiUser {
  String? jwt;
  User? user;

  ApiUser({
    this.jwt,
    this.user,
  });

  ApiUser.fromJson(dynamic json) {
    final map = json as Map<String, dynamic>;
    jwt = map['jwt'] as String?;
    user = map['user'] != null ? User.fromJson(map['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['jwt'] = jwt;
    if (user != null) {
      map['user'] = user?.toJson();
    }
    return map;
  }
}
