import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final aiAssistantViewModelProvider = ChangeNotifierProvider<AIAssistantViewModel>((ref) {
  return AIAssistantViewModel();
});

class AIAssistantViewModel extends ChangeNotifier {
  void onStartChat() {
    print('Start Chat button tapped!');
  }
}
