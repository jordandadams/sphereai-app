import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final historyViewModelProvider = ChangeNotifierProvider<HistoryViewModel>((ref) {
  return HistoryViewModel();
});

class HistoryViewModel extends ChangeNotifier {
  void onStartChat() {
    print('Start Chat button tapped!');
  }
}
