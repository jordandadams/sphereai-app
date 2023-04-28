import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../states/theme_mode_state.dart'; // Import the ThemeModeState file

final accountViewModelProvider = ChangeNotifierProvider<AccountViewModel>((ref) {
  return AccountViewModel(ref: ref);
});

class AccountViewModel extends ChangeNotifier {
  final ChangeNotifierProviderRef<AccountViewModel> ref; // Use ChangeNotifierProviderRef<AccountViewModel>
  AccountViewModel({required this.ref});

  void toggleDarkMode() {
    // Obtain the ThemeModeState from the themeProvider
    final themeState = ref.read(themeProvider);

    // Toggle the theme mode based on the current value
    if (themeState.themeMode == ThemeMode.dark) {
      themeState.setThemeMode(ThemeMode.light);
    } else {
      themeState.setThemeMode(ThemeMode.dark);
    }

    print(themeState.themeMode.toString());
    notifyListeners(); // Notify listeners about the change in value
  }

  void onArrowTap() {
    print('Arrow button tapped!');
  }
}