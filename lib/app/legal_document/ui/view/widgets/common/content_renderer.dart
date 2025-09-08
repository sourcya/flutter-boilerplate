part of '../../../imports/legal_imports.dart';

class ContentRenderer extends StatelessWidget {
  final String content;
  final ContentType contentType;
  final ScrollController? scrollController;

  const ContentRenderer({
    super.key,
    required this.content,
    required this.contentType,
    this.scrollController,
  });

  @override
  Widget build(BuildContext context) {
    Widget contentWidget;

    switch (contentType) {
      case ContentType.html:
        contentWidget = _buildHtmlContent(context);
      case ContentType.markdown:
        contentWidget = _buildMarkdownContent(context);
      case ContentType.plainText:
        contentWidget = _buildPlainTextContent(context);
    }

    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 500),
      switchInCurve: Curves.easeInOut,
      switchOutCurve: Curves.easeInOut,
      transitionBuilder: (Widget child, Animation<double> animation) {
        return FadeTransition(
          opacity: animation,
          child: SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0, 0.05),
              end: Offset.zero,
            ).animate(CurvedAnimation(
              parent: animation,
              curve: Curves.easeOutCubic,
            )),
            child: child,
          ),
        );
      },
      child: contentWidget,
    );
  }

  Widget _buildHtmlContent(BuildContext context) {
    return Html(
      data: content,
      style: {
        "body": Style(
          fontSize: FontSize(14.sp),
          color: context.colors.onSurface,
          padding: HtmlPaddings.symmetric(horizontal: 16.w),
        ),
        "h1": Style(
          fontSize: FontSize(24.sp),
          fontWeight: FontWeight.w700,
          color: context.colors.primary,
          margin: Margins.only(top: 24.h, bottom: 16.h),
        ),
        "h2": Style(
          fontSize: FontSize(20.sp),
          fontWeight: FontWeight.w600,
          color: context.colors.primary.withValues(alpha: 0.9),
          margin: Margins.only(top: 20.h, bottom: 12.h),
        ),
        "p": Style(
          lineHeight: const LineHeight(1.6),
          margin: Margins.only(bottom: 12.h),
        ),
        "ul": Style(
          padding: HtmlPaddings.only(left: 20.w),
        ),
        "li": Style(
          margin: Margins.only(bottom: 8.h),
        ),
      },
      onLinkTap: (url, attributes, element) {
        if (url != null) {
          launchUrl(Uri.parse(url));
        }
      },
    )
        .animate()
        .fadeIn(duration: 600.ms)
        .slideY(begin: 0.05, end: 0, duration: 600.ms);
  }

  Widget _buildMarkdownContent(BuildContext context) {
    return MarkdownBody(
      data: content,
      styleSheet: MarkdownStyleSheet(
        h1: TextStyle(
          fontSize: 24.sp,
          fontWeight: FontWeight.w700,
          color: context.colors.primary,
        ),
        h2: TextStyle(
          fontSize: 20.sp,
          fontWeight: FontWeight.w600,
          color: context.colors.primary.withValues(alpha: 0.9),
        ),
        p: TextStyle(
          fontSize: 14.sp,
          height: 1.6,
          color: context.colors.onSurface,
        ),
        listBullet: TextStyle(
          fontSize: 14.sp,
          color: context.colors.primary,
        ),
        strong: TextStyle(
          fontWeight: FontWeight.w600,
          color: context.colors.onSurface,
        ),
      ),
      onTapLink: (text, href, title) {
        if (href != null) {
          launchUrl(Uri.parse(href));
        }
      },
    )
        .animate()
        .fadeIn(duration: 600.ms)
        .slideY(begin: 0.05, end: 0, duration: 600.ms);
  }

  Widget _buildPlainTextContent(BuildContext context) {
    return SelectableText(
      content,
      style: TextStyle(
        fontSize: 14.sp,
        height: 1.6,
        color: context.colors.onSurface,
      ),
    )
        .animate()
        .fadeIn(duration: 600.ms)
        .slideY(begin: 0.05, end: 0, duration: 600.ms);
  }
}
