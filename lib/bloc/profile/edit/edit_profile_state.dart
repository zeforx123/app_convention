part of 'edit_profile_bloc.dart';

abstract class EditProfileState extends Equatable {
  @override
  List<Object?> get props => [];
}

class EditProfileInitial extends EditProfileState {}

class EditProfileLoading extends EditProfileState {}

class EditProfileLoaded extends EditProfileState {
  final EditProfileModel user;
  EditProfileLoaded(this.user);

  @override
  List<Object?> get props => [user];
}

class ProfileUpdating extends EditProfileState {}

class ProfileUpdated extends EditProfileState {}

class EditProfileError extends EditProfileState {
  final String message;
  EditProfileError(this.message);

  @override
  List<Object?> get props => [message];
}
