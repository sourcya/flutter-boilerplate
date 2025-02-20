part of '../models.dart';

extension ApiUserToUserMapper on ApiUser {
  User toUser() {
    return User(
      jwtToken: jwt,
      info: userInfo.toUserInfo(),
      role: role?.toRole(),
    );
  }
}

extension UserToApiUserMapper on User {
  ApiUser toApiUser() {
    return ApiUser(
      jwt: jwtToken,
      userInfo: info.toApiUserInfo(),
      role: role?.toApiRole(),
    );
  }
}
