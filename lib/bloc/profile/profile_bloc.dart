import 'package:app_convention/entities/profile.dart';
import 'package:app_convention/models/profile_model.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(ProfileInitial()) {
    on<LoadProfileRequested>(_onLoadProfileRequested);
  }

  Future<void> _onLoadProfileRequested(
    LoadProfileRequested event,
    Emitter<ProfileState> emit,
  ) async {
    emit(ProfileLoading());
    try {
      final profile = await ProfileModel.fetchCurrentUserProfile();
      if (profile != null) {
        emit(ProfileLoaded(profile));
      } else {
        emit(const ProfileError("No se pudo cargar el perfil"));
      }
    } catch (e) {
      emit(ProfileError(e.toString()));
    }
  }
}
