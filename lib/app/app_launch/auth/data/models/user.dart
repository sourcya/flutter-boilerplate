// ignore_for_file: avoid_dynamic_calls

import 'role.dart';

class User {
  final bool? confirmed;
  final bool? blocked;
  final String? id;
  final String? username;
  final String? email;
  final String? firstName;
  final String? lastName;
  final String? imageUrl;
  final String? provider;
  final String? createdAt;
  final String? updatedAt;
  final int? v;
  final Role? role;

  User({
    this.confirmed,
    this.blocked,
    this.id,
    this.username,
    this.firstName,
    this.lastName,
    this.imageUrl,
    this.email,
    this.provider,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.role,
  });

  String? getFullName({
    bool fallbackAsUserName = true,
    bool fallbackAsEmail = true,
  }) {
    if (firstName != null && lastName != null) {
      return '$firstName $lastName';
    }
    if (firstName != null) {
      return firstName;
    }
    if (lastName != null) {
      return lastName;
    }
    if (fallbackAsUserName && username != null) {
      return username;
    }
    if (fallbackAsEmail && email != null) {
      return email;
    }
    return null;
  }

  factory User.fromJson(dynamic json) {
    return User(
      confirmed: json['confirmed'] as bool?,
      blocked: json['blocked'] as bool?,
      id: json['_id'] as String?,
      username: json['username'] as String?,
      firstName: json['firstName'] as String?,
      lastName: json['lastName'] as String?,
      imageUrl: json['imageUrl'] as String?,
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
    map['firstName'] = firstName;
    map['lastName'] = lastName;
    map['imageUrl'] = imageUrl;
    map['provider'] = provider;
    map['createdAt'] = createdAt;
    map['updatedAt'] = updatedAt;
    map['__v'] = v;
    if (role != null) {
      map['role'] = role?.toJson();
    }
    return map;
  }

  @override
  String toString() {
    return 'User{confirmed: $confirmed, blocked: $blocked, id: $id, username: $username, email: $email, firstName: $firstName, lastName: $lastName, imageUrl: $imageUrl, provider: $provider, createdAt: $createdAt, updatedAt: $updatedAt, v: $v, role: $role}';
  }

  User copyWith({
    bool? confirmed,
    bool? blocked,
    String? id,
    String? username,
    String? email,
    String? firstName,
    String? lastName,
    String? imageUrl,
    String? provider,
    String? createdAt,
    String? updatedAt,
    int? v,
    Role? role,
  }) {
    return User(
      confirmed: confirmed ?? this.confirmed,
      blocked: blocked ?? this.blocked,
      id: id ?? this.id,
      username: username ?? this.username,
      email: email ?? this.email,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      imageUrl: imageUrl ?? this.imageUrl,
      provider: provider ?? this.provider,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      v: v ?? this.v,
      role: role ?? this.role,
    );
  }
}
