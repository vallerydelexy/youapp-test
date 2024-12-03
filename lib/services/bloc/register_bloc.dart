import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test/utils/enum.dart';
import '../api/auth_api.dart';

// Events
abstract class RegisterEvent {}

class EmailChangedEvent extends RegisterEvent {
  EmailChangedEvent(this.email);

  final String email;
}

class PasswordChangedEvent extends RegisterEvent {
  PasswordChangedEvent(this.password);

  final String password;
}

class PasswordConfirmChangedEvent extends RegisterEvent {
  PasswordConfirmChangedEvent(this.passwordConfirm);

  final String passwordConfirm;
}

class TogglePasswordVisibilityEvent extends RegisterEvent {}

class TogglePasswordConfirmVisibilityEvent extends RegisterEvent {}

class SubmitRegisterEvent extends RegisterEvent {}

class RegisterState {
  RegisterState(
      {this.email = '',
      this.passwordConfirm = '',
      this.isPasswordConfirmVisible = false,
      this.password = '',
      this.isPasswordVisible = false,
      this.status = ProcessStatus.initial,
      this.errorMessage});

  final String email;
  final String? errorMessage;
  final bool isPasswordConfirmVisible;
  final bool isPasswordVisible;
  final String password;
  final String passwordConfirm;
  final ProcessStatus status;

  String get emailValue => email;

  ProcessStatus get registerStatus => status;

  bool get isPasswordMatch {
  return password == passwordConfirm;
}

  bool get isLoading => status == ProcessStatus.loading;

  bool get isSuccess => status == ProcessStatus.success;

  bool get isFailure => status == ProcessStatus.failure;

  bool get isInitial => status == ProcessStatus.initial;

  bool get isFormValid => email.isNotEmpty && password.isNotEmpty && passwordConfirm.isNotEmpty && isPasswordMatch; 

  RegisterState copyWith({String? email, String? password, String? passwordConfirm, bool? isPasswordVisible, bool? isPasswordConfirmVisible, ProcessStatus? status, String? errorMessage}) =>
      RegisterState(
          email: email ?? this.email,
          password: password ?? this.password,
          passwordConfirm: passwordConfirm ?? this.passwordConfirm,
          isPasswordVisible: isPasswordVisible ?? this.isPasswordVisible,
          isPasswordConfirmVisible: isPasswordConfirmVisible ?? this.isPasswordConfirmVisible,
          status: status ?? this.status,
          errorMessage: errorMessage ?? this.errorMessage);
}

// Bloc
class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterBloc(this._authApi) : super(RegisterState()) {
    on<EmailChangedEvent>((event, emit) {
      emit(state.copyWith(email: event.email));
    });

    on<PasswordChangedEvent>((event, emit) {
      emit(state.copyWith(password: event.password));
    });

    on<PasswordConfirmChangedEvent>((event, emit) {
      emit(state.copyWith(passwordConfirm: event.passwordConfirm));
    });

    on<TogglePasswordVisibilityEvent>((event, emit) {
      emit(state.copyWith(isPasswordVisible: !state.isPasswordVisible));
    });

    on<TogglePasswordConfirmVisibilityEvent>((event, emit) {
      emit(state.copyWith(isPasswordConfirmVisible: !state.isPasswordConfirmVisible));
    });

    on<SubmitRegisterEvent>((event, emit) async {
      if (state.email.isEmpty || state.password.isEmpty) {
        emit(state.copyWith(status: ProcessStatus.failure, errorMessage: 'Email and password cannot be empty'));
        return;
      }

      emit(state.copyWith(status: ProcessStatus.loading));

      final registerResult = await _authApi.register({'email': state.email, 'username': state.email, 'password': state.password});

      registerResult.fold(
        (error) => emit(state.copyWith(status: ProcessStatus.failure, errorMessage: error.message)),
          (response) => emit(state.copyWith(status: ProcessStatus.success)));
    });
  }

  final AuthApi _authApi;
}
