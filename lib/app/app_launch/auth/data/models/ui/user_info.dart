// ignore_for_file: avoid_dynamic_calls

part of '../models.dart';

class UserInfo {
  final int? id;
  final String? documentId;
  final String? username;
  final String? email;
  final String? firstName;
  final String? lastName;
  final MediaItem? image;
  final String? provider;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final bool? confirmed;
  final bool? blocked;

  UserInfo({
    this.id,
    this.documentId,
    this.username,
    this.firstName,
    this.lastName,
    this.image,
    this.email,
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

  @override
  String toString() {
    return 'UserInfo{ id: $id, username: $username, email: $email, '
        'firstName: $firstName, lastName: $lastName, imageUrl: ${image?.url},'
        ' provider: $provider,confirmed: $confirmed, blocked: $blocked, createdAt: $createdAt,'
        ' updatedAt: $updatedAt}';
  }

  UserInfo copyWith({
    int? id,
    String? documentId,
    String? username,
    String? email,
    String? firstName,
    String? lastName,
    MediaItem? image,
    String? provider,
    DateTime? createdAt,
    DateTime? updatedAt,
    Role? role,
    bool? confirmed,
    bool? blocked,
  }) {
    return UserInfo(
      id: id ?? this.id,
      documentId: documentId ?? this.documentId,
      username: username ?? this.username,
      email: email ?? this.email,
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
