part of '../models.dart';

class ApiRole {
  // 1
  final int id;
  // tsggss
  final String documentId;
  // Authenticated
  final String name;
  // Default role given to authenticated user.
  final String? description;
  // authenticated
  final String type;
  // 2024-09-10T13:10:32.075Z
  final String? createdAt;
  // 2024-09-11T23:22:05.628Z
  final String? updatedAt;
  // 2024-09-10T13:10:32.075Z
  final String? publishedAt;

  ApiRole({
    required this.id,
    required this.documentId,
    required this.name,
    this.description,
    required this.type,
    this.createdAt,
    this.updatedAt,
    this.publishedAt,
  });

  factory ApiRole.fromJson(dynamic json) => ApiRole(
    id: asIntOrNull(json as Map<String, dynamic>, 'id')!,
    documentId: asStringOrNull(json, 'documentId')!,
    name: asStringOrNull(json, 'name')!,
    description: asStringOrNull(json, 'description'),
    type: asStringOrNull(json, 'type')!,
    createdAt: asStringOrNull(json, 'createdAt'),
    updatedAt: asStringOrNull(json, 'updatedAt'),
    publishedAt: asStringOrNull(json, 'publishedAt'),
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'documentId': documentId,
    'name': name,
    'description': description,
    'type': type,
    'createdAt': createdAt,
    'updatedAt': updatedAt,
    'publishedAt': publishedAt,
  };
}
