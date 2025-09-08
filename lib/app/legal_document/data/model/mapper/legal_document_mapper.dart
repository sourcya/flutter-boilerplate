import 'package:flutter_boilerplate/app/legal_document/data/model/api/legal_document.dart';
import 'package:flutter_boilerplate/app/legal_document/data/model/ui/legal_document.dart';

enum ContentType { html, markdown, plainText }

enum LegalDocumentType { privacyPolicy, termsConditions }

extension LocalLegalDocumentMapper on LegalDocument {
  ApiLegalDocument toApiLegalDocument() => ApiLegalDocument(
        id: id,
        title: title,
        content: content,
        contentType: contentType,
        type: type,
        lastUpdated: lastUpdated,
        version: version,
        sections: sections.map((e) => e.toApiLegalSection()).toList(),
      );
}

extension ApiLegalDocumentMapper on ApiLegalDocument {
  LegalDocument toLocalLegalDocument() => LegalDocument(
        id: id,
        title: title,
        content: content,
        contentType: contentType,
        type: type,
        lastUpdated: lastUpdated,
        version: version,
        sections: sections.map((e) => e.toLegalSection()).toList(),
      );
}

extension ApiLegalSectionMapper on ApiLegalSection {
  LegalSection toLegalSection() => LegalSection(
        id: id,
        title: title,
        content: content,
        order: order,
        subSections: subSections.map((e) => e.toLegalSection()).toList(),
      );
}

extension LegalSectionMapper on LegalSection {
  ApiLegalSection toApiLegalSection() => ApiLegalSection(
        id: id,
        title: title,
        content: content,
        order: order,
        subSections: subSections.map((e) => e.toApiLegalSection()).toList(),
      );
}
