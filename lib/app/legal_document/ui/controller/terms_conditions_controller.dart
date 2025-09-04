part of '../imports/legal_imports.dart';

class TermsConditionsController extends LegalContentController {
  TermsConditionsController(super.repository);

  @override
  Future<void> loadContent() async {
    loadingStatus.value = const LoadingStatus.loading();
    hasError.value = false;
    errorMessage.value = "";

    try {
      final result = await repository.getTermsConditions();
      result.when(
        success: (document) {
          this.document.value = document;
          if (document.sections.isNotEmpty) {
            expandedSections.add(document.sections.first.id);
          }
        },
        
        
        error: (exception) {
          hasError.value = true;
          errorMessage.value = exception.errorMessage;
          Alert.error(message: exception.message);
        },
      );
    } catch (e) {
      hasError.value = true;
      errorMessage.value = 'Failed to load privacy policy: $e';
      Alert.error(message: errorMessage.value);
    } finally {
      loadingStatus.value = const LoadingStatus.idle();
    }
  }
}
