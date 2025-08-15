import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  AndroidOptions _getAndroidOptions() => const AndroidOptions(
        encryptedSharedPreferences: true,
      );

  IOSOptions _getIOSOptions() => const IOSOptions(
        accountName: 'curd_assignment',
      );

  Future<void> saveValue({required final String? value, required final String key}) async {
    await const FlutterSecureStorage().write(
      key: key,
      value: value,
      aOptions: _getAndroidOptions(),
      iOptions: _getIOSOptions(),
    );
  }

  Future<String?> readValue(final String key) => const FlutterSecureStorage().read(
        key: key,
        aOptions: _getAndroidOptions(),
        iOptions: _getIOSOptions(),
      );

  Future<void> clearAll() => const FlutterSecureStorage().deleteAll();

  Future<void> clearData(final String key) async {
    await const FlutterSecureStorage().delete(key: key);
  }
}
