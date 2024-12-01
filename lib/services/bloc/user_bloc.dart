import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test/models/user_model.dart';
import 'package:test/services/api/user_api.dart';
import 'package:test/services/bloc/profile_form_bloc.dart';
import 'package:test/utils/enum.dart';
import 'package:test/utils/preferences.dart';

class UserProfileState {
  final ProcessStatus status;
  final UserModel? userProfile;
  final String? errorMessage;

  UserProfileState({
    this.status = ProcessStatus.initial,
    this.userProfile,
    this.errorMessage,
  });

  UserProfileState copyWith({
    ProcessStatus? status,
    UserModel? userProfile,
    String? errorMessage,
  }) {
    return UserProfileState(
      status: status ?? this.status,
      userProfile: userProfile ?? this.userProfile,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}

abstract class UserEvent {}

class GetUserProfileEvent extends UserEvent {}

class UpdateUserImage extends UserEvent {
  final String image;
  UpdateUserImage({required this.image});
}

class UpdateUserProfileEvent extends UserEvent {
  final Map<String, dynamic> updatedData;

  UpdateUserProfileEvent({required this.updatedData});
}

class CreateUserProfileEvent extends UserEvent {
  final Map<String, dynamic> profileData;

  CreateUserProfileEvent({required this.profileData});
}

class UserBloc extends Bloc<UserEvent, UserProfileState> {
  final UserApi userApi;

  UserBloc({required this.userApi}) : super(UserProfileState()) {
    on<UpdateUserImage>((event, emit) {
      Preferences.setProfile(state.userProfile!.copyWith(image: event.image).toJson());
      emit(state.copyWith(userProfile: state.userProfile?.copyWith(image: event.image)));
    });
    on<GetUserProfileEvent>(_onGetUserProfile);
    on<UpdateUserProfileEvent>(_onUpdateUserProfile);
    on<CreateUserProfileEvent>(_onCreateUserProfile);
  }

  Future<void> _onGetUserProfile(GetUserProfileEvent event, Emitter<UserProfileState> emit) async {
    emit(state.copyWith(status: ProcessStatus.loading));
    final result = await userApi.getProfile();
    Map<String, dynamic> sharedPreferencesProfile  = await Preferences.getProfile();

    if(sharedPreferencesProfile.isNotEmpty) {
      final fromSharedPreferences = UserModel.fromJson(sharedPreferencesProfile);
      state.copyWith(userProfile: fromSharedPreferences);
    }

    debugPrint('User Profile image: ${state.userProfile?.image}');
    final currentImage = state.userProfile?.image;

    result.fold((error) => emit(state.copyWith(status: ProcessStatus.failure, errorMessage: error.message)), (response) {
      final userProfile = UserModel.fromJson(response.data);
      final updatedUserProfile = userProfile.copyWith(
        image: userProfile.image ?? currentImage,
      );
      emit(state.copyWith(status: ProcessStatus.success, userProfile: updatedUserProfile,));
    });
  }

  Future<void> _onUpdateUserProfile(UpdateUserProfileEvent event, Emitter<UserProfileState> emit) async {
    emit(state.copyWith(status: ProcessStatus.loading));

    final result = await userApi.updateProfile(event.updatedData);

    result.fold((error) => emit(state.copyWith(status: ProcessStatus.failure, errorMessage: error.message)), (response) {
      final updatedProfile = UserModel.fromJson(response.data);
      emit(state.copyWith(status: ProcessStatus.success, userProfile: updatedProfile));
    });
  }

  Future<void> _onCreateUserProfile(CreateUserProfileEvent event, Emitter<UserProfileState> emit) async {
    emit(state.copyWith(status: ProcessStatus.loading));

    final result = await userApi.createProfile(event.profileData);

    result.fold((error) => emit(state.copyWith(status: ProcessStatus.failure, errorMessage: error.message)), (response) {
      final newProfile = UserModel.fromJson(response.data);
      emit(state.copyWith(status: ProcessStatus.success, userProfile: newProfile));
    });
  }
}
