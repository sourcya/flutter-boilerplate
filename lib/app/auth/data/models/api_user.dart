import 'user.dart';

/// Api user model.
class ApiUser {
  String? jwt;
  User? user;

  ApiUser({
    this.jwt,
    this.user,
  });

  ApiUser.fromJson(Map<String, dynamic> json) {
    jwt = json['jwt'] as String?;
    user = json['user'] != null ? User.fromJson(json['user']) : null;
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
