part of '../models.dart';

/// Api user model.
class User {
  final String jwtToken;
  final UserProfile info;
  final Role? role;

  User({
    required this.jwtToken,
    required this.info,
    this.role,
  });
}
