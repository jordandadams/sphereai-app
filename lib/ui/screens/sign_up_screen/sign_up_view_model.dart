import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../states/auth_state.dart';

final signUpViewModelProvider = ChangeNotifierProvider.autoDispose<SignUpViewModel>((ref) {
  final authState = ref.read(authStateProvider.notifier);
  return SignUpViewModel(authState);
});

class SignUpViewModel extends ChangeNotifier {
  final AuthState authState;

  SignUpViewModel(this.authState);

  Future<bool> registerAccount(String email, String password) async {
    try {
      await authState.register(email, password);
      return true;
    } catch (e) {
      return false;
    }
  }
}