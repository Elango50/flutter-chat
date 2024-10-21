import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageService {
  static final _storage = FlutterSecureStorage();

  // Store the JWT token in secure storage
  static Future<void> storeJwtToken(String jwtToken) async {
    await _storage.write(key: 'jwt_token', value: jwtToken);
  }

  // Retrieve the JWT token from secure storage
  static Future<String?> getJwtToken() async {
    return await _storage.read(key: 'jwt_token');
  }

  // Delete the JWT token from secure storage
  static Future<void> deleteJwtToken() async {
    await _storage.delete(key: 'jwt_token');
  }

  // Clear the JWT token (same as deleteJwtToken)
  static Future<void> clearJwtToken() async {
    await deleteJwtToken(); // Optionally, you can have custom logic here
  }
}
