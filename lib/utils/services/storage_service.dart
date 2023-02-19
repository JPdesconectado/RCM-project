import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:random_color_generator/features/random_generator/domain/random_color_model.dart';

/// class to work in Flutter Secure Storage
class StorageService {
  final _secureStorage = const FlutterSecureStorage();
  AndroidOptions _getAndroidOptions() => const AndroidOptions(
        encryptedSharedPreferences: true,
        preferencesKeyPrefix: "v0.01",
      );

  /// method to store data in secure storage
  Future<void> writeSecureData(RandomColorModel rcm) async {
    await _secureStorage.write(
      key: 'language',
      value: rcm.lastLocale.languageCode,
      aOptions: _getAndroidOptions(),
    );

    await _secureStorage.write(
      key: 'color',
      value: "${rcm.lastColor.value}",
      aOptions: _getAndroidOptions(),
    );

    await _secureStorage.write(
      key: 'textColor',
      value: "${rcm.lastTextColor.value}",
      aOptions: _getAndroidOptions(),
    );
  }

  /// retrieve data from secure storage
  Future<String?> readSecureData(String key) async {
    final String? readData =
        await _secureStorage.read(key: key, aOptions: _getAndroidOptions());

    return readData;
  }
}
