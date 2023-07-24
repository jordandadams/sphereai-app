import 'package:flutter_production_boilerplate_riverpod/states/user_profile_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/repository/user_repository.dart';

final userRepositoryProvider = Provider<UserRepository>((ref) {
  return UserRepository();
});

final authStateProvider = StateNotifierProvider<AuthState, bool>((ref) {
  final userRepository = ref.read(userRepositoryProvider);
  final userProfileState = ref.read(userProfileStateProvider.notifier);
  return AuthState(userRepository, userProfileState);
});

class AuthState extends StateNotifier<bool> {
  final UserRepository userRepository;
  final UserProfileState userProfileState;

  AuthState(this.userRepository, this.userProfileState) : super(false);

  Future<List<Map<String, String>>?> register(
      String email, String password) async {
    // Handle the list of error messages from UserRepository
    final List<Map<String, String>>? errors =
        await userRepository.register(email, password);
    state = errors == null;
    return errors;
  }

  Future<Map<String, dynamic>> verify(String email, String twoFAToken) async {
    return await userRepository.verify(email, twoFAToken);
  }

  Future<Map<String, dynamic>> login(String email, String password) async {
    final Map<String, dynamic> response =
        await userRepository.login(email, password);
    state = response.containsKey('errors');
    if (!state) {
      // state is false when there are no errors
      // Get the user profile information after a successful login
      final String id = response['id'] as String;
      final String token = response['token'] as String;
      final userProfile = await userRepository.getUserProfile(id, token);
      userProfileState
          .updateUserProfile(userProfile);
    }

    return response;
  }

  Future<Map<String, dynamic>> requestPasswordReset(String email) async {
    return await userRepository.requestPasswordReset(email);
  }

  Future<Map<String, dynamic>> resetPasswordVerifyOTP(
      String email, String twoFAToken) async {
    return await userRepository.resetPasswordVerifyOTP(email, twoFAToken);
  }

  Future<List<Map<String, String>>?> resetPasswordNewPassword(
      String email, String newPassword, String confirmNewPassword) async {
    final List<Map<String, String>>? errors = await userRepository
        .resetPasswordNewPassword(email, newPassword, confirmNewPassword);
    state = errors == null;
    return errors;
  }
}
