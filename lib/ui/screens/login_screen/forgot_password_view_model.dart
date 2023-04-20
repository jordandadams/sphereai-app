import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final forgotPasswordViewModelProvider = ChangeNotifierProvider<ForgotPasswordViewModel>((ref) {
  return ForgotPasswordViewModel();
});

class ForgotPasswordViewModel extends ChangeNotifier {
  void onStartChat() {
    print('Start Chat button tapped!');
  }
}
