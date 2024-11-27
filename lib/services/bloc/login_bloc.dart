import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test/utils/enum.dart';
import '../api/auth_api.dart';

// Events
abstract class LoginEvent {}

class EmailChangedEvent extends LoginEvent {
  EmailChangedEvent(this.email);

  final String email;
}

class PasswordChangedEvent extends LoginEvent {
  PasswordChangedEvent(this.password);

  final String password;
}

class TogglePasswordVisibilityEvent extends LoginEvent {}

class SubmitLoginEvent extends LoginEvent {}

class LoginState {
  LoginState({this.email = '', this.password = '', this.isPasswordVisible = false, this.status = LoginStatus.initial, this.errorMessage});

  final String email;
  final String? errorMessage;
  final bool isPasswordVisible;
  final String password;
  final LoginStatus status;

  LoginStatus get loginStatus => status;
  bool get isLoading => status == LoginStatus.loading;
  bool get isSuccess => status == LoginStatus.success;
  bool get isFailure => status == LoginStatus.failure;

  LoginState copyWith({String? email, String? password, bool? isPasswordVisible, LoginStatus? status, String? errorMessage}) => LoginState(
      email: email ?? this.email,
      password: password ?? this.password,
      isPasswordVisible: isPasswordVisible ?? this.isPasswordVisible,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage);
}

// Bloc
class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc(this._authApi) : super(LoginState()) {
    on<EmailChangedEvent>((event, emit) {
      emit(state.copyWith(email: event.email));
    });

    on<PasswordChangedEvent>((event, emit) {
      emit(state.copyWith(password: event.password));
    });

    on<TogglePasswordVisibilityEvent>((event, emit) {
      emit(state.copyWith(isPasswordVisible: !state.isPasswordVisible));
    });

    on<SubmitLoginEvent>((event, emit) async {
      if (state.email.isEmpty || state.password.isEmpty) {
        emit(state.copyWith(status: LoginStatus.failure, errorMessage: 'Email and password cannot be empty'));
        return;
      }

      emit(state.copyWith(status: LoginStatus.loading));

      final result = await _authApi.login({'email': state.email, 'username': state.email, 'password': state.password});

      result.fold((error) => emit(state.copyWith(status: LoginStatus.failure, errorMessage: error.message)),
          (response) => emit(state.copyWith(status: LoginStatus.success)));
    });
  }

  final AuthApi _authApi;
}
