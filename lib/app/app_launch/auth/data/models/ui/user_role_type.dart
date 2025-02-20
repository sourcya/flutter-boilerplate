part of '../models.dart';

enum UserRoleType {
  user,
  moderator;

  static UserRoleType fromString(String value) {
    switch (value) {
      case 'moderator':
        return UserRoleType.moderator;
      default:
        return UserRoleType.user;
    }
  }

  String get value {
    switch (this) {
      case UserRoleType.user:
        return 'authenticated';
      case UserRoleType.moderator:
        return 'moderator';
    }
  }
}
