import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class CacheManager {
  CacheManager._();

  static const _androidOptions =
      AndroidOptions(encryptedSharedPreferences: true);
  static const _iosOptions =
      IOSOptions(accessibility: KeychainAccessibility.first_unlock);

  static const FlutterSecureStorage _secureStorage =
      FlutterSecureStorage(iOptions: _iosOptions, aOptions: _androidOptions);

  static Future<void> setString(String key, String value) async =>
      await _secureStorage.write(key: key, value: value);

  static Future<String?> getString(String key) async =>
      await _secureStorage.read(key: key);

  static Future<bool> containsKey(String key) async =>
      await _secureStorage.containsKey(key: key);
  static Future<void> setBool(String key, bool value) async =>
      await _secureStorage.write(key: key, value: value.toString());

  static Future<void> clearAll() async => await _secureStorage.deleteAll();
}
