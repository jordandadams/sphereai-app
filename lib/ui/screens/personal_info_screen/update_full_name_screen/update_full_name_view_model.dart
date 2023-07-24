import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final updateFullNameViewModelProvider = ChangeNotifierProvider<UpdateFullNameViewModel>((ref) {
  return UpdateFullNameViewModel();
});

class UpdateFullNameViewModel extends ChangeNotifier {
  void onStartChat() {
    print('Start Chat button tapped!');
  }
}
