import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

final authStateProvider = StateNotifierProvider<AuthState, bool>((ref) {
  return AuthState();
});

class AuthState extends StateNotifier<bool> {
  AuthState() : super(false); // Initial state: not authenticated

  Future<void> register(String email, String password) async {
    final Uri url = Uri.parse('http://localhost:3000/api/auth/register');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'password': password}),
    );

    if (response.statusCode == 200) {
      // If the registration was successful, set the state to authenticated.
      state = true;
    } else {
      // If registration failed, set the state to not authenticated.
      state = false;
    }
  }

  Future<void> verify(String email, String twoFAToken) async {
    final Uri url = Uri.parse('http://localhost:3000/api/auth/verify');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'twoFAToken': twoFAToken}),
    );

    if (response.statusCode == 200) {
      state = true;
    } else {
      state = false;
    }
  }
}
