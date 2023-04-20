import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final newPasswordViewModelProvider = ChangeNotifierProvider<NewPasswordViewModel>((ref) {
  return NewPasswordViewModel();
});

class NewPasswordViewModel extends ChangeNotifier {
  void onStartChat() {
    print('Start Chat button tapped!');
  }
}
