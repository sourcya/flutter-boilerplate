part of '../imports/legal_imports.dart';

class TermsConditionsView extends GetView<TermsConditionsController> {
  static const String route = '/terms-conditions';
  final bool isModal;

  const TermsConditionsView({
    super.key,
    this.isModal = false,
  });

  @override
  Widget build(BuildContext context) {
    if (isModal) {
      return _buildModalContent(context);
    }

    return PlayxThemeSwitchingArea(
      child: CustomScaffold(
        title: AppTrans.termsConditions,
        backgroundColor: context.colors.surface,
        actions: _buildActions(context),
        // bottomNavigationBar: _buildAcceptButton(context),
        child: _buildContent(context),
      ),
    );
  }

  List<Widget> _buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.copy, size: 20.r),
        onPressed: () => controller.copyToClipboard(context),
        tooltip: AppTrans.copyText,
        splashRadius: 20.r,
      )
          .animate()
          .fadeIn(delay: 400.ms)
          .scale(begin: const Offset(0.8, 0.8), end: const Offset(1, 1)),
      IconButton(
        icon: Icon(Icons.share, size: 20.r),
        onPressed: controller.shareContent,
        tooltip: AppTrans.shareText,
        splashRadius: 20.r,
      )
          .animate()
          .fadeIn(delay: 500.ms)
          .scale(begin: const Offset(0.8, 0.8), end: const Offset(1, 1)),
    ];
  }

  Widget _buildContent(BuildContext context) {
    return Obx(() {
      if (controller.hasError.value) {
        return _buildErrorState(context);
      }

      return Stack(
        children: [
          CustomScrollView(
            controller: controller.scrollController,
            physics: const BouncingScrollPhysics(),
            slivers: [
              SliverToBoxAdapter(
                child: _buildHeader(context),
              ),
              if (controller.document.value != null) ...[
                SliverPadding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  sliver: SliverToBoxAdapter(
                    child: ContentRenderer(
                      content: controller.document.value!.content,
                      contentType: controller.document.value!.contentType,
                    ),
                  ),
                ),
                if (controller.document.value!.sections.isNotEmpty)
                  _buildSections(context),
              ],
              SliverToBoxAdapter(
                child: SizedBox(height: 120.h),
              ),
            ],
          ),
          _buildScrollProgress(context),
          Obx(() {
            return LoadingOverlay(
              loadingStatus: controller.loadingStatus.value,
            );
          }),
        ],
      );
    });
  }

  Widget _buildModalContent(BuildContext context) {
    return SliverToBoxAdapter(
      child: Obx(() {
        if (controller.hasError.value) {
          return _buildErrorState(context);
        }

        return Column(
          children: [
            _buildHeader(context),
            if (controller.document.value != null) ...[
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: ContentRenderer(
                  content: controller.document.value!.content,
                  contentType: controller.document.value!.contentType,
                ),
              ),
            ],
            SizedBox(height: 16.h),
            _buildAcceptButton(context),
          ],
        );
      }),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Obx(() {
      if (controller.document.value == null) {
        return const SizedBox.shrink();
      }

      final doc = controller.document.value!;
      return Container(
        padding: EdgeInsets.all(20.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.description_outlined,
                  size: 32.r,
                  color: context.colors.primary,
                ).animate().fadeIn(duration: 600.ms).scale(
                      begin: const Offset(0.5, 0.5),
                      end: const Offset(1, 1),
                      duration: 600.ms,
                      curve: Curves.elasticOut,
                    ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        doc.title,
                        fontSize: 24.sp,
                        fontWeight: FontWeight.w700,
                        color: context.colors.primary,
                      )
                          .animate()
                          .fadeIn(duration: 600.ms, delay: 100.ms)
                          .slideX(begin: -0.2, end: 0, duration: 600.ms),
                      SizedBox(height: 4.h),
                      CustomText(
                        '${AppTrans.versionText} ${doc.version} • ${AppTrans.lastUpdatedText} ${_formatDate(doc.lastUpdated)}',
                        fontSize: 12.sp,
                        color: context.colors.onSurface.withValues(alpha: 0.6),
                      )
                          .animate()
                          .fadeIn(duration: 600.ms, delay: 200.ms)
                          .slideX(begin: -0.2, end: 0, duration: 600.ms),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    });
  }

  Widget _buildSections(BuildContext context) {
    return Obx(() {
      final sections = controller.document.value?.sections ?? [];

      return SliverPadding(
        padding: EdgeInsets.symmetric(vertical: 16.h),
        sliver: SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              final section = sections[index];
              return Obx(() => ExpandableSection(
                    section: section,
                    isExpanded: controller.isSectionExpanded(section.id),
                    onToggle: () => controller.toggleSection(section.id),
                  ));
            },
            childCount: sections.length,
          ),
        ),
      );
    });
  }

  Widget _buildScrollProgress(BuildContext context) {
    return Obx(() {
      final progress = controller.scrollProgress.value;

      return Positioned(
        top: 0,
        left: 0,
        right: 0,
        child: Container(
          height: 3.h,
          decoration: BoxDecoration(
            color: context.colors.primary.withValues(alpha: 0.1),
          ),
          child: FractionallySizedBox(
            alignment: Alignment.centerLeft,
            widthFactor: progress,
            child: Container(
              decoration: BoxDecoration(
                color: context.colors.primary,
                borderRadius:
                    BorderRadius.horizontal(right: Radius.circular(3.r)),
                boxShadow: [
                  BoxShadow(
                    color: context.colors.primary.withValues(alpha: 0.3),
                    blurRadius: 8,
                    offset: const Offset(2, 0),
                  ),
                ],
              ),
            ),
          ),
        ),
      )
          .animate()
          .fadeIn(duration: 400.ms)
          .slideY(begin: -1, end: 0, duration: 400.ms);
    });
  }

  Widget _buildErrorState(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.error_outline,
            size: 64.r,
            color: context.colors.error,
          )
              .animate()
              .fadeIn(duration: 600.ms)
              .scale(begin: const Offset(0.5, 0.5), end: const Offset(1, 1)),
          SizedBox(height: 16.h),
          CustomText(
            controller.errorMessage.value,
            fontSize: 16.sp,
            color: context.colors.onSurface,
            textAlign: TextAlign.center,
          ).animate().fadeIn(duration: 600.ms, delay: 200.ms),
          SizedBox(height: 24.h),
          ElevatedButton.icon(
            onPressed: controller.loadContent,
            icon: const Icon(Icons.refresh),
            label: const CustomText(AppTrans.retryText),
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24.r),
              ),
            ),
          )
              .animate()
              .fadeIn(duration: 600.ms, delay: 400.ms)
              .slideY(begin: 0.2, end: 0),
        ],
      ),
    );
  }

  Widget _buildAcceptButton(BuildContext context) {
    return Obx(() => AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          padding: EdgeInsets.all(16.r),
          decoration: BoxDecoration(
            color: context.colors.surface,
            border: Border(
              top: BorderSide(
                color: context.colors.outline.withValues(alpha: 0.2),
              ),
            ),
          ),
          child: SafeArea(
            top: false,
            child: ElevatedButton(
              onPressed:
                  controller.hasAccepted.value ? null : controller.acceptTerms,
              style: ElevatedButton.styleFrom(
                backgroundColor: context.colors.primary,
                foregroundColor: context.colors.onPrimary,
                padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 24.w),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
                elevation: 2,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (controller.hasAccepted.value)
                    Icon(Icons.check_circle, size: 20.r)
                        .animate()
                        .scale(duration: 300.ms),
                  if (controller.hasAccepted.value) SizedBox(width: 8.w),
                  CustomText(
                    controller.hasAccepted.value
                        ? 'Accepted'
                        : 'Accept Terms & Conditions',
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ],
              ),
            )
                .animate()
                .fadeIn(duration: 600.ms)
                .slideY(begin: 0.2, end: 0, duration: 600.ms),
          ),
        ));
  }

  String _formatDate(DateTime date) {
    final months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec'
    ];
    return '${months[date.month - 1]} ${date.day}, ${date.year}';
  }
}
