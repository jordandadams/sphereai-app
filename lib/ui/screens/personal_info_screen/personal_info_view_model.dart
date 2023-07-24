import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final personalInfoViewModelProvider = ChangeNotifierProvider<PersonalInfoViewModel>((ref) {
  return PersonalInfoViewModel();
});

class PersonalInfoViewModel extends ChangeNotifier {
  void onStartChat() {
    print('Start Chat button tapped!');
  }
}
