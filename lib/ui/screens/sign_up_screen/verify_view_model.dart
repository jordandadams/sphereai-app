import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../states/auth_state.dart';

final verifyViewModelProvider = ChangeNotifierProvider.autoDispose<VerifyViewModel>((ref) {
  final authState = ref.read(authStateProvider.notifier);
  return VerifyViewModel(authState);
});

class VerifyViewModel extends ChangeNotifier {
  final AuthState authState;
  String twoFACode = '';

  VerifyViewModel(this.authState);

  void setTwoFACode(String code) {
    twoFACode = code;
    notifyListeners();
  }

  Future<bool> verifyAccount(String email) async {
    try {
      await authState.verify(email, twoFACode);
      return true;
    } catch (e) {
      return false;
    }
  }
}
