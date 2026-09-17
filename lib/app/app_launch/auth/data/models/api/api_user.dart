part of '../models.dart';

/// Api user model.
class ApiUser {
  final String jwt;
  final ApiUserInfo userInfo;
  final ApiRole? role;

  ApiUser({
    required this.jwt,
    required this.userInfo,
    this.role,
  });

  factory ApiUser.fromJson(dynamic json, {MediaItem? image}) {
    final map = json as Map<String, dynamic>;
    final jwt = map['jwt'] as String;
    final user = ApiUserInfo.fromJson(map['user'], image: image);
    final role = map['role'] != null ? ApiRole.fromJson(map['role']) : null;
    return ApiUser(
      jwt: jwt,
      userInfo: user,
      role: role,
    );
  }

  static ApiUser? fromJsonOrNull(dynamic json) {
    if (json == null) return null;
    return ApiUser.fromJson(json);
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['jwt'] = jwt;
    map['user'] = userInfo.toJson();
    if (role != null) {
      map['role'] = role!.toJson();
    }
    return map;
  }
}
