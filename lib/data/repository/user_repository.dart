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

  Future<List<Map<String, String>>?> login(
      String email, String password) async {
    final Uri url = Uri.parse('http://localhost:3000/api/auth/login');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'password': password}),
    );
    final Map<String, dynamic> responseBody =
        jsonDecode(response.body) as Map<String, dynamic>;

    // Check if the response contains 'errors' key
    if (responseBody.containsKey('errors')) {
      // Extract and return the errors from the response
      return (responseBody['errors'] as List<dynamic>?)?.map((dynamic e) {
        return {
          'field': e['field'] as String,
          'message': e['message'] as String,
        };
      }).toList();
    } else {
      // No errors found
      return null;
    }
  }

  Future<Map<String, dynamic>> requestPasswordReset(String email) async {
    final Uri url =
        Uri.parse('http://localhost:3000/api/auth/request-password-reset');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email}),
    );
    if (response.statusCode == 200) {
      return {'success': true};
    } else {
      final responseBody = jsonDecode(response.body);
      return {'success': false, 'error': responseBody['error']};
    }
  }

  Future<Map<String, dynamic>> resetPasswordVerifyOTP(
      String email, String twoFAToken) async {
    final Uri url =
        Uri.parse('http://localhost:3000/api/auth/verify-reset-otp');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'otp': twoFAToken}),
    );
    final responseBody = jsonDecode(response.body);
    if (response.statusCode == 200) {
      return {'success': true, 'resetToken': responseBody['resetToken']};
    } else {
      return {'success': false, 'error': responseBody['error']};
    }
  }

  Future<List<Map<String, String>>?> resetPasswordNewPassword(
      String email, String newPassword, String confirmNewPassword) async {
    final Uri url = Uri.parse('http://localhost:3000/api/auth/reset-password');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'resetToken': email, 'newPassword': newPassword, "confirmNewPassword": confirmNewPassword}),
    );
    final Map<String, dynamic> responseBody =
        jsonDecode(response.body) as Map<String, dynamic>;

    // Check if the response contains 'error' key
    if (responseBody.containsKey('error')) {
      return [{'field': 'password', 'message': responseBody['error'] as String}];
    }
    // Check if the response contains 'errors' key
    else if (responseBody.containsKey('errors')) {
      // Extract and return the errors from the response
      return (responseBody['errors'] as List<dynamic>?)?.map((dynamic e) {
        return {
          'field': e['field'] as String,
          'message': e['message'] as String,
        };
      }).toList();
    } else {
      // No errors found
      return null;
    }
  }
}
