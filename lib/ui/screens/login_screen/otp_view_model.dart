import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../states/auth_state.dart';

final otpViewModelProvider =
    ChangeNotifierProvider.autoDispose<OTPViewModel>((ref) {
  final authState = ref.read(authStateProvider.notifier);
  return OTPViewModel(authState);
});

class OTPViewModel extends ChangeNotifier {
  final AuthState authState;
  String? verificationErrorMessage;
  String twoFACode = '';
  DateTime? lastOTPSentTime;
  static const int otpSendIntervalSeconds = 120;
  String? resetPasswordErrorMessage;
  String? resetToken;

  OTPViewModel(this.authState);

  String obfuscateEmail(String email) {
    // Split the email into local part and domain
    List<String> parts = email.split('@');
    String localPart = parts[0];
    String domain = parts[1];
    // Get the first character of the local part
    String firstChar = localPart[0];
    // Replace the rest of the local part with asterisks
    String obfuscatedLocalPart = firstChar + '*' * (localPart.length - 1);
    // Get the domain extension
    String domainExtension = domain.split('.').last;
    // Replace the rest of the domain with asterisks
    String obfuscatedDomain =
        '*' * (domain.length - domainExtension.length - 1) +
            '.' +
            domainExtension;
    // Return the obfuscated email
    return obfuscatedLocalPart + '@' + obfuscatedDomain;
  }

  void setTwoFACode(String code) {
    twoFACode = code;
    notifyListeners();
  }

  Future<bool> verifyOTPCode(String email, String twoFACode) async {
    final Map<String, dynamic> result =
        await authState.resetPasswordVerifyOTP(email, twoFACode);
    resetToken = result['resetToken'] as String?;
    if (result['success'] as bool) {
      verificationErrorMessage = null;
      return true;
    } else {
      verificationErrorMessage = result['error'] as String?;
      notifyListeners();
      return false; // Indicate failure
    }
  }

  // Getter method for verificationErrorMessage
  String? getVerificationErrorMessage() {
    return verificationErrorMessage;
  }

  void setLastOTPSentTime(DateTime time) {
    lastOTPSentTime = time;
  }

  bool canResendOTP() {
    if (lastOTPSentTime == null) return true;
    int elapsedSeconds = DateTime.now().difference(lastOTPSentTime!).inSeconds;
    return elapsedSeconds >= otpSendIntervalSeconds;
  }

  Future<bool> resendOTP(String email) async {
    try {
      await authState.requestPasswordReset(email);
      setLastOTPSentTime(DateTime.now());
      return true;
    } catch (e) {
      return false;
    }
  }
}
