// ignore_for_file: avoid_dynamic_calls

import 'role.dart';

class User {
  bool? confirmed;
  bool? blocked;
  String? id;
  String? username;
  String? email;
  String? provider;
  String? createdAt;
  String? updatedAt;
  int? v;
  Role? role;

  User({
    this.confirmed,
    this.blocked,
    this.id,
    this.username,
    this.email,
    this.provider,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.role,
  });

  factory User.fromJson(dynamic json) {
    return User(
      confirmed: json['confirmed'] as bool?,
      blocked: json['blocked'] as bool?,
      id: json['_id'] as String?,
      username: json['username'] as String?,
      email: json['email'] as String?,
      provider: json['provider'] as String?,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
      v: json['__v'] as int?,
      role: json['role'] != null ? Role.fromJson(json['role']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['confirmed'] = confirmed;
    map['blocked'] = blocked;
    map['_id'] = id;
    map['username'] = username;
    map['email'] = email;
    map['provider'] = provider;
    map['createdAt'] = createdAt;
    map['updatedAt'] = updatedAt;
    map['__v'] = v;
    if (role != null) {
      map['role'] = role?.toJson();
    }
    return map;
  }
}
