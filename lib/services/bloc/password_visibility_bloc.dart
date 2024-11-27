import 'package:flutter_bloc/flutter_bloc.dart';

// Event
abstract class PasswordVisibilityEvent {}
class TogglePasswordVisibilityEvent extends PasswordVisibilityEvent {}

// State
class PasswordVisibilityBlocState {
  PasswordVisibilityBlocState({this.isObscured = true});

  final bool isObscured;

  PasswordVisibilityBlocState copyWith({bool? isObscured}) {
    return PasswordVisibilityBlocState(
      isObscured: isObscured ?? this.isObscured
    );
  }
}

// Bloc
class PasswordVisibilityBloc extends Bloc<PasswordVisibilityEvent, PasswordVisibilityBlocState> {
  PasswordVisibilityBloc() : super(PasswordVisibilityBlocState()) {
    on<TogglePasswordVisibilityEvent>((event, emit) {
      emit(state.copyWith(isObscured: !state.isObscured));
    });
  }
}