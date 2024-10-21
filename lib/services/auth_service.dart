import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../config.dart';
import 'secure_storage_service.dart';
import 'package:flutter/foundation.dart';

class AuthService extends ChangeNotifier {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  // Method to log in and get the Firebase token
  Future<void> loginUser(
      String email, String password, Function(String) onError) async {
    try {
      // Sign in with Firebase Authentication
      UserCredential userCredential =
          await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Get Firebase ID Token
      String? firebaseToken = await userCredential.user!.getIdToken();

      // Send Firebase Token to your backend and get the JWT
      String jwtToken = await _getJwtFromServer(firebaseToken!);

      if (jwtToken.isNotEmpty) {
        await SecureStorageService.storeJwtToken(
            jwtToken); // Store the JWT token
        notifyListeners();
      } else {
        onError('Failed to obtain JWT token'); // Call error callback
      }
    } on FirebaseAuthException catch (e) {
      onError(e.message ?? 'Login failed'); // Call error callback
    } catch (e) {
      onError('An unexpected error occurred'); // Call error callback
    }
  }

  // Method to send Firebase Token to .NET backend and get the JWT token
  Future<String> _getJwtFromServer(String firebaseToken) async {
    final response = await http.post(
      Uri.parse(AppConfig.backendUrl), // Use the externalized backend URL
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode({
        'firebaseToken': firebaseToken,
      }),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseBody = json.decode(response.body);
      return responseBody['token'] ?? ''; // JWT token
    } else {
      print('Server error: ${response.statusCode}');
      return '';
    }
  }
}
