import 'package:app_convention/services/auth_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<LoginRequested>(_onLoginRequested);
    on<RegisterRequested>(_onRegisterRequested);
  }

  Future<void> _onLoginRequested(
      LoginRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final user = await AuthService().login(event.email, event.password);
      if (user != null) {
        emit(AuthSuccess(user));
      } else {
        emit(AuthFailure("Usuario no encontrado"));
      }
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }

  Future<void> _onRegisterRequested(
      RegisterRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    if (event.password != event.confirmPassword) {
      emit(AuthFailure('Las contraseñas no coinciden'));
      return;
    }

    try {
      final user = await AuthService().register(event.email, event.password);
      if (user != null) {
        await FirebaseFirestore.instance
            .collection('usuarios')
            .doc(user.uid)
            .set({
          'nombre': event.name,
          'correo': event.email,
          'rol': 'participante',
          'biografia': '',
          'alergias': '',
          'createdAt': FieldValue.serverTimestamp(),
        });
        emit(AuthSuccess(user));
      } else {
        emit(AuthFailure('Error al registrar usuario'));
      }
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }
}
