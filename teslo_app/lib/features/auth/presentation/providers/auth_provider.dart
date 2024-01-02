import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:teslo_shop/features/auth/domain/domain.dart';
import 'package:teslo_shop/features/auth/infrastructure/infrastructure.dart';
import 'package:teslo_shop/features/shared/shared.dart';

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  final authRepository = AuthRepositoryImpl();
  final keyValueStorageService = KeyValueStorageServiceImpl();
  return AuthNotifier(
      authRepository: authRepository,
      keyValueStorageService: keyValueStorageService);
});

class AuthNotifier extends StateNotifier<AuthState> {
  final AuthRepository authRepository;
  final KeyValueStorageService keyValueStorageService;
  AuthNotifier(
      {required this.authRepository, required this.keyValueStorageService})
      : super(AuthState());

  Future<void> loginUser(String email, String password) async {
    await Future.delayed(const Duration(milliseconds: 500));
    try {
      final user = await authRepository.login(email, password);
      _setLoggedUser(user);
    } on CustomError catch (e) {
      logout(e.message);
    } catch (e) {
      logout('Error no controlado');
    }
  }

  void registerUser(String email, String password) async {}

  void checkAuthStatus() async {
    final token = await keyValueStorageService.getValueKey<String>('token');
    if (token == null) return logout();

    try {
      final user = await authRepository.checkAuthStatus(token);
      _setLoggedUser(user);
    } catch (e) {
      logout();
    }
  }

  void _setLoggedUser(User user) async {
    await keyValueStorageService.setValueKey("token", user.token);
    state = state.copyWith(
      user: user,
      authStatus: AuthStatus.auth,
      errorMsg: "",
    );
  }

  Future<void> logout([String? errorMsg]) async {
    await keyValueStorageService.removeKey("token");

    state = state.copyWith(
        authStatus: AuthStatus.noAuth, user: null, errorMsg: errorMsg);
  }
}

enum AuthStatus { auth, noAuth, checking }

class AuthState {
  final AuthStatus authStatus;
  final User? user;
  final String errorMsg;

  AuthState(
      {this.authStatus = AuthStatus.checking, this.user, this.errorMsg = ""});

  AuthState copyWith({AuthStatus? authStatus, User? user, String? errorMsg}) =>
      AuthState(
          authStatus: authStatus ?? this.authStatus,
          user: user ?? this.user,
          errorMsg: errorMsg ?? this.errorMsg);
}
