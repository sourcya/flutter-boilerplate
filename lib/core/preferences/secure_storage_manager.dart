import 'dart:convert';
import 'dart:math';

import 'package:encrypter_plus/encrypter_plus.dart' as encrypt;
import 'package:flutter/foundation.dart';
import 'package:flutter_boilerplate/core/config/app_config.dart';
import 'package:playx/playx.dart';
import 'package:simple_secure_storage/simple_secure_storage.dart';

// Enum to define the desired storage strategy.
enum StorageType {
  /// Uses the platform's native secure storage (Keystore/Keychain).
  simple,

  /// Uses SharedPreferences with custom AES encryption as a fallback.
  asyncPrefs,

  /// **Recommended**: Tries to use `simple` secure storage. If initialization or a health check fails,
  /// it automatically falls back to `asyncPrefs` for the session.
  auto,
}

/// A secure storage manager that generates unique encryption keys on-device.
///
/// It prioritizes using the device's hardware-backed secure storage (Keystore/Keychain)
/// to generate and store keys. If this fails, it falls back to an encrypted
/// SharedPreferences implementation using a hardcoded key to ensure app functionality.
class SecureStorageManager {
  // --- Key Management ---
  // Keys to access our generated secrets within the device's secure storage.
  static const _encryptionKeyStorageKey = '_device_config_encryption_key_';
  static const _webKeyPasswordStorageKey = '_device_config_web_key_password_';
  static const _webEncryptionSaltStorageKey =
      '_device_config_web_encryption_salt_';

  // The AES encryption key, loaded or generated at runtime.
  static String? encryptionKey;
  // The web key password, loaded or generated at runtime.
  static String? webKeyPassword;
  // The web encryption salt, loaded or generated at runtime.
  static String? webEncryptionSalt;

  /// Flag indicating if the app is using the insecure hardcoded fallback keys.
  static bool _isUsingFallbackKeys = false;

  /// The AES encrypter, initialized at runtime after keys are available.
  static encrypt.Encrypter? _encrypter;
  static encrypt.Encrypter get _encrypterNonNull {
    if (_encrypter == null) {
      throw Exception(
        'Encrypter not initialized. Ensure SecureStorageHelper.init() has been called.',
      );
    }
    return _encrypter!;
  }

  // --- Class Implementation ---
  final StorageType _activeStorageType;

  const SecureStorageManager._(this._activeStorageType);

  /// Provides access to the singleton instance. Must call `init()` before use.
  static SecureStorageManager get instance => getIt.get<SecureStorageManager>();

  /// Initializes the secure storage, including on-device key generation/loading.
  /// This must be called once at app startup.
  static Future<void> init({StorageType type = StorageType.auto}) async {
    try {
      if (getIt.isRegistered<SecureStorageManager>()) {
        myLogger.w('SecureStorageHelper already initialized.');
        return;
      }

      // Step 0: Initialize the underlying simple_secure_storage package.
      await _initializeSimpleSecureStorage();
      // Step 1: Initialize keys from device storage or generate new ones.
      await _initializeKeys();

      // Step 2: Perform a health check to ensure storage is functional.
      await _performHealthCheck();

      // Step 3: Initialize the encrypter with the loaded/generated key.
      final key = encrypt.Key.fromUtf8(encryptionKey!);
      _encrypter = encrypt.Encrypter(encrypt.AES(key));

      // Step 4: Determine the active storage strategy.
      StorageType activeType;
      if (_isUsingFallbackKeys) {
        myLogger.w(
          'SECURE STORAGE: Device Keystore/Keychain failed. Forcing fallback to AsyncPrefs. 🛡️',
        );
        activeType = StorageType.asyncPrefs;
      } else {
        switch (type) {
          case StorageType.simple:
            activeType = StorageType.simple;
          case StorageType.asyncPrefs:
            activeType = StorageType.asyncPrefs;
          case StorageType.auto:
            try {
              activeType = StorageType.simple;
              myLogger.i(
                tag: 'SECURE STORAGE',
                'Initialized with SimpleSecureStorage. ✅',
              );
            } catch (e, s) {
              myLogger.e(
                'SECURE STORAGE: Health check failed. Falling back to AsyncPrefs. 🛡️',
                error: e,
                stackTrace: s,
              );
              Sentry.captureException(e, stackTrace: s);
              activeType = StorageType.asyncPrefs;
            }
        }
      }

      // Step 5: Register the singleton instance.
      getIt.registerSingleton<SecureStorageManager>(
          SecureStorageManager._(activeType));
      await instance._ensureFreshInstallHandled();
    } catch (e) {
      myLogger.e('CRITICAL: Failed to initialize SecureStorageManager. ',
          error: e);
      rethrow;
    }
  }

  /// Initializes keys by loading from device, generating if absent, or using a fallback on error.
  static Future<void> _initializeKeys() async {
    try {
      encryptionKey = await SimpleSecureStorage.read(_encryptionKeyStorageKey);
      webKeyPassword =
          await SimpleSecureStorage.read(_webKeyPasswordStorageKey);
      webEncryptionSalt =
          await SimpleSecureStorage.read(_webEncryptionSaltStorageKey);

      if (encryptionKey == null ||
          webKeyPassword == null ||
          webEncryptionSalt == null) {
        myLogger.e('Secrets not found. Generating and saving new secrets...');
        await _generateAndSaveNewKeys();
      } else {
        myLogger.i('Secrets successfully loaded from device storage.');
      }
      _isUsingFallbackKeys = false;
    } catch (e) {
      myLogger.e(
        'CRITICAL: Could not use device secure storage. Falling back to insecure keys. Error: $e',
      );
      _useHardcodedFallbackKeys();
      _isUsingFallbackKeys = true;
    }

    if (encryptionKey == null ||
        webKeyPassword == null ||
        webEncryptionSalt == null) {
      throw Exception('Failed to initialize secure config. Keys are null.');
    }
  }

  /// Generates and saves new random keys to the device's secure storage.
  static Future<void> _generateAndSaveNewKeys() async {
    encryptionKey = _generateRandomString(32);
    webKeyPassword = _generateRandomString(16);
    webEncryptionSalt = _generateRandomString(16);

    await SimpleSecureStorage.write(_encryptionKeyStorageKey, encryptionKey!);
    await SimpleSecureStorage.write(_webKeyPasswordStorageKey, webKeyPassword!);
    await SimpleSecureStorage.write(
        _webEncryptionSaltStorageKey, webEncryptionSalt!);
  }

  /// Assigns hardcoded, insecure keys as a last resort if device storage fails.
  static void _useHardcodedFallbackKeys() {
    encryptionKey = '#dgyD6gD[E#+]aCnf7HiJs=9v<F^,9D8'; // 32 bytes
    webKeyPassword = 'F7#kP9z@Wq2Lm!8r';
    webEncryptionSalt = 'X93eT1qZ&h4Bv6yM';
  }

  /// Generates a cryptographically secure random string.
  static String _generateRandomString(int length) {
    final random = Random.secure();
    const chars =
        'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    return List.generate(length, (index) => chars[random.nextInt(chars.length)])
        .join();
  }

  /// Internal initializer for `simple_secure_storage`.
  static Future<void> _initializeSimpleSecureStorage() async {
    if (kIsWeb) {
      await SimpleSecureStorage.initialize(
        WebInitializationOptions(
          keyPassword: webKeyPassword,
          encryptionSalt: webEncryptionSalt,
        ),
      );
    } else {
      await SimpleSecureStorage.initialize();
    }
  }

  /// Performs a write/read check to ensure storage is functional.
  static Future<void> _performHealthCheck() async {
    const healthCheckKey = '_secure_storage_health_check_';
    final testValue = Random().nextDouble().toString();
    try {
      await SimpleSecureStorage.write(healthCheckKey, testValue);
      final readValue = await SimpleSecureStorage.read(healthCheckKey);
      if (readValue != testValue) {
        throw Exception('Health check failed: Read value does not match.');
      }
    } finally {
      await SimpleSecureStorage.delete(healthCheckKey);
    }
  }

  // --- Public API Methods ---

  Future<void> setSecureString(String key, String value) async {
    if (value.isEmpty) return remove(key);
    try {
      if (_activeStorageType == StorageType.simple) {
        await _setWithSimple(key, value);
      } else {
        await _setWithPrefs(key, value);
      }
    } catch (e, s) {
      myLogger.e('SECURE STORAGE: Failed to set key "$key"',
          error: e, stackTrace: s);
      Sentry.captureException(e, stackTrace: s);
    }
  }

  Future<String?> getSecureString(String key) async {
    try {
      if (_activeStorageType == StorageType.simple) {
        return await _getWithSimple(key);
      } else {
        return await _getWithPrefs(key);
      }
    } catch (e, s) {
      myLogger.e('SECURE STORAGE: Failed to get key "$key"',
          error: e, stackTrace: s);
      Sentry.captureException(e, stackTrace: s);
      return null;
    }
  }

  Future<void> remove(String key) async {
    try {
      if (_activeStorageType == StorageType.simple) {
        await _removeWithSimple(key);
      } else {
        await _removeWithPrefs(key);
      }
    } catch (e, s) {
      myLogger.e('SECURE STORAGE: Failed to remove key "$key"',
          error: e, stackTrace: s);
      Sentry.captureException(e, stackTrace: s);
    }
  }

  Future<void> clearAll() async {
    myLogger.w(
        tag: 'SECURE STORAGE', 'Clearing all data from $_activeStorageType');
    try {
      if (_activeStorageType == StorageType.simple) {
        await SimpleSecureStorage.clear();
      } else {
        await PlayxAsyncPrefs.clear();
      }
    } catch (e, s) {
      myLogger.e('SECURE STORAGE: Failed to clear storage',
          error: e, stackTrace: s);
      Sentry.captureException(e, stackTrace: s);
    }
  }

  // --- Private Implementation Methods ---

  Future<void> _setWithSimple(String key, String value) =>
      SimpleSecureStorage.write(key, value);

  Future<String?> _getWithSimple(String key) async {
    return await SimpleSecureStorage.has(key)
        ? SimpleSecureStorage.read(key)
        : null;
  }

  Future<void> _removeWithSimple(String key) => SimpleSecureStorage.delete(key);

  Future<void> _setWithPrefs(String key, String value) {
    final encodedKey = base64Encode(utf8.encode(key));
    final encryptedValue = _encrypt(value);
    return PlayxAsyncPrefs.setString(encodedKey, encryptedValue);
  }

  Future<String?> _getWithPrefs(String key) async {
    final encodedKey = base64Encode(utf8.encode(key));
    final cipherValue = await PlayxAsyncPrefs.maybeGetString(encodedKey);
    return cipherValue != null ? _decrypt(cipherValue) : null;
  }

  Future<void> _removeWithPrefs(String key) {
    final encodedKey = base64Encode(utf8.encode(key));
    return PlayxAsyncPrefs.remove(encodedKey);
  }

  static const _installFlagKey = "is_first_install_marker";

  Future<void> _ensureFreshInstallHandled() async {
    try {
      final isFirstInstall = await PlayxAsyncPrefs.getBool(
        _installFlagKey,
        fallback: true,
      );
      if (isFirstInstall) {
        myLogger.i(
            tag: 'SECURE STORAGE', 'First install detected. Clearing storage.');
        await clearAll();
        await PlayxAsyncPrefs.setBool(_installFlagKey, false);
      }
    } on Exception catch (e, s) {
      myLogger.e('SECURE STORAGE', error: e, stackTrace: s);
      Sentry.captureException(e, stackTrace: s);
    }
  }

  // --- Encryption Logic ---

  static String _encrypt(String plainText) {
    final iv = encrypt.IV.fromSecureRandom(16);
    final encrypted = _encrypterNonNull.encrypt(plainText, iv: iv);
    final payload = jsonEncode({'iv': iv.base64, 'data': encrypted.base64});
    return base64Encode(utf8.encode(payload));
  }

  static String _decrypt(String cipherPayload) {
    final decoded = utf8.decode(base64Decode(cipherPayload));
    final map = jsonDecode(decoded);
    final iv = encrypt.IV.fromBase64(asString(map, 'iv'));
    final data = asString(map, 'data');
    return _encrypterNonNull.decrypt64(data, iv: iv);
  }
}
