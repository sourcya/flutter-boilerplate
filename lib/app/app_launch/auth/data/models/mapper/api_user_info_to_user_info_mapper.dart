part of '../models.dart';

extension ApiUserInfoToUserInfoMapper on ApiUserInfo {
  UserProfile toUserInfo() {
    return UserProfile(
      id: id,
      documentId: documentId,
      username: username,
      email: email,
      provider: provider,
      createdAt: DateTime.tryParse(createdAt ?? ''),
      updatedAt: DateTime.tryParse(updatedAt ?? ''),
      confirmed: confirmed,
      blocked: blocked,
      firstName: firstName,
      lastName: lastName,
      image: image,
    );
  }
}

extension UserInfoToApiUserInfoMapper on UserProfile {
  ApiUserInfo toApiUserInfo() {
    return ApiUserInfo(
      id: id,
      documentId: documentId ?? '',
      username: username,
      email: email,
      provider: provider,
      createdAt: createdAt?.toIso8601String(),
      updatedAt: updatedAt?.toIso8601String(),
      confirmed: confirmed,
      blocked: blocked,
      firstName: firstName,
      lastName: lastName,
      image: image,
    );
  }
}
