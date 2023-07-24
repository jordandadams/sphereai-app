import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/models/user_profile.dart';

final userProfileStateProvider = StateNotifierProvider<UserProfileState, UserProfile?>((ref) {
  return UserProfileState();
});

class UserProfileState extends StateNotifier<UserProfile?> {
  UserProfileState() : super(null);

  void updateUserProfile(UserProfile? profile) {
    state = profile;
  }
}
