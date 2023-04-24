import 'dart:convert';
import 'package:http/http.dart' as http;

class UserRepository {
  Future<bool> register(String email, String password) async {
    final Uri url = Uri.parse('http://localhost:3000/api/auth/register');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'password': password}),
    );
    return response.statusCode == 200;
  }

  Future<bool> verify(String email, String twoFAToken) async {
    final Uri url = Uri.parse('http://localhost:3000/api/auth/verify');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'twoFAToken': twoFAToken}),
    );
    return response.statusCode == 200;
  }
}