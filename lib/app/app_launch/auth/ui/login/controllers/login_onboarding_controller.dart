part of '../imports/login_imports.dart';

class LoginOnboardingController extends GetxController {
  final RxInt currentPage = 0.obs;

  int get totalPages => loginOnboardingSlides.length;

  Timer? _autoPlayTimer;
  static const Duration autoPlayInterval = Duration(seconds: 5);

  @override
  void onInit() {
    super.onInit();
    _startAutoPlay();
  }

  @override
  void onClose() {
    _stopAutoPlay();
    super.onClose();
  }

  void _startAutoPlay() {
    _autoPlayTimer = Timer.periodic(autoPlayInterval, (_) {
      nextPage();
    });
  }

  void _stopAutoPlay() {
    _autoPlayTimer?.cancel();
    _autoPlayTimer = null;
  }

  void _resetAutoPlay() {
    _stopAutoPlay();
    _startAutoPlay();
  }

  void onPageChanged(int index) {
    currentPage.value = index;
    _resetAutoPlay();
  }

  void nextPage() {
    if (currentPage.value < totalPages - 1) {
      currentPage.value++;
    } else {
      currentPage.value = 0;
    }
  }

  void goToPage(int page) {
    if (page >= 0 && page < totalPages) {
      currentPage.value = page;
      _resetAutoPlay();
    }
  }
}
