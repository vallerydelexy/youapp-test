import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:test/services/api/user_api.dart';
import 'package:test/utils/preferences.dart';

part 'profile_form_event.dart';
part 'profile_form_state.dart';

class ProfileFormBloc extends Bloc<ProfileFormEvent, ProfileFormState> {
  ProfileFormBloc(this._userApi) : super(const ProfileFormState()) {

    on<UpdateImage>((event, emit) {
      emit(state.copyWith(image: event.image));
    });

    on<UpdateDisplayName>((event, emit) {
      emit(state.copyWith(displayName: event.displayName));
    });

    on<UpdateGender>((event, emit) {
      emit(state.copyWith(gender: event.gender));
    });

    on<UpdateBirthday>((event, emit) {
      emit(state.copyWith(birthday: event.birthday));
    });

    on<UpdateHeight>((event, emit) {
      emit(state.copyWith(height: event.height));
    });

    on<UpdateWeight>((event, emit) {
      emit(state.copyWith(weight: event.weight));
    });

    on<ResetForm>((event, emit) {
      emit(const ProfileFormState());
    });

    on<UpdateFormStatus>((event, emit) {
      emit(state.copyWith(status: event.status));
    });

    on<UpdateInterest>((event, emit) {
      emit(state.copyWith(interest: event.interest));
    });

    on<SubmitForm>((event, emit) async {
   
      if (_validateForm()) {
        emit(state.copyWith(status: FormStatus.submitting));

        try {
          final result = await _userApi.updateProfile({
            'name': state.displayName,
            'gender': state.gender,
            'birthday': state.birthday!.toIso8601String(),
            'height': state.height,
            'weight': state.weight,
            'interests': state.interest
          });
          result.fold(
            (error) => emit(state.copyWith(
              status: FormStatus.failure,
            )),
            (data) {
              Preferences.setProfile(data.data);
              emit(state.copyWith(
                status: FormStatus.success,
              ));

            },
          );
          
          emit(state.copyWith(status: FormStatus.success));
        } catch (e) {
          emit(state.copyWith(
            status: FormStatus.failure,
            errorMessage: e.toString(),
          ));
        }
      } else {
        debugPrint('Please fill all required fields ${state.displayName} ${state.gender} ${state.birthday} ${state.height} ${state.weight}');
        emit(state.copyWith(
          status: FormStatus.failure,
          errorMessage: 'Please fill all required fields',
        ));
      }
    });
  }

  bool _validateForm() {
    return state.displayName.isNotEmpty && state.gender.isNotEmpty && state.birthday != null && state.height > 0 && state.weight > 0;
  }

  final UserApi _userApi;
}
