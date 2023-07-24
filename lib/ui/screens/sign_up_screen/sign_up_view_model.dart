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
  bool _areTermsAccepted = false;
  String? termsErrorMessage;
  String twoFACode = '';
  DateTime? lastOTPSentTime;
  static const int otpSendIntervalSeconds = 120;
  String? verificationErrorMessage;

  SignUpViewModel(this.authState);

  bool get areTermsAccepted => _areTermsAccepted;

  Future<List<Map<String, String>>?> registerAccount(
      String email, String password) async {
    // Handle the list of error messages from AuthState
    return authState.register(email, password);
  }

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

  // Extract the email error message from the errors list
  String? extractEmailErrorMessage(List<Map<String, String>>? errors) {
    return errors?.firstWhere((e) => e['field'] == 'email',
        orElse: () => {'field': '', 'message': ''})['message'];
  }

  // Extract the password error message from the errors list
  String? extractPasswordErrorMessage(List<Map<String, String>>? errors) {
    return errors?.firstWhere((e) => e['field'] == 'password',
        orElse: () => {'field': '', 'message': ''})['message'];
  }

  // Toggle the terms acceptance status
  void toggleTermsAcceptance() {
    _areTermsAccepted = !_areTermsAccepted;
    // Clear the terms error message when the checkbox is checked
    if (_areTermsAccepted) {
      termsErrorMessage = null;
    }
    notifyListeners();
  }

  // Check if terms are accepted
  bool validateTermsAcceptance() {
    if (!_areTermsAccepted) {
      termsErrorMessage = 'You must accept the terms and conditions.';
      notifyListeners();
      return false;
    }
    return true;
  }

  void setTwoFACode(String code) {
    twoFACode = code;
    notifyListeners();
  }

  Future<void> verifyAccount(String email) async {
    final result = await authState.verify(email, twoFACode);
    if (result['success'] as bool) {
      verificationErrorMessage = null; // No error message on success
    } else {
      // Set the error message and cast result['error'] to String?
      verificationErrorMessage = result['error'] as String?;
      notifyListeners();
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
