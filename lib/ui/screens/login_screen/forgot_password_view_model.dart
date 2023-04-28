import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../states/auth_state.dart';

final forgotPasswordViewModelProvider =
    ChangeNotifierProvider.autoDispose<ForgotPasswordViewModel>((ref) {
  final authState = ref.read(authStateProvider.notifier);
  return ForgotPasswordViewModel(authState);
});

class ForgotPasswordViewModel extends ChangeNotifier {
  final AuthState authState;
  String twoFACode = '';
  DateTime? lastOTPSentTime;
  static const int otpSendIntervalSeconds = 120;
  String? resetPasswordErrorMessage;

  ForgotPasswordViewModel(this.authState);

  Future<bool> sendResetCode(String email) async {
    final result = await authState.requestPasswordReset(email);
    if (result['success'] as bool) {
      resetPasswordErrorMessage = null;
      return true; // Indicate success
    } else {
      resetPasswordErrorMessage = result['error'] as String?;
      notifyListeners();
      return false; // Indicate failure
    }
  }

  void setTwoFACode(String code) {
    twoFACode = code;
    notifyListeners();
  }

  // Getter method for verificationErrorMessage
  String? getResetPasswordErrorMessage() {
    return resetPasswordErrorMessage;
  }

  void setLastOTPSentTime(DateTime time) {
    lastOTPSentTime = time;
  }

  bool canResendOTP() {
    if (lastOTPSentTime == null) return true;
    int elapsedSeconds = DateTime.now().difference(lastOTPSentTime!).inSeconds;
    return elapsedSeconds >= otpSendIntervalSeconds;
  }

  Future<bool> resendOTP(String email, String password) async {
    try {
      await authState.register(email, password);
      setLastOTPSentTime(DateTime.now());
      return true;
    } catch (e) {
      return false;
    }
  }
}
