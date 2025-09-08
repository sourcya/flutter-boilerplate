import 'package:flutter_boilerplate/app/legal_document/data/model/mapper/legal_document_mapper.dart';
import 'package:playx/playx.dart' show Equatable;

class LegalDocument extends Equatable {
  final String id;
  final String title;
  final String content;
  final ContentType contentType;
  final LegalDocumentType type;
  final DateTime lastUpdated;
  final String version;
  final List<LegalSection> sections;

  const LegalDocument({
    required this.id,
    required this.title,
    required this.content,
    required this.contentType,
    required this.type,
    required this.lastUpdated,
    required this.version,
    this.sections = const [],
  });

  @override
  List<Object?> get props =>
      [id, title, content, contentType, type, lastUpdated, version, sections];
}

class LegalSection extends Equatable {
  final String id;
  final String title;
  final String content;
  final int order;
  final List<LegalSection> subSections;

  const LegalSection({
    required this.id,
    required this.title,
    required this.content,
    required this.order,
    this.subSections = const [],
  });

  @override
  List<Object?> get props => [id, title, content, order, subSections];
}
