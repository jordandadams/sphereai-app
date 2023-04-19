import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final accountViewModelProvider = ChangeNotifierProvider<AccountViewModel>((ref) {
  return AccountViewModel();
});

class AccountViewModel extends ChangeNotifier {
  void onArrowTap() {
    print('Arrow button tapped!');
  }
}
