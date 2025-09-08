import 'package:flutter_boilerplate/app/legal_document/data/datasource/legal_content_datasource.dart';
import 'package:flutter_boilerplate/app/legal_document/data/model/mapper/legal_document_mapper.dart';
import 'package:flutter_boilerplate/app/legal_document/data/model/ui/legal_document.dart';
import 'package:playx/playx.dart';

abstract class ILegalContentRepository {
  const ILegalContentRepository();
  Future<NetworkResult<LegalDocument>> getPrivacyPolicy();
  Future<NetworkResult<LegalDocument>> getTermsConditions();
}

class LegalContentRepository extends ILegalContentRepository {
  final LegalContentDatasource _datasource;
  const LegalContentRepository({required LegalContentDatasource datasource})
      : _datasource = datasource;

  static LegalContentRepository get instance =>
      getIt.get<LegalContentRepository>();

  @override
  Future<NetworkResult<LegalDocument>> getPrivacyPolicy() async {
    final result = await _datasource.getPrivacyPolicy();
    return result.mapDataAsyncInIsolate<LegalDocument>(
      mapper: (data) =>
          NetworkResult<LegalDocument>.success(data.toLocalLegalDocument()),
    );
  }

  @override
  Future<NetworkResult<LegalDocument>> getTermsConditions() async {
    final result = await _datasource.getTermsConditions();
    return result.mapDataAsyncInIsolate<LegalDocument>(
      mapper: (data) =>
          NetworkResult<LegalDocument>.success(data.toLocalLegalDocument()),
    );
  }
}

class TestLegalContentRepository extends ILegalContentRepository {
  const TestLegalContentRepository();

  static TestLegalContentRepository get instance =>
      getIt.get<TestLegalContentRepository>();

  @override
  Future<NetworkResult<LegalDocument>> getPrivacyPolicy() async {
    final localContent = _getLocalPrivacyPolicy();
    Future.delayed(const Duration(seconds: 2));
    return NetworkResult<LegalDocument>.success(localContent);
  }

  @override
  Future<NetworkResult<LegalDocument>> getTermsConditions() async {
    final localContent = _getLocalTermsConditions();
    Future.delayed(const Duration(seconds: 2));
    return NetworkResult<LegalDocument>.success(localContent);
  }

  LegalDocument _getLocalPrivacyPolicy() {
    return LegalDocument(
      id: 'privacy_001',
      title: 'Privacy Policy',
      content: _getPrivacyPolicyContent(),
      contentType: ContentType.markdown,
      type: LegalDocumentType.privacyPolicy,
      lastUpdated: DateTime.now().subtract(const Duration(days: 30)),
      version: '2.1.0',
      sections: _getPrivacySections(),
    );
  }

  LegalDocument _getLocalTermsConditions() {
    return LegalDocument(
      id: 'terms_001',
      title: 'Terms & Conditions',
      content: _getTermsContent(),
      contentType: ContentType.html,
      type: LegalDocumentType.termsConditions,
      lastUpdated: DateTime.now().subtract(const Duration(days: 15)),
      version: '3.0.0',
      sections: _getTermsSections(),
    );
  }

  String _getPrivacyPolicyContent() {
    return '''
# Privacy Policy

Last updated: ${DateTime.now().subtract(const Duration(days: 30)).toString().split(' ')[0]}

## 1. Information We Collect

We collect information you provide directly to us, such as:
- **Personal Information**: Name, email address, phone number
- **Usage Data**: App interactions, preferences, settings
- **Device Information**: Device type, OS version, unique identifiers

## 2. How We Use Your Information

We use the information we collect to:
- Provide and maintain our services
- Improve user experience
- Send important updates and notifications
- Comply with legal obligations

## 3. Data Security

We implement appropriate technical and organizational measures to protect your personal data against unauthorized access, alteration, disclosure, or destruction.

## 4. Your Rights

You have the right to:
- Access your personal data
- Correct inaccurate data
- Request deletion of your data
- Object to processing
- Data portability

## 5. Contact Us

If you have questions about this Privacy Policy, please contact us at:
- Email: privacy@example.com
- Phone: +1-800-PRIVACY
''';
  }

  String _getTermsContent() {
    return '''
<h1>Terms & Conditions</h1>
<p><strong>Effective Date:</strong> ${DateTime.now().subtract(const Duration(days: 15)).toString().split(' ')[0]}</p>

<h2>1. Acceptance of Terms</h2>
<p>By accessing or using our application, you agree to be bound by these Terms & Conditions.</p>

<h2>2. Use License</h2>
<ul>
  <li>Permission is granted to temporarily use this app for personal, non-commercial purposes</li>
  <li>This license shall automatically terminate if you violate any of these restrictions</li>
</ul>

<h2>3. Prohibited Uses</h2>
<p>You may not:</p>
<ol>
  <li>Modify or copy the materials</li>
  <li>Use the materials for commercial purposes</li>
  <li>Attempt to reverse engineer any software</li>
  <li>Remove any copyright or proprietary notations</li>
</ol>

<h2>4. Disclaimer</h2>
<p>The materials in this app are provided on an 'as is' basis. We make no warranties, expressed or implied.</p>

<h2>5. Limitations</h2>
<p>In no event shall our company be liable for any damages arising out of the use or inability to use the materials.</p>
''';
  }

  List<LegalSection> _getPrivacySections() {
    return [
      const LegalSection(
        id: 'privacy_1',
        title: 'Information Collection',
        content: 'Details about data collection practices...',
        order: 1,
      ),
      const LegalSection(
        id: 'privacy_2',
        title: 'Data Usage',
        content: 'How we use your information...',
        order: 2,
      ),
      const LegalSection(
        id: 'privacy_3',
        title: 'Security',
        content: 'Security measures in place...',
        order: 3,
      ),
    ];
  }

  List<LegalSection> _getTermsSections() {
    return [
      const LegalSection(
        id: 'terms_1',
        title: 'General Terms',
        content: 'Basic terms and conditions...',
        order: 1,
      ),
      const LegalSection(
        id: 'terms_2',
        title: 'Restrictions',
        content: 'Usage restrictions and limitations...',
        order: 2,
      ),
    ];
  }
}
