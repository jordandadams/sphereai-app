import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final otpViewModelProvider = ChangeNotifierProvider<OTPViewModel>((ref) {
  return OTPViewModel();
});

class OTPViewModel extends ChangeNotifier {
  void onStartChat() {
    print('Start Chat button tapped!');
  }
}
