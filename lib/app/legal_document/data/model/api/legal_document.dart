import 'package:flutter_boilerplate/app/legal_document/data/model/mapper/legal_document_mapper.dart';
import 'package:playx/playx.dart' show Equatable;

class ApiLegalDocument extends Equatable {
  final String id;
  final String title;
  final String content;
  final ContentType contentType;
  final LegalDocumentType type;
  final DateTime lastUpdated;
  final String version;
  final List<ApiLegalSection> sections;

  const ApiLegalDocument({
    required this.id,
    required this.title,
    required this.content,
    required this.contentType,
    required this.type,
    required this.lastUpdated,
    required this.version,
    this.sections = const [],
  });

  factory ApiLegalDocument.fromJson(dynamic json) {
    final map = json as Map<String, dynamic>;
    return ApiLegalDocument(
      id: map['id'] as String,
      title: map['title'] as String,
      content: map['content'] as String,
      contentType: ContentType.values.firstWhere(
        (e) => e.toString() == 'ContentType.${map['contentType']}',
        orElse: () => ContentType.plainText,
      ),
      type: LegalDocumentType.values.firstWhere(
        (e) => e.toString() == 'LegalDocumentType.${map['type']}',
      ),
      lastUpdated: DateTime.parse(map['lastUpdated'] as String),
      version: map['version'] as String,
      sections: (map['sections'] as List<dynamic>?)
              ?.map((e) => ApiLegalSection.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'contentType': contentType.toString().split('.').last,
      'type': type.toString().split('.').last,
      'lastUpdated': lastUpdated.toIso8601String(),
      'version': version,
      'sections': sections.map((e) => e.toJson()).toList(),
    };
  }

  @override
  List<Object?> get props =>
      [id, title, content, contentType, type, lastUpdated, version, sections];
}

class ApiLegalSection extends Equatable {
  final String id;
  final String title;
  final String content;
  final int order;
  final List<ApiLegalSection> subSections;

  const ApiLegalSection({
    required this.id,
    required this.title,
    required this.content,
    required this.order,
    this.subSections = const [],
  });

  factory ApiLegalSection.fromJson(Map<String, dynamic> json) {
    return ApiLegalSection(
      id: json['id'] as String,
      title: json['title'] as String,
      content: json['content'] as String,
      order: json['order'] as int,
      subSections: (json['subSections'] as List<dynamic>?)
              ?.map((e) => ApiLegalSection.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'order': order,
      'subSections': subSections.map((e) => e.toJson()).toList(),
    };
  }

  @override
  List<Object?> get props => [id, title, content, order, subSections];
}
