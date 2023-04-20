import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final completeProfileViewModelProvider = ChangeNotifierProvider<CompleteProfileViewModel>((ref) {
  return CompleteProfileViewModel();
});

class CompleteProfileViewModel extends ChangeNotifier {
  void onStartChat() {
    print('Start Chat button tapped!');
  }
}
