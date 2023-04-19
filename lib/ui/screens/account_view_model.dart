import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final accountViewModelProvider = ChangeNotifierProvider<AccountViewModel>((ref) {
  return AccountViewModel();
});

class AccountViewModel extends ChangeNotifier {
  bool _isDarkMode = false; // Private variable to hold the value of the dark mode switch

  // Getter to get the value of _isDarkMode
  bool get isDarkMode => _isDarkMode;

  // Method to toggle the value of _isDarkMode
  void toggleDarkMode() {
    _isDarkMode = !_isDarkMode;
    print(_isDarkMode.toString());
    notifyListeners(); // Notify listeners about the change in value
  }

  void onArrowTap() {
    print('Arrow button tapped!');
  }
}