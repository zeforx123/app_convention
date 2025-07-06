import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../models/edit_profile_model.dart';

part 'edit_profile_state.dart';
part 'event_profile_event.dart';

class EditProfileBloc extends Bloc<EditProfileEvent, EditProfileState> {
  EditProfileBloc() : super(EditProfileInitial()) {
    on<LoadUserProfile>(_onLoadUserProfile);
    on<UpdateUserProfile>(_onUpdateUserProfile);
  }

  Future<void> _onLoadUserProfile(
    LoadUserProfile event,
    Emitter<EditProfileState> emit,
  ) async {
    emit(EditProfileLoading());
    final uid = FirebaseAuth.instance.currentUser?.uid;
    if (uid == null) return emit(EditProfileError("Usuario no autenticado"));

    try {
      final doc = await FirebaseFirestore.instance
          .collection('usuarios')
          .doc(uid)
          .get();
      final user = EditProfileModel.fromFirestore(doc);
      emit(EditProfileLoaded(user));
    } catch (e) {
      emit(EditProfileError("Error al cargar perfil"));
    }
  }

  Future<void> _onUpdateUserProfile(
    UpdateUserProfile event,
    Emitter<EditProfileState> emit,
  ) async {
    emit(ProfileUpdating());
    try {
      await FirebaseFirestore.instance
          .collection('usuarios')
          .doc(event.user.id)
          .update(event.user.toMap());
      emit(ProfileUpdated());
    } catch (e) {
      emit(EditProfileError("Error al actualizar perfil"));
    }
  }
}
