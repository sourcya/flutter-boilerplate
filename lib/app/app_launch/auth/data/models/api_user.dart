import 'package:auth0_flutter/auth0_flutter.dart';

import 'user.dart';

/// Api user model.
class ApiUser {
  final String? jwt;
  final User? user;

  ApiUser({
    this.jwt,
    this.user,
  });

  factory ApiUser.fromJson(dynamic json) {
    final map = json as Map<String, dynamic>;
    final jwt = map['jwt'] as String?;
    final user = map['user'] != null ? User.fromJson(map['user']) : null;
    return ApiUser(
      jwt: jwt,
      user: user,
    );
  }

  static ApiUser? fromJsonOrNull(dynamic json) {
    if (json == null) return null;
    return ApiUser.fromJson(json);
  }

  factory ApiUser.fromJsonAndCredentials({
    dynamic json,
    required Credentials credentials,
  }) {
    final apiUser = ApiUser.fromJson(json);
    final firstName = credentials.user.givenName ?? credentials.user.name;
    final lastName = credentials.user.familyName;
    final imageUrl = credentials.user.pictureUrl.toString();
    final user = ApiUser(
      jwt: apiUser.jwt,
      user: apiUser.user?.copyWith(
        firstName: firstName,
        lastName: lastName,
        imageUrl: imageUrl,
      ),
    );
    return user;
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
