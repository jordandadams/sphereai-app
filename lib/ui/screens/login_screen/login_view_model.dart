import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../states/auth_state.dart';

final loginViewModelProvider =
    ChangeNotifierProvider.autoDispose<LoginViewModel>((ref) {
  final authState = ref.read(authStateProvider.notifier);
  return LoginViewModel(authState);
});

class LoginViewModel extends ChangeNotifier {
  final AuthState authState;
  String? emailErrorMessage;
  String? passwordErrorMessage;

  LoginViewModel(this.authState);

  Future<Map<String, dynamic>> login(String email, String password) async {
    // Reset the error messages to null
    emailErrorMessage = null;
    passwordErrorMessage = null;

    // Get the response from the authState.login method
    final Map<String, dynamic> response =
        await authState.login(email, password);

    // Check if the response contains 'errors'
    if (response.containsKey('errors')) {
      // Get the list of errors
      final List<Map<String, String>> errors =
          response['errors'] as List<Map<String, String>>;

      // Iterate through the list of errors and assign the messages to the corresponding variables
      for (final error in errors) {
        if (error['field'] == 'email') {
          emailErrorMessage = error['message'];
        } else if (error['field'] == 'password') {
          passwordErrorMessage = error['message'];
        }
      }
    }

    // Notify listeners to update the UI
    notifyListeners();

    return response;
  }
}
