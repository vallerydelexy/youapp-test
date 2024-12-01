import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
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
  LoginState({this.email = '', this.password = '', this.isPasswordVisible = false, this.status = ProcessStatus.initial, this.errorMessage});

  final String email;
  final String? errorMessage;
  final bool isPasswordVisible;
  final String password;
  final ProcessStatus status;

  String? validateEmail() {
    return FormBuilderValidators.compose([
      FormBuilderValidators.required(),
      FormBuilderValidators.email(),
    ])(email);
  }

  // Validate password
  String? validatePassword() {
    return FormBuilderValidators.compose([
      FormBuilderValidators.required(),
      FormBuilderValidators.minLength(8), // Example password length validation
    ])(password);
  }

  String get emailValue => email;
  ProcessStatus get loginStatus => status;
  bool get isLoading => status == ProcessStatus.loading;
  bool get isSuccess => status == ProcessStatus.success;
  bool get isFailure => status == ProcessStatus.failure;
  bool get hasInputError => [validateEmail(), validatePassword()].any((error) => error != null);

  LoginState copyWith({String? email, String? password, bool? isPasswordVisible, ProcessStatus? status, String? errorMessage}) =>
      LoginState(
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
      emit(state.copyWith(email: event.email, errorMessage: null, status: ProcessStatus.initial));
    });

    on<PasswordChangedEvent>((event, emit) {
      emit(state.copyWith(password: event.password, errorMessage: null, status: ProcessStatus.initial));
    });

    on<TogglePasswordVisibilityEvent>((event, emit) {
      emit(state.copyWith(isPasswordVisible: !state.isPasswordVisible, errorMessage: null, status: ProcessStatus.initial));
    });

    on<SubmitLoginEvent>((event, emit) async {
      if (state.email.isEmpty || state.password.isEmpty) {
        emit(state.copyWith(status: ProcessStatus.failure, errorMessage: 'Email and password cannot be empty'));
        return;
      }

      emit(state.copyWith(status: ProcessStatus.loading, errorMessage: null));

      final result = await _authApi.login({'email': state.email, 'username': state.email, 'password': state.password});

      result.fold(
        (error) => emit(
          state.copyWith(status: ProcessStatus.failure, errorMessage: error.message),
        ),
        (response) {
          debugPrint('login response ${response.message}');
          // final statusCode = response.statusCode;
          if(response.message != 'User has been logged in successfully') {
            emit(state.copyWith(status: ProcessStatus.failure, errorMessage: response.message));
          } else {
            emit(state.copyWith(status: ProcessStatus.success, errorMessage: null));
            // UserBloc(userApi: UserApi()).add(CheckingLoginStatus());
          }
        },
      );
    });
  }

  final AuthApi _authApi;
}
