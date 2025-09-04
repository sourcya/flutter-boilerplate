part of '../imports/legal_imports.dart';

abstract class LegalContentController extends GetxController {
  final LegalContentRepository repository;

  final Rx<LegalDocument?> document = Rx(null);
  final loadingStatus = Rx(const LoadingStatus.idle());
  final RxBool hasError = false.obs;
  final RxString errorMessage = ''.obs;
  final RxDouble scrollProgress = 0.0.obs;
  final RxBool hasAccepted = false.obs;
  final RxList<String> expandedSections = <String>[].obs;

  ScrollController? scrollController;

  LegalContentController(this.repository);

  @override
  void onInit() {
    super.onInit();
    scrollController = ScrollController()..addListener(_updateScrollProgress);
    loadContent();
  }

  @override
  void onClose() {
    scrollController?.removeListener(_updateScrollProgress);
    scrollController?.dispose();
    super.onClose();
  }

  void _updateScrollProgress() {
    if (scrollController != null && scrollController!.hasClients) {
      final maxScroll = scrollController!.position.maxScrollExtent;
      final currentScroll = scrollController!.position.pixels;
      scrollProgress.value =
          maxScroll > 0 ? (currentScroll / maxScroll).clamp(0.0, 1.0) : 0.0;
    }
  }

  Future<void> loadContent();

  void toggleSection(String sectionId) {
    if (expandedSections.contains(sectionId)) {
      expandedSections.remove(sectionId);
    } else {
      expandedSections.add(sectionId);
    }
  }

  bool isSectionExpanded(String sectionId) =>
      expandedSections.contains(sectionId);

  void acceptTerms() {
    hasAccepted.value = true;
    HapticFeedback.mediumImpact();
  }

  Future<void> copyToClipboard(BuildContext context) async {
    if (document.value != null) {
      await Clipboard.setData(ClipboardData(text: document.value!.content));
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const CustomText('Copied to clipboard'),
            behavior: SnackBarBehavior.floating,
            backgroundColor: context.colors.primary,
          ),
        );
      }
    }
  }

  Future<void> shareContent() async {
    if (document.value != null) {
      // Share.share(document.value!.content);
    }
  }
}
