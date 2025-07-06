part of 'edit_profile_bloc.dart';

abstract class EditProfileEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadUserProfile extends EditProfileEvent {}

class UpdateUserProfile extends EditProfileEvent {
  final EditProfileModel user;

  UpdateUserProfile(this.user);

  @override
  List<Object?> get props => [user];
}
