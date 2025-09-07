// ignore_for_file: avoid_dynamic_calls

part of '../models.dart';

class ApiUserInfo {
  final int? id;
  final String documentId;
  final String? username;
  final String? email;
  final String? mobileNumber;
  final String? firstName;
  final String? lastName;
  final MediaItem? image;
  final String? provider;
  final String? createdAt;
  final String? updatedAt;
  final bool? confirmed;
  final bool? blocked;

  ApiUserInfo({
    this.id,
    required this.documentId,
    this.username,
    this.firstName,
    this.lastName,
    this.image,
    this.email,
    this.mobileNumber,
    this.provider,
    this.createdAt,
    this.updatedAt,
    this.confirmed,
    this.blocked,
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

  factory ApiUserInfo.fromJson(dynamic json, {MediaItem? image}) {
    final map = json as Map<String, dynamic>;
    return ApiUserInfo(
      documentId: asStringOrNull(map, 'documentId')!,
      id: asIntOrNull(map, 'id'),
      username: asStringOrNull(map, 'username'),
      email: asStringOrNull(map, 'email'),
      mobileNumber: asStringOrNull(map, 'mobileNumber'),
      firstName: asStringOrNull(json, 'firstName'),
      lastName: asStringOrNull(json, 'lastName'),
      image: (json['image'] == null
          ? image
          : MediaItem.fromJson(asMap(json, 'image'))),
      provider: asStringOrNull(map, 'provider'),
      createdAt: asStringOrNull(map, 'createdAt'),
      updatedAt: asStringOrNull(map, 'updatedAt'),
      confirmed: asBoolOrNull(map, 'confirmed'),
      blocked: asBoolOrNull(map, 'blocked'),
    );
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['documentId'] = documentId;
    map['username'] = username;
    map['email'] = email;
    map['mobileNumber'] = mobileNumber;
    map['firstName'] = firstName;
    map['lastName'] = lastName;
    map['image'] = image?.toJson();
    map['provider'] = provider;
    map['createdAt'] = createdAt;
    map['updatedAt'] = updatedAt;
    map['confirmed'] = confirmed;
    map['blocked'] = blocked;
    return map;
  }

  @override
  String toString() {
    return 'User{ id: $id, username: $username, email: $email, mobileNumber: $mobileNumber, firstName: $firstName, lastName: $lastName, '
        'imageUrl: ${image?.url}, provider: $provider, createdAt: $createdAt, updatedAt: $updatedAt, confirmed: $confirmed, blocked: $blocked,}';
  }

  ApiUserInfo copyWith({
    int? id,
    String? documentId,
    String? username,
    String? email,
    String? mobileNumber,
    String? firstName,
    String? lastName,
    MediaItem? image,
    String? provider,
    String? createdAt,
    String? updatedAt,
    bool? confirmed,
    bool? blocked,
  }) {
    return ApiUserInfo(
      id: id ?? this.id,
      documentId: documentId ?? this.documentId,
      username: username ?? this.username,
      email: email ?? this.email,
      mobileNumber: mobileNumber ?? this.mobileNumber,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      image: image ?? this.image,
      provider: provider ?? this.provider,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      confirmed: confirmed ?? this.confirmed,
      blocked: blocked ?? this.blocked,
    );
  }
}
