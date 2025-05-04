part of '../models.dart';

class ProfileInfo {
  final UserInfo userInfo;
  final Role? role;

  ProfileInfo({
    required this.userInfo,
    this.role,
  });
}
