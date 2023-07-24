import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

import '../models/user_profile.dart';

// Create an instance of Logger
final logger = Logger();

class UserRepository {
  Future<List<Map<String, String>>?> register(
      String email, String password) async {
    final Uri url = Uri.parse('http://localhost:3000/api/auth/register');

    // Log the API request
    logger.i('Register API Request: $url');

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'password': password}),
    );
    // Log the API response
    logger.i('Register API Response: ${response.body}');

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

    // Log the API request
    logger.i('Verify API Request: $url');

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'twoFAToken': twoFAToken}),
    );
    // Log the API response
    logger.i('Verify API Response: ${response.body}');

    if (response.statusCode == 200) {
      return {'success': true};
    } else {
      // Extract and return the error message from the response
      final responseBody = jsonDecode(response.body);
      return {'success': false, 'error': responseBody['error']};
    }
  }

  Future<Map<String, dynamic>> login(String email, String password) async {
    final Uri url = Uri.parse('http://localhost:3000/api/auth/login');

    // Log the API request
    logger.i('Login API Request: $url');

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'password': password}),
    );
    // Log the API response
    logger.i('Login API Response: ${response.body}');

    final Map<String, dynamic> responseBody =
        jsonDecode(response.body) as Map<String, dynamic>;

    // Check if the response contains 'errors' key
    if (responseBody.containsKey('errors')) {
      // Extract and return the errors from the response
      final errors =
          (responseBody['errors'] as List<dynamic>?)?.map((dynamic e) {
        return {
          'field': e['field'] as String,
          'message': e['message'] as String,
        };
      }).toList();

      return {'errors': errors};
    } else {
      // No errors found
      // Extract and return the token and id from the response
      final String token = responseBody['token'] as String;
      final String id = responseBody['id'] as String;
      return {'token': token, 'id': id};
    }
  }

  Future<void> logout(String token) async {
    final Uri url = Uri.parse('http://localhost:3000/api/auth/logout');

    // Log the API request
    logger.i('Logout API Request: $url');

    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode({'token': token}),
    );

    // Log the API response
    logger.i('Logout API Response: ${response.body}');

    // Optional: Handle any specific responses if necessary
  }

  Future<UserProfile> getUserProfile(String id, String token) async {
    final Uri url = Uri.parse('http://localhost:3000/api/auth/user');

    // Log the API request
    logger.i('GetUserProfile API Request: $url');

    final response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
        '_id': id,
      },
    );
    // Log the API response
    logger.i('GetUserProfile API Response: ${response.body}');

    final Map<String, dynamic> responseBody =
        jsonDecode(response.body) as Map<String, dynamic>;
    return UserProfile.fromJson(responseBody);
  }

  Future<Map<String, dynamic>> requestPasswordReset(String email) async {
    final Uri url =
        Uri.parse('http://localhost:3000/api/auth/request-password-reset');

    // Log the API request
    logger.i('RequestPasswordReset API Request: $url');

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email}),
    );
    // Log the API response
    logger.i('RequestPasswordReset API Response: ${response.body}');

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

    // Log the API request
    logger.i('ResetPasswordVerifyOTP API Request: $url');

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email, 'otp': twoFAToken}),
    );
    // Log the API response
    logger.i('ResetPasswordVerifyOTP API Response: ${response.body}');

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

    // Log the API request
    logger.i('ResetPasswordNewPassword API Request: $url');

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'resetToken': email,
        'newPassword': newPassword,
        "confirmNewPassword": confirmNewPassword
      }),
    );
    // Log the API response
    logger.i('ResetPasswordNewPassword API Response: ${response.body}');

    final Map<String, dynamic> responseBody =
        jsonDecode(response.body) as Map<String, dynamic>;

    // Check if the response contains 'error' key
    if (responseBody.containsKey('error')) {
      return [
        {'field': 'password', 'message': responseBody['error'] as String}
      ];
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
