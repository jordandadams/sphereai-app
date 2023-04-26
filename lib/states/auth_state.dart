import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/repository/user_repository.dart';

// Define the userRepositoryProvider
final userRepositoryProvider = Provider<UserRepository>((ref) {
  return UserRepository();
});

final authStateProvider = StateNotifierProvider<AuthState, bool>((ref) {
  final userRepository = ref.read(userRepositoryProvider);
  return AuthState(userRepository);
});

class AuthState extends StateNotifier<bool> {
  final UserRepository userRepository;

  AuthState(this.userRepository) : super(false);

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

  Future<List<Map<String, String>>?> login(
      String email, String password) async {
    final List<Map<String, String>>? errors =
        await userRepository.login(email, password);
    state = errors == null;
    return errors;
  }
}
