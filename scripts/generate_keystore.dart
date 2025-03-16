import 'dart:io';
import 'dart:math';

void main() async {
  final String password = generateSecurePassword();
  final String keyName = "sourcya_key";

  print("Generated Password: $password");

  // Ensure no existing keystore conflicts
  final keystoreFile = File("keystore.jks");
  if (keystoreFile.existsSync()) {
    keystoreFile.deleteSync();
    print("Old keystore deleted.");
  }

  final result = await Process.run(
    "keytool",
    [
      "-genkeypair", // Use -genkeypair instead of -genkey
      "-v",
      "-keystore", "keystore.jks",
      "-storetype", "JKS",
      "-keyalg", "RSA",
      "-keysize", "2048",
      "-validity", "10000",
      "-alias", keyName,
      "-dname",
      "CN=Sourcya, OU=Sourcya, O=Sourcya, L=Egypt, ST=Alexandria, C=EG",
      "-storepass", password, // Store Password
      "-keypass", password, // Key Password (matches Store Password)
    ],
    runInShell: true,
  );

  if (result.exitCode == 0) {
    print("✅ Keystore generated successfully! at ${keystoreFile.path}");
    print("🔑 Key Alias: $keyName");
    print("🔑 Key Password: $password");
    print("🔐 Store Password: $password");
  } else {
    print("❌ Error generating keystore: ${result.stderr}");
  }
}

/// Generates a secure password with at least one uppercase, lowercase, and digit.
String generateSecurePassword({int length = 12}) {
  const String upper = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
  const String lower = 'abcdefghijklmnopqrstuvwxyz';
  const String digits = '0123456789';
  const String special = '!@#\$%^&*()-_=+<>?';
  const String allChars = upper + lower + digits + special;

  final Random random = Random();
  return upper[random.nextInt(upper.length)] +
      lower[random.nextInt(lower.length)] +
      digits[random.nextInt(digits.length)] +
      List.generate(
              length - 3, (index) => allChars[random.nextInt(allChars.length)])
          .join();
}