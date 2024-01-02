import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:formz/formz.dart';
import 'package:teslo_shop/features/shared/infrastructure/inputs/name.dart';
import 'package:teslo_shop/features/shared/shared.dart';
import 'package:log_print/log_print.dart';

class RegisterFormState {
  final bool isPosting;
  final bool isFormPosted;
  final bool isValid;
  final Name name;
  final Email email;
  final Password password;
  final Password repitePassword;

  RegisterFormState({
    this.isPosting = false,
    this.isFormPosted = false,
    this.isValid = false,
    this.name = const Name.pure(),
    this.email = const Email.pure(),
    this.password = const Password.pure(),
    this.repitePassword = const Password.pure(),
  });

  @override
  String toString() {
    // TODO: implement toString
    return """
    isPosting: $isPosting,
    isFormPosted: $isFormPosted,
    isValid: $isValid,
    name: $name,
    email: $email,
    password: $password,
    repitePassword: $repitePassword,
    """;
  }

  RegisterFormState copyWith(
      {bool? isPosting,
      bool? isFormPosted,
      bool? isValid,
      Name? name,
      Email? email,
      Password? password,
      Password? repitePassword}) {
    return RegisterFormState(
      isPosting: isPosting ?? this.isPosting,
      isFormPosted: isFormPosted ?? this.isFormPosted,
      isValid: isValid ?? this.isValid,
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      repitePassword: repitePassword ?? this.repitePassword,
    );
  }
}

class RegisterFormNotifier extends StateNotifier<RegisterFormState> {
  RegisterFormNotifier() : super(RegisterFormState());

  onNameChange(String value) {
    final newName = Name.dirty(value);
    state = state.copyWith(
        name: newName,
        isValid: Formz.validate(
            [newName, state.email, state.password, state.repitePassword]));
  }

  onEmailChange(String value) {
    final newEmail = Email.dirty(value);
    state = state.copyWith(
        email: newEmail,
        isValid: Formz.validate(
            [newEmail, state.name, state.password, state.repitePassword]));
  }

  onPasswordChange(String value) {
    final newPassword = Password.dirty(value);
    state = state.copyWith(
        password: newPassword,
        isValid: Formz.validate(
            [newPassword, state.name, state.email, state.repitePassword]));
  }

  onRepitePasswordChange(String value) {
    final repitePassword = Password.dirty(value);
    state = state.copyWith(
        repitePassword: repitePassword,
        isValid: Formz.validate(
            [repitePassword, state.name, state.email, state.password]));
  }

  onFormSubmit() {
    _touchEveryField();
    LogPrint("form $state", type: LogPrintType.info);
    if (!state.isValid) return;
    if (state.password != state.repitePassword) return;
    LogPrint("Siuuu $state", type: LogPrintType.success);
  }

  _touchEveryField() {
    final name = Name.dirty(state.name.value);
    final email = Email.dirty(state.email.value);
    final password = Password.dirty(state.password.value);
    final repitePassword = Password.dirty(state.repitePassword.value);
    state = state.copyWith(
        isFormPosted: true,
        name: name,
        email: email,
        password: password,
        repitePassword: repitePassword,
        isValid: Formz.validate([name, email, password, repitePassword]));
  }
}

final registerFormProvider =
    StateNotifierProvider.autoDispose<RegisterFormNotifier, RegisterFormState>(
        (ref) {
  return RegisterFormNotifier();
});
