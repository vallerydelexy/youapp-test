part of 'profile_form_bloc.dart';

enum FormStatus { initial, open, submitting, success, failure }


class ProfileFormState extends Equatable {
  final String displayName;
  final String gender;
  final DateTime? birthday;
  final double height;
  final double weight;
  final FormStatus status;
  final String? errorMessage;
  final List<String> interest;

  

  const ProfileFormState({
    this.displayName = '',
    this.gender = '',
    this.birthday,
    this.height = 0.0,
    this.weight = 0.0,
    this.status = FormStatus.initial,
    this.errorMessage,
    this.interest = const [],
  });

  ProfileFormState copyWith({
    String? displayName,
    String? gender,
    DateTime? birthday,
    double? height,
    double? weight,
    FormStatus? status,
    String? errorMessage,
    String? image,
    List<String>? interest
  }) {
    return ProfileFormState(
      displayName: displayName ?? this.displayName,
      gender: gender ?? this.gender,
      birthday: birthday ?? this.birthday,
      height: height ?? this.height,
      weight: weight ?? this.weight,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      interest: interest ?? this.interest
    );
  }

  @override
  List<Object?> get props => [
    displayName, 
    gender, 
    birthday, 
    height, 
    weight, 
    status, 
    errorMessage,
    interest
  ];
}