import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class StorageService {
  final FlutterSecureStorage secureStorage = const FlutterSecureStorage(
    aOptions: AndroidOptions(encryptedSharedPreferences: true),
  );

  // Read value
  Future<String?> getValue(String key) async => secureStorage.read(key: key);

  // Save value
  Future<void> saveVal(String key, String val) async {
    await secureStorage.write(key: key, value: val);
  }
}
