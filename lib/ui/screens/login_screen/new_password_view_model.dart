import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../states/auth_state.dart';

final newPasswordViewModelProvider =
    ChangeNotifierProvider.autoDispose<NewPasswordViewModel>((ref) {
  final authState = ref.read(authStateProvider.notifier);
  return NewPasswordViewModel(authState);
});

class NewPasswordViewModel extends ChangeNotifier {
  final AuthState authState;
  String? newPasswordErrorMessage;
  String? confirmNewPasswordErrorMessage;

  NewPasswordViewModel(this.authState);

  Future<List<Map<String, String>>?> changePassword(
      String resetToken, String newPassword, String confirmNewPassword) async {
    // Reset the error messages to null
    newPasswordErrorMessage = null;
    confirmNewPasswordErrorMessage = null;

    final List<Map<String, String>>? errors = await authState
        .resetPasswordNewPassword(resetToken, newPassword, confirmNewPassword);

    // Iterate through the list of errors and assign the messages to the corresponding variables
    if (errors != null) {
      for (final error in errors) {
        if (error['field'] == 'password') {
          newPasswordErrorMessage = error['message'];
        }
      }
    }

    // Notify listeners to update the UI
    notifyListeners();

    return errors;
  }
}
