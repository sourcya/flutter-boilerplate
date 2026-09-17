part of '../../../imports/settings_imports.dart';

class AccountSubscriptionCard extends StatelessWidget {
  const AccountSubscriptionCard({super.key, this.subscription});

  final Subscription? subscription;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final expired = subscription?.isSubscriptionExpired ?? false;
    final badgeColor =
        expired ? AppColors.semanticDestructive : colors.semanticGreen;

    return Container(
      width: double.infinity,
      padding: context.paddingAll(16),
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: colors.screenCardSurface,
        borderRadius: 16.radius,
        border: Border.all(color: colors.cardBorderColor),
      ),
      child: Row(
        children: [
          Container(
            width: 44.r,
            height: 44.r,
            padding: context.paddingAll(6),
            decoration: BoxDecoration(
              color: colors.settingsSubscriptionIconBackground,
              borderRadius: 12.radius,
            ),
            child: IconInfo.svg(
              Assets.icons.crown,
              size: 24.r,
              color: context.isDarkMode
                  ? colors.colorScheme.onSecondaryContainer
                  : colors.colorScheme.onSecondary,
            ).buildIconWidget(),
          ),
          8.wBox,
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  subscription?.privileges.displayName ?? AppTrans.privilegesTitle,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: colors.cardForeground,
                  height: 1.0,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
                8.hBox,
                CustomText(
                  subscription != null
                      ? '${AppTrans.expiryDate.tr(context: context)}: ${subscription!.subscriptionExpirationDateText(context)}'
                      : AppTrans.subscriptionSubtitle,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                  height: 1.43,
                  color: colors.mutedForeground,
                ),
              ],
            ),
          ),
          if (subscription != null) ...[
            8.wBox,
            Container(
              padding: context.paddingSymmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: badgeColor,
                borderRadius: BorderRadius.circular(9999.r),
              ),
              child: CustomText(
                subscription!.subscriptionStatusText(context),
                fontSize: 12.sp,
                fontWeight: FontWeight.w600,
                height: 1.33,
                color: colors.primaryActionText,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
