import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/use_cases/auth_use_case.dart';
import 'auth_state.dart';
import '../../inject_auth.dart';

final authProvider = StateNotifierProvider<AuthProvider, AuthState>((ref) {
  return AuthProvider(authUseCase: ref.read(authUseCaseProvider));
});

class AuthProvider extends StateNotifier<AuthState> {

  final AuthUseCase authUseCase;
  AuthProvider({required this.authUseCase}) : super(AuthInitial()) {
    init();
  }

  void init() async {
    // Initialize provider
  }
}
      