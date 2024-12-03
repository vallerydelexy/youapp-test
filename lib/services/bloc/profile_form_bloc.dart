import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:test/models/user_model.dart';
import 'package:test/services/api/user_api.dart';
import 'package:test/services/bloc/user_bloc.dart';
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
      UserModel? localUserProfile = await getLocalUserProfile();
      if (validateForm(localUserProfile)) {
        emit(state.copyWith(status: FormStatus.submitting));

        try {
          final result = await _userApi.updateProfile({
            'name': state.displayName == '' ? localUserProfile?.name : state.displayName,
            'gender': state.gender == '' ? (localUserProfile?.gender ?? "Male") : state.gender,
            'birthday': state.birthday == null ? localUserProfile?.birthday : state.birthday!.toIso8601String(),
            'height': state.height == 0 ? localUserProfile?.height : state.height,
            'weight': state.weight == 0 ? localUserProfile?.weight : state.weight,
            'interests': state.interest.isEmpty ? localUserProfile?.interests : state.interest
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
        debugPrint(
            'Please fill all required fields ${state.displayName} ${state.gender} ${state.birthday} ${state.height} ${state.weight}');
        emit(state.copyWith(
          status: FormStatus.failure,
          errorMessage: 'Please fill all required fields',
        ));
      }
    });
  }

  bool validateForm(UserModel? localUserProfile) {
    debugPrint('name: ${state.displayName} & ${localUserProfile?.name}');
    debugPrint('gender: ${state.gender} & ${localUserProfile?.gender}');
    debugPrint('birthday: ${state.birthday} & ${localUserProfile?.birthday}');
    debugPrint('height: ${state.height} & ${localUserProfile?.height}');
    debugPrint('weight: ${state.weight} & ${localUserProfile?.weight}');
    debugPrint('interest: ${state.interest} & ${localUserProfile?.interests}');

    return (state.displayName.isNotEmpty || localUserProfile?.name != null) &&
        // (state.gender.isNotEmpty || localUserProfile?.gender != null) &&
        (state.birthday != null || localUserProfile?.birthday != null) &&
        (state.height > 0 || localUserProfile?.height != null) &&
        (state.weight > 0 || localUserProfile?.weight != null);
  }

  Future<UserModel?> getLocalUserProfile() async {
    Map<String, dynamic> sharedPreferencesProfile = await Preferences.getProfile();
    if (sharedPreferencesProfile.isNotEmpty) {
      final fromSharedPreferences = UserModel.fromJson(sharedPreferencesProfile);
      return fromSharedPreferences;
    } else {
      return null;
    }
  }

  final UserApi _userApi;
}
