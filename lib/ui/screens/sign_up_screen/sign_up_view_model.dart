import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../states/auth_state.dart';

final signUpViewModelProvider =
    ChangeNotifierProvider.autoDispose<SignUpViewModel>((ref) {
  final authState = ref.read(authStateProvider.notifier);
  return SignUpViewModel(authState);
});

class SignUpViewModel extends ChangeNotifier {
  final AuthState authState;

  SignUpViewModel(this.authState);

  Future<List<Map<String, String>>?> registerAccount(
      String email, String password) async {
    // Handle the list of error messages from AuthState
    return authState.register(email, password);
  }

  // Extract the email error message from the errors list
  String? extractEmailErrorMessage(List<Map<String, String>>? errors) {
    return errors?.firstWhere(
        (e) => e['field'] == 'email',
        orElse: () => {'field': '', 'message': ''})['message'];
  }

  // Extract the password error message from the errors list
  String? extractPasswordErrorMessage(List<Map<String, String>>? errors) {
    return errors?.firstWhere(
        (e) => e['field'] == 'password',
        orElse: () => {'field': '', 'message': ''})['message'];
  }
}
