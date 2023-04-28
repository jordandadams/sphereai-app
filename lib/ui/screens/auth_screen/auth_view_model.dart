import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authViewModelProvider = ChangeNotifierProvider<AuthViewModel>((ref) {
  return AuthViewModel();
});

class AuthViewModel extends ChangeNotifier {
  void onStartChat() {
    print('Start Chat button tapped!');
  }
}
