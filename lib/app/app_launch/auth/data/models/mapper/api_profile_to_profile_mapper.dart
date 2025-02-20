part of '../models.dart';

extension ApiProfileToProfileMapper on ApiProfile {
  ProfileInfo toProfileInfo() {
    return ProfileInfo(
      userInfo: UserInfo(
        id: id,
        documentId: documentId,
        email: email,
        username: username,
        provider: provider,
        firstName: firstName,
        lastName: lastName,
        image: image,
        createdAt: DateTime.tryParse(createdAt ?? ''),
        updatedAt: DateTime.tryParse(updatedAt ?? ''),
        blocked: blocked,
        confirmed: confirmed,
      ),
      role: role?.toRole(),
    );
  }
}
