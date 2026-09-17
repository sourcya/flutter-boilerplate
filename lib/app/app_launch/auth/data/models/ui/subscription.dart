part of '../models.dart';

class Subscription {
  final String? arabicName;
  final String? englishName;
  final String username;
  final String email;
  final String? phoneNumber;
  final DateTime? expiryDate;
  final bool isActive;
  final bool isNonExpiring;
  final AccountPrivileges privileges;

  const Subscription({
    required this.username,
    required this.email,
    this.arabicName,
    this.englishName,
    this.phoneNumber,
    this.expiryDate,
    this.isActive = true,
    this.isNonExpiring = false,
    this.privileges = AccountPrivileges.user,
  });

  bool get isSubscriptionExpired =>
      !isActive ||
      (!isNonExpiring &&
          expiryDate != null &&
          DateTime.now().toUtc().isAfter(expiryDate!.toUtc()));

  String subscriptionExpirationDateText(BuildContext context) {
    if (expiryDate == null && !isNonExpiring) {
      return AppTrans.expirationDateError.tr(context: context);
    }
    if (expiryDate == null && isActive) {
      return AppTrans.noExpiryDateText.tr(context: context);
    }
    if (expiryDate == null) {
      return '';
    }
    final dateText =
        MaterialLocalizations.of(context).formatFullDate(expiryDate!);
    if (DateTime.now().isAfter(expiryDate!)) {
      return '${AppTrans.subscriptionExpiredAtText.tr(context: context)} $dateText';
    }
    return '${AppTrans.subscriptionValidUntilText.tr(context: context)} $dateText';
  }

  String subscriptionStatusText(BuildContext context) => isSubscriptionExpired
      ? AppTrans.expired.tr(context: context)
      : AppTrans.active.tr(context: context);
}
