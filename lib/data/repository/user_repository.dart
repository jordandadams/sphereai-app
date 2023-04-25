import 'dart:convert';
import 'package:http/http.dart' as http;

class UserRepository {
  Future<List<Map<String, String>>?> register(
      String email, String password) async {
    final Uri url = Uri.parse('http://localhost:3000/api/auth/register');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'password': password}),
    );
    if (response.statusCode == 200) {
      return null;
    } else {
      final Map<String, dynamic> responseBody =
          jsonDecode(response.body) as Map<String, dynamic>;
      return (responseBody['errors'] as List<dynamic>?)?.map((dynamic e) {
        return {
          'field': e['field'] as String,
          'message': e['message'] as String,
        };
      }).toList();
    }
  }

  Future<Map<String, dynamic>> verify(String email, String twoFAToken) async {
    final Uri url = Uri.parse('http://localhost:3000/api/auth/verify');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'twoFAToken': twoFAToken}),
    );
    if (response.statusCode == 200) {
      return {'success': true};
    } else {
      // Extract and return the error message from the response
      final responseBody = jsonDecode(response.body);
      return {'success': false, 'error': responseBody['error']};
    }
  }
}
