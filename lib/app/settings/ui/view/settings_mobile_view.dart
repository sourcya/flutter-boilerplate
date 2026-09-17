part of '../imports/settings_imports.dart';

class SettingsMobileView extends GetView<SettingsController> {
  final bool isInitialized;

  const SettingsMobileView({super.key, this.isInitialized = true});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      isInitialized: isInitialized,
      title: AppTrans.settings,
      bodyAlignment: Alignment.topCenter,
      backgroundColor: context.colors.bgMuted50,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SettingsMobileTabStripWidget(controller: controller),
          Expanded(
            child: TabBarView(
              controller: controller.tabController,
              children: SettingsTabs.visibleTabs.map((tab) {
                return CustomScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  slivers: [
                    switch (tab) {
                      SettingsTabs.account => AccountMobileLayoutTab(
                          key: ValueKey(tab.title),
                        ),
                      SettingsTabs.preferences => PreferencesMobileLayoutTab(
                          key: ValueKey(tab.title),
                        ),
                      SettingsTabs.notifications => NotificationsMobileLayoutTab(
                          key: ValueKey(tab.title),
                        ),
                      SettingsTabs.activeModules => ActiveModulesMobileLayoutTab(
                          key: ValueKey(tab.title),
                        ),
                    },
                  ],
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}

class SettingsMobileTabStripWidget extends StatelessWidget {
  const SettingsMobileTabStripWidget({super.key, required this.controller});

  final SettingsController controller;

  @override
  Widget build(BuildContext context) {
    return AppScrollableTabBar(
      controller: controller.tabController,
      isScrollable: true,
      padding: context.paddingOnly(top: 16, start: 16, end: 16),
      backgroundColor: context.colors.appBar,
      semanticsLabel: 'Settings tabs',
      tabPadding: context.paddingSymmetric(horizontal: 16),
      items: SettingsTabs.visibleTabs
          .map(
            (tab) => AppScrollableTabBarItem(
              label: tab.title.tr(context: context),
            ),
          )
          .toList(),
    );
  }
}
