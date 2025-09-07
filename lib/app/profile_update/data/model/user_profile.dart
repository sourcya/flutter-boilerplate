import 'package:equatable/equatable.dart';

class UserProfile extends Equatable {
  final String id;
  final String name;
  final String email;
  final String phoneNumber;
  final String? profileImageUrl;
  final String? profileImagePath;
  final DateTime? dateOfBirth;
  final String? bio;
  final DateTime createdAt;
  final DateTime updatedAt;
  final ProfileStatus status;

  const UserProfile({
    required this.id,
    required this.name,
    required this.email,
    required this.phoneNumber,
    this.profileImageUrl,
    this.profileImagePath,
    this.dateOfBirth,
    this.bio,
    required this.createdAt,
    required this.updatedAt,
    this.status = ProfileStatus.active,
  });

  factory UserProfile.fromJson(dynamic json) {
    final map = json as Map<String, dynamic>;
    return UserProfile(
      id: map['id'] as String,
      name: map['name'] as String,
      email: map['email'] as String,
      phoneNumber: map['phoneNumber'] as String,
      profileImageUrl: map['profileImageUrl'] as String?,
      profileImagePath: map['profileImagePath'] as String?,
      dateOfBirth: map['dateOfBirth'] != null
          ? DateTime.parse(map['dateOfBirth'] as String)
          : null,
      bio: map['bio'] as String?,
      createdAt: DateTime.parse(map['createdAt'] as String),
      updatedAt: DateTime.parse(map['updatedAt'] as String),
      status: ProfileStatus.values.firstWhere(
        (e) => e.toString() == 'ProfileStatus.${map['status']}',
        orElse: () => ProfileStatus.active,
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phoneNumber': phoneNumber,
      'profileImageUrl': profileImageUrl,
      'profileImagePath': profileImagePath,
      'dateOfBirth': dateOfBirth?.toIso8601String(),
      'bio': bio,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'status': status.toString().split('.').last,
    };
  }

  UserProfile copyWith({
    String? id,
    String? name,
    String? email,
    String? phoneNumber,
    String? profileImageUrl,
    String? profileImagePath,
    DateTime? dateOfBirth,
    String? bio,
    DateTime? createdAt,
    DateTime? updatedAt,
    ProfileStatus? status,
  }) {
    return UserProfile(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      profileImageUrl: profileImageUrl ?? this.profileImageUrl,
      profileImagePath: profileImagePath ?? this.profileImagePath,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      bio: bio ?? this.bio,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [
        id,
        name,
        email,
        phoneNumber,
        profileImageUrl,
        profileImagePath,
        dateOfBirth,
        bio,
        createdAt,
        updatedAt,
        status,
      ];
}

enum ProfileStatus { active, inactive, suspended }
