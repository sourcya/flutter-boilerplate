part of '../imports/legal_imports.dart';

class TermsConditionsController extends LegalContentController {
  TermsConditionsController(super.repository);

  @override
  Future<void> loadContent() async {
    document.value = const DataState.loading();
    try {
      final result = await repository.getPrivacyPolicy();
      result.when(
        success: (data) {
          document.value = DataState.success(data);
          if (data.sections.isNotEmpty) {
            expandedSections.add(data.sections.first.id);
          }
        },
        error: (exception) {
          document.value = DataState.fromNetworkError(exception);
          Alert.error(message: exception.message);
        },
      );
    } catch (e) {
      final errorMessage = 'Failed to load privacy policy: $e';
      document.value = DataState.fromDefaultError(error: errorMessage);
      Alert.error(message: errorMessage);
    }
  }
}
