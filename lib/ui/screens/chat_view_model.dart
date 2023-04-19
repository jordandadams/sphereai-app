import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final chatViewModelProvider = ChangeNotifierProvider<ChatViewModel>((ref) {
  return ChatViewModel();
});

class ChatViewModel extends ChangeNotifier {
  void onStartChat() {
    print('Start Chat button tapped!');
  }
}
