part of '../../../../imports/app_imports.dart';

class CustomDrawerBody extends StatelessWidget {
  final StatefulNavigationShell navigationShell;
  final bool isExpanded;

  const CustomDrawerBody({
    super.key,
    required this.navigationShell,
    this.isExpanded = true,
  });

  AppController get controller => AppController.instance;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      left: context.isLtr,
      right: context.isRtl,
      bottom: false,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 4.r),

          // Logo section
          Container(
            // width: isExpanded ? null : 24.r,
            height: 28.r,
            margin: EdgeInsetsDirectional.only(
              start: isExpanded ? 16.r : 0,
              top: isExpanded ? 6.r : 0,
              bottom: 6.r,
            ),
            alignment: Alignment.center,
            child: ImageViewer.svgAsset(
              isExpanded
                  ? Assets.logos.getHorizontalLogo(context.isDarkMode)
                  : Assets.logos.logo,
              height: isExpanded ? context.height * .05 : 28.r,
              color: context.isDarkMode ? Colors.white : null,
            ),
          ),

          SizedBox(height: isExpanded ? 10.r : 6.r),

          // Scrollable drawer items
          Expanded(
            child: Obx(() {
              final mainItems = controller.mainDrawerItems.toList();
              final moduleItems = controller.moduleDrawerItems.toList();

              return CustomScrollView(
                physics: const BouncingScrollPhysics(),
                slivers: [
                  // if (mainItems.isNotEmpty)
                  //   _buildSectionHeader(context, AppTrans.mainModulesLabel),
                  SliverList(
                    delegate: SliverChildBuilderDelegate((context, index) {
                      final item = mainItems[index];

                      return BuildDrawerItemWidget(
                        item: item,
                        isExpanded: isExpanded,
                        isSelected: navigationShell.currentIndex ==
                            item.navigationIndex,
                        onTap: () {
                          controller.handleDrawerMainItemClicked(
                            index: item.navigationIndex ?? index,
                            navigationShell: navigationShell,
                          );
                          HapticFeedback.selectionClick();
                        },
                      );
                    }, childCount: mainItems.length),
                  ),
                  if (isExpanded)
                    SliverToBoxAdapter(child: SizedBox(height: 12.r)),
                  // if (moduleItems.isNotEmpty) ...[
                  //   if (isExpanded)
                  //     _buildSectionHeader(context, AppTrans.activeModulesTitle)
                  //   else
                  //     SliverToBoxAdapter(
                  //       child: Padding(
                  //         padding: EdgeInsets.symmetric(horizontal: 12.0.r),
                  //         child: Divider(color: context.colors.onSurface),
                  //       ),
                  //     ),
                  //   SliverList(
                  //     delegate: SliverChildBuilderDelegate((context, index) {
                  //       final item = moduleItems[index];
                  //
                  //       return BuildDrawerItemWidget(
                  //         item: item,
                  //         isExpanded: isExpanded,
                  //         isSelected: item.navigationIndex ==
                  //             navigationShell.currentIndex,
                  //         onTap: () {
                  //           controller.handleDrawerModuleItemClicked(
                  //             item: item,
                  //             navigationShell: navigationShell,
                  //             index: index,
                  //           );
                  //           HapticFeedback.selectionClick();
                  //         },
                  //       );
                  //     }, childCount: moduleItems.length),
                  //   ),
                  // ],
                  SliverToBoxAdapter(child: SizedBox(height: 20.r)),
                ],
              );
            }),
          ),

          Divider(
            color: PlayxColors.white.withValues(alpha: .4),
            thickness: 1,
            indent: 8.r,
            endIndent: 8.r,
          ),

          // Support Button
          SupportButton(
            size: isExpanded ? 40 : 36,
            isShowLabel: true,
            isExpanded: isExpanded,
          ),

          // Column(
          //   children: List.generate(controller.otherDrawerItems.length, (
          //     index,
          //   ) {
          //     final item = controller.otherDrawerItems[index];
          //
          //     return BuildDrawerItemWidget(
          //       item: item,
          //       isExpanded: isExpanded,
          //       onTap: () {
          //         controller.handleDrawerOtherItemClicked(
          //           index: index,
          //           context: context,
          //         );
          //         index == 1
          //             ? HapticFeedback.heavyImpact()
          //             : HapticFeedback.selectionClick();
          //       },
          //     );
          //   }),
          // ),
          _buildUserProfileSection(context, isExpanded),

          if (isExpanded)
            Container(
              padding: EdgeInsets.all(isExpanded ? 8.r : 2.r),
              alignment: Alignment.center,
              child: AppVersion(
                showVersionCode: controller.showVersionCode.value,
                fontSize: isExpanded ? 12.sp : 9.sp,
                textStyle: TextStyle(
                  color: Colors.black.withValues(alpha: 0.5),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildUserProfileSection(BuildContext context, bool extended) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.0.r),
      child: Obx(() {
        final user = AppController.instance.currentUser.value;
        final name = user
            ?.getFullName(fallbackAsEmail: false)
            ?.capitalizeFirstCharForEachWord;
        final email = user?.email;

        return GestureDetector(
          onTap: () => controller.onUserProfileTap(
            context: context,
            user: user,
          ),
          child: _buildUserProfile(context, extended, name: name, email: email),
        );
      }),
    );
  }

  // Inside CustomDrawerBody

  Widget _buildUserProfile(
    BuildContext context,
    bool extended, {
    String? email,
    String? name,
  }) {
    if (!extended) {
      return Center(
        child: CircleAvatar(
          radius: 18.0.r,
          backgroundColor: context.colors.primaryContainer,
          // backgroundImage: userProfile?.image?.url != null
          //     ? CachedNetworkImage(userProfile!.image!.url!)
          //     : null,
          child: IconInfo.icon(
            Icons.person,
            size: 20.0.r,
            color: context.colors.onPrimaryContainer,
          ).buildIconWidget(),
        ),
      );
    }

    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeInOut,
      width: double.infinity,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      padding: EdgeInsets.symmetric(horizontal: 4.r, vertical: 8.r),
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
      ),
      child: Row(
        // Prevent Row from trying to be larger than parent
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // --- AVATAR (Always Visible) ---
          Container(
            width: 36.0.r,
            height: 36.0.r,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: context.colors.primaryContainer,
            ),
            child: Center(
              child: IconInfo.icon(
                Icons.person,
                size: 20.0.r,
                color: context.colors.onPrimaryContainer,
              ).buildIconWidget(),
            ),
          ),

          // --- TEXT INFO & SETTINGS (Hidden when collapsed) ---
          // We use Flexible + ClipRect to handle the width transition gracefully
          Expanded(
            flex: 4,
            child: ClipRect(
              child: AnimatedAlign(
                duration: const Duration(milliseconds: 200),
                curve: Curves.easeInOut,
                alignment: AlignmentDirectional.centerStart,
                // widthFactor: extended ? 1.0 : 0.0,
                // heightFactor: 1.0,
                child: Visibility(
                  visible: extended,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12.0.r),
                    child: Row(
                      spacing: 4.r,
                      children: [
                        Expanded(
                          flex: context.isPortrait ? 12 : 10,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CustomText(
                                name ?? '',
                                textStyle: context.headlineSmallTS.copyWith(
                                  color: context.colors.onSurface,
                                ),
                                maxLines: 1,
                                textOverflow: TextOverflow.ellipsis,
                              ),
                              CustomText(
                                email ?? '',
                                color: context.colors.subtitleTextColor,
                                fontSize: 12.sp,
                                maxLines: 1,
                                textOverflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                        Flexible(
                          child: IconInfo.icon(
                            Icons.settings_outlined,
                            size: 20.0.r,
                            color: context.colors.onSurface,
                          ).buildIconWidget(),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context, String title) {
    return SliverToBoxAdapter(
      child: ClipRect(
        child: AnimatedSize(
          duration: const Duration(milliseconds: 220),
          curve: Curves.easeOutCubic,
          child: AnimatedOpacity(
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeOut,
            opacity: isExpanded ? 1 : 0,
            child: isExpanded
                ? Padding(
                    padding: EdgeInsetsDirectional.only(
                      start: 12.r,
                      top: 8.r,
                      bottom: 8.r,
                    ),
                    child: CustomText(
                      title,
                      color: context.colors.subtitleTextColor,
                      fontSize: 11.sp,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.2,
                    ),
                  )
                : const SizedBox.shrink(),
          ),
        ),
      ),
    );
  }
}
