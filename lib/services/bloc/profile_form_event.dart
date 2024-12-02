part of 'profile_form_bloc.dart';

abstract class ProfileFormEvent extends Equatable {
  const ProfileFormEvent();

  @override
  List<Object> get props => [];
}

class UpdateDisplayName extends ProfileFormEvent {
  final String displayName;

  const UpdateDisplayName(this.displayName);

  @override
  List<Object> get props => [displayName];
}

class UpdateGender extends ProfileFormEvent {
  final String gender;

  const UpdateGender(this.gender);

  @override
  List<Object> get props => [gender];
}

class UpdateBirthday extends ProfileFormEvent {
  final DateTime birthday;

  const UpdateBirthday(this.birthday);

  @override
  List<Object> get props => [birthday];
}

class UpdateHeight extends ProfileFormEvent {
  final double height;

  const UpdateHeight(this.height);

  @override
  List<Object> get props => [height];
}

class UpdateWeight extends ProfileFormEvent {
  final double weight;

  const UpdateWeight(this.weight);

  @override
  List<Object> get props => [weight];
}

class UpdateInterest extends ProfileFormEvent {
  final List<String> interest;

  const UpdateInterest(this.interest);

  @override
  List<Object> get props => [interest];
}

class UpdateImage extends ProfileFormEvent {
  final String image;

  const UpdateImage(this.image);

  @override
  List<Object> get props => [image];
}

class SubmitForm extends ProfileFormEvent {}
class ResetForm extends ProfileFormEvent {}
class UpdateFormStatus extends ProfileFormEvent {
  final FormStatus status;

  const UpdateFormStatus(this.status);

  @override
  List<Object> get props => [status];
}