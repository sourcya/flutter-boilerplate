part of '../models.dart';

enum AccountPrivileges {
  user,
  subUser;

  String get value => switch (this) {
        AccountPrivileges.user => 'user',
        AccountPrivileges.subUser => 'subuser',
      };

  static AccountPrivileges fromString(String? value) {
    switch (value) {
      case 'subuser':
        return AccountPrivileges.subUser;
      default:
        return AccountPrivileges.user;
    }
  }

  String get displayName => AppTrans.privilegesTitle;
}
