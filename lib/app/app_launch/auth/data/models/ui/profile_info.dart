part of '../models.dart';

class ProfileInfo {
  final UserProfile userInfo;
  final Role? role;

  ProfileInfo({
    required this.userInfo,
    this.role,
  });
}
