class Settings {
  final bool? pushNotificationsEnabled;
  final bool? emailNotificationsEnabled;
  final bool? biometricEnabled;
  final bool? autoBackup;
  final bool? dataSync;
  final String? themeId;
  final String? languageCode;
  final NotificationSettings? notificationSettings;
  final SecuritySettings? securitySettings;
  final DataSettings? dataSettings;
  final PrivacySettings? privacySettings;
  final DateTime? lastUpdated;
  final String? deviceId;

  const Settings({
    this.pushNotificationsEnabled,
    this.emailNotificationsEnabled,
    this.biometricEnabled,
    this.autoBackup,
    this.dataSync,
    this.themeId,
    this.languageCode,
    this.notificationSettings,
    this.securitySettings,
    this.dataSettings,
    this.privacySettings,
    this.lastUpdated,
    this.deviceId,
  });
  Settings copyWith({
    bool? pushNotificationsEnabled,
    bool? emailNotificationsEnabled,
    bool? biometricEnabled,
    bool? autoBackup,
    bool? dataSync,
    String? themeId,
    String? languageCode,
    NotificationSettings? notificationSettings,
    SecuritySettings? securitySettings,
    DataSettings? dataSettings,
    PrivacySettings? privacySettings,
    DateTime? lastUpdated,
    String? deviceId,
  }) {
    return Settings(
      pushNotificationsEnabled:
          pushNotificationsEnabled ?? this.pushNotificationsEnabled,
      emailNotificationsEnabled:
          emailNotificationsEnabled ?? this.emailNotificationsEnabled,
      biometricEnabled: biometricEnabled ?? this.biometricEnabled,
      autoBackup: autoBackup ?? this.autoBackup,
      dataSync: dataSync ?? this.dataSync,
      themeId: themeId ?? this.themeId,
      languageCode: languageCode ?? this.languageCode,
      notificationSettings: notificationSettings ?? this.notificationSettings,
      securitySettings: securitySettings ?? this.securitySettings,
      dataSettings: dataSettings ?? this.dataSettings,
      privacySettings: privacySettings ?? this.privacySettings,
      lastUpdated: lastUpdated ?? this.lastUpdated,
      deviceId: deviceId ?? this.deviceId,
    );
  }

  factory Settings.fromJson(dynamic map) {
    final json = map as Map<String, dynamic>;
    return Settings(
      pushNotificationsEnabled: json['pushNotificationsEnabled'] as bool?,
      emailNotificationsEnabled: json['emailNotificationsEnabled'] as bool?,
      biometricEnabled: json['biometricEnabled'] as bool?,
      autoBackup: json['autoBackup'] as bool?,
      dataSync: json['dataSync'] as bool?,
      themeId: json['themeId'] as String?,
      languageCode: json['languageCode'] as String?,
      notificationSettings: json['notificationSettings'] != null
          ? NotificationSettings.fromJson(
              json['notificationSettings'] as Map<String, dynamic>)
          : null,
      securitySettings: json['securitySettings'] != null
          ? SecuritySettings.fromJson(
              json['securitySettings'] as Map<String, dynamic>)
          : null,
      dataSettings: json['dataSettings'] != null
          ? DataSettings.fromJson(json['dataSettings'] as Map<String, dynamic>)
          : null,
      privacySettings: json['privacySettings'] != null
          ? PrivacySettings.fromJson(
              json['privacySettings'] as Map<String, dynamic>)
          : null,
      lastUpdated: json['lastUpdated'] != null
          ? DateTime.parse(json['lastUpdated'] as String)
          : null,
      deviceId: json['deviceId'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'pushNotificationsEnabled': pushNotificationsEnabled,
      'emailNotificationsEnabled': emailNotificationsEnabled,
      'biometricEnabled': biometricEnabled,
      'autoBackup': autoBackup,
      'dataSync': dataSync,
      'themeId': themeId,
      'languageCode': languageCode,
      'notificationSettings': notificationSettings?.toJson(),
      'securitySettings': securitySettings?.toJson(),
      'dataSettings': dataSettings?.toJson(),
      'privacySettings': privacySettings?.toJson(),
      'lastUpdated': lastUpdated?.toIso8601String(),
      'deviceId': deviceId,
    };
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Settings &&
          runtimeType == other.runtimeType &&
          pushNotificationsEnabled == other.pushNotificationsEnabled &&
          emailNotificationsEnabled == other.emailNotificationsEnabled &&
          biometricEnabled == other.biometricEnabled &&
          autoBackup == other.autoBackup &&
          dataSync == other.dataSync &&
          themeId == other.themeId &&
          languageCode == other.languageCode;

  @override
  int get hashCode =>
      pushNotificationsEnabled.hashCode ^
      emailNotificationsEnabled.hashCode ^
      biometricEnabled.hashCode ^
      autoBackup.hashCode ^
      dataSync.hashCode ^
      themeId.hashCode ^
      languageCode.hashCode;

  @override
  String toString() {
    return 'Settings{pushNotificationsEnabled: $pushNotificationsEnabled, emailNotificationsEnabled: $emailNotificationsEnabled, biometricEnabled: $biometricEnabled, autoBackup: $autoBackup, dataSync: $dataSync, themeId: $themeId, languageCode: $languageCode}';
  }
}

class NotificationSettings {
  final bool pushEnabled;
  final bool emailEnabled;
  final bool smsEnabled;
  final List<String> enabledCategories;
  final TimeRange quietHours;
  final bool vibrationEnabled;
  final String soundPreference;

  const NotificationSettings({
    required this.pushEnabled,
    required this.emailEnabled,
    required this.smsEnabled,
    required this.enabledCategories,
    required this.quietHours,
    required this.vibrationEnabled,
    required this.soundPreference,
  });

  NotificationSettings copyWith({
    bool? pushEnabled,
    bool? emailEnabled,
    bool? smsEnabled,
    List<String>? enabledCategories,
    TimeRange? quietHours,
    bool? vibrationEnabled,
    String? soundPreference,
  }) =>
      NotificationSettings(
        pushEnabled: pushEnabled ?? this.pushEnabled,
        emailEnabled: emailEnabled ?? this.emailEnabled,
        smsEnabled: smsEnabled ?? this.smsEnabled,
        enabledCategories: enabledCategories ?? this.enabledCategories,
        quietHours: quietHours ?? this.quietHours,
        vibrationEnabled: vibrationEnabled ?? this.vibrationEnabled,
        soundPreference: soundPreference ?? this.soundPreference,
      );

  factory NotificationSettings.fromJson(Map<String, dynamic> json) {
    return NotificationSettings(
      pushEnabled: json['pushEnabled'] as bool,
      emailEnabled: json['emailEnabled'] as bool,
      smsEnabled: json['smsEnabled'] as bool,
      enabledCategories: List<String>.from(json['enabledCategories'] as List),
      quietHours:
          TimeRange.fromJson(json['quietHours'] as Map<String, dynamic>),
      vibrationEnabled: json['vibrationEnabled'] as bool,
      soundPreference: json['soundPreference'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'pushEnabled': pushEnabled,
      'emailEnabled': emailEnabled,
      'smsEnabled': smsEnabled,
      'enabledCategories': enabledCategories,
      'quietHours': quietHours.toJson(),
      'vibrationEnabled': vibrationEnabled,
      'soundPreference': soundPreference,
    };
  }
}

class SecuritySettings {
  final bool biometricEnabled;
  final bool twoFactorEnabled;
  final int sessionTimeout;
  final bool autoLockEnabled;
  final List<String> trustedDevices;
  final DateTime? lastPasswordChange;
  final bool loginNotificationsEnabled;

  const SecuritySettings({
    required this.biometricEnabled,
    required this.twoFactorEnabled,
    required this.sessionTimeout,
    required this.autoLockEnabled,
    required this.trustedDevices,
    this.lastPasswordChange,
    required this.loginNotificationsEnabled,
  });

  factory SecuritySettings.fromJson(Map<String, dynamic> json) {
    return SecuritySettings(
      biometricEnabled: json['biometricEnabled'] as bool,
      twoFactorEnabled: json['twoFactorEnabled'] as bool,
      sessionTimeout: json['sessionTimeout'] as int,
      autoLockEnabled: json['autoLockEnabled'] as bool,
      trustedDevices: List<String>.from(json['trustedDevices'] as List),
      lastPasswordChange: json['lastPasswordChange'] != null
          ? DateTime.parse(json['lastPasswordChange'] as String)
          : null,
      loginNotificationsEnabled: json['loginNotificationsEnabled'] as bool,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'biometricEnabled': biometricEnabled,
      'twoFactorEnabled': twoFactorEnabled,
      'sessionTimeout': sessionTimeout,
      'autoLockEnabled': autoLockEnabled,
      'trustedDevices': trustedDevices,
      'lastPasswordChange': lastPasswordChange?.toIso8601String(),
      'loginNotificationsEnabled': loginNotificationsEnabled,
    };
  }

  SecuritySettings copyWith({
    bool? biometricEnabled,
    bool? twoFactorEnabled,
    int? sessionTimeout,
    bool? autoLockEnabled,
    List<String>? trustedDevices,
    DateTime? lastPasswordChange,
    bool? loginNotificationsEnabled,
  }) =>
      SecuritySettings(
        biometricEnabled: biometricEnabled ?? this.biometricEnabled,
        twoFactorEnabled: twoFactorEnabled ?? this.twoFactorEnabled,
        sessionTimeout: sessionTimeout ?? this.sessionTimeout,
        autoLockEnabled: autoLockEnabled ?? this.autoLockEnabled,
        trustedDevices: trustedDevices ?? this.trustedDevices,
        lastPasswordChange: lastPasswordChange ?? this.lastPasswordChange,
        loginNotificationsEnabled:
            loginNotificationsEnabled ?? this.loginNotificationsEnabled,
      );
}

class DataSettings {
  final bool autoBackupEnabled;
  final bool dataSyncEnabled;
  final String backupFrequency;
  final List<String> syncedDataTypes;
  final int maxStorageSize;
  final bool compressionEnabled;
  final String cloudProvider;

  const DataSettings({
    required this.autoBackupEnabled,
    required this.dataSyncEnabled,
    required this.backupFrequency,
    required this.syncedDataTypes,
    required this.maxStorageSize,
    required this.compressionEnabled,
    required this.cloudProvider,
  });

  factory DataSettings.fromJson(Map<String, dynamic> json) {
    return DataSettings(
      autoBackupEnabled: json['autoBackupEnabled'] as bool,
      dataSyncEnabled: json['dataSyncEnabled'] as bool,
      backupFrequency: json['backupFrequency'] as String,
      syncedDataTypes: List<String>.from(json['syncedDataTypes'] as List),
      maxStorageSize: json['maxStorageSize'] as int,
      compressionEnabled: json['compressionEnabled'] as bool,
      cloudProvider: json['cloudProvider'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'autoBackupEnabled': autoBackupEnabled,
      'dataSyncEnabled': dataSyncEnabled,
      'backupFrequency': backupFrequency,
      'syncedDataTypes': syncedDataTypes,
      'maxStorageSize': maxStorageSize,
      'compressionEnabled': compressionEnabled,
      'cloudProvider': cloudProvider,
    };
  }

  DataSettings copyWith({
    bool? autoBackupEnabled,
    bool? dataSyncEnabled,
    String? backupFrequency,
    List<String>? syncedDataTypes,
    int? maxStorageSize,
    bool? compressionEnabled,
    String? cloudProvider,
  }) =>
      DataSettings(
        autoBackupEnabled: autoBackupEnabled ?? this.autoBackupEnabled,
        dataSyncEnabled: dataSyncEnabled ?? this.dataSyncEnabled,
        backupFrequency: backupFrequency ?? this.backupFrequency,
        syncedDataTypes: syncedDataTypes ?? this.syncedDataTypes,
        maxStorageSize: maxStorageSize ?? this.maxStorageSize,
        compressionEnabled: compressionEnabled ?? this.compressionEnabled,
        cloudProvider: cloudProvider ?? this.cloudProvider,
      );
}

class PrivacySettings {
  final bool analyticsEnabled;
  final bool crashReportingEnabled;
  final bool personalizedAdsEnabled;
  final bool dataCollectionEnabled;
  final List<String> blockedContacts;
  final String profileVisibility;
  final bool locationSharingEnabled;

  const PrivacySettings({
    required this.analyticsEnabled,
    required this.crashReportingEnabled,
    required this.personalizedAdsEnabled,
    required this.dataCollectionEnabled,
    required this.blockedContacts,
    required this.profileVisibility,
    required this.locationSharingEnabled,
  });

  PrivacySettings copyWith({
    bool? analyticsEnabled,
    bool? crashReportingEnabled,
    bool? personalizedAdsEnabled,
    bool? dataCollectionEnabled,
    List<String>? blockedContacts,
    String? profileVisibility,
    bool? locationSharingEnabled,
  }) {
    return PrivacySettings(
      analyticsEnabled: analyticsEnabled ?? this.analyticsEnabled,
      crashReportingEnabled:
          crashReportingEnabled ?? this.crashReportingEnabled,
      personalizedAdsEnabled:
          personalizedAdsEnabled ?? this.personalizedAdsEnabled,
      dataCollectionEnabled:
          dataCollectionEnabled ?? this.dataCollectionEnabled,
      blockedContacts: blockedContacts ?? this.blockedContacts,
      profileVisibility: profileVisibility ?? this.profileVisibility,
      locationSharingEnabled:
          locationSharingEnabled ?? this.locationSharingEnabled,
    );
  }

  factory PrivacySettings.fromJson(Map<String, dynamic> json) {
    return PrivacySettings(
      analyticsEnabled: json['analyticsEnabled'] as bool,
      crashReportingEnabled: json['crashReportingEnabled'] as bool,
      personalizedAdsEnabled: json['personalizedAdsEnabled'] as bool,
      dataCollectionEnabled: json['dataCollectionEnabled'] as bool,
      blockedContacts: List<String>.from(json['blockedContacts'] as List),
      profileVisibility: json['profileVisibility'] as String,
      locationSharingEnabled: json['locationSharingEnabled'] as bool,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'analyticsEnabled': analyticsEnabled,
      'crashReportingEnabled': crashReportingEnabled,
      'personalizedAdsEnabled': personalizedAdsEnabled,
      'dataCollectionEnabled': dataCollectionEnabled,
      'blockedContacts': blockedContacts,
      'profileVisibility': profileVisibility,
      'locationSharingEnabled': locationSharingEnabled,
    };
  }
}

class TimeRange {
  final int startHour;
  final int startMinute;
  final int endHour;
  final int endMinute;

  const TimeRange({
    required this.startHour,
    required this.startMinute,
    required this.endHour,
    required this.endMinute,
  });

  factory TimeRange.fromJson(Map<String, dynamic> json) {
    return TimeRange(
      startHour: json['startHour'] as int,
      startMinute: json['startMinute'] as int,
      endHour: json['endHour'] as int,
      endMinute: json['endMinute'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'startHour': startHour,
      'startMinute': startMinute,
      'endHour': endHour,
      'endMinute': endMinute,
    };
  }

  TimeRange copyWith({
    int? startHour,
    int? startMinute,
    int? endHour,
    int? endMinute,
  }) {
    return TimeRange(
      startHour: startHour ?? this.startHour,
      startMinute: startMinute ?? this.startMinute,
      endHour: endHour ?? this.endHour,
      endMinute: endMinute ?? this.endMinute,
    );
  }

  String get formattedStart =>
      '${startHour.toString().padLeft(2, '0')}:${startMinute.toString().padLeft(2, '0')}';
  String get formattedEnd =>
      '${endHour.toString().padLeft(2, '0')}:${endMinute.toString().padLeft(2, '0')}';
}

class StorageInfo {
  final int photos;
  final int videos;
  final int documents;
  final int cache;
  final int total;

  const StorageInfo({
    required this.photos,
    required this.videos,
    required this.documents,
    required this.cache,
    required this.total,
  });

  factory StorageInfo.fromJson(Map<String, dynamic> json) {
    return StorageInfo(
      photos: json['photos'] as int,
      videos: json['videos'] as int,
      documents: json['documents'] as int,
      cache: json['cache'] as int,
      total: json['total'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'photos': photos,
      'videos': videos,
      'documents': documents,
      'cache': cache,
      'total': total,
    };
  }

  StorageInfo copyWith({
    int? photos,
    int? videos,
    int? documents,
    int? cache,
    int? total,
  }) {
    return StorageInfo(
      photos: photos ?? this.photos,
      videos: videos ?? this.videos,
      documents: documents ?? this.documents,
      cache: cache ?? this.cache,
      total: total ?? this.total,
    );
  }
}
