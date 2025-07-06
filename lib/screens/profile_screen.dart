import 'package:app_convention/bloc/profile/edit/edit_profile_bloc.dart';
import 'package:app_convention/bloc/profile/profile_bloc.dart';
import 'package:app_convention/entities/profile.dart';
import 'package:app_convention/screens/edit_profile_screen.dart';
import 'package:app_convention/screens/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  void logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => const LoginScreen()),
      (_) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ProfileBloc()..add(LoadProfileRequested()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Mi perfil'),
          actions: [
            BlocBuilder<ProfileBloc, ProfileState>(
              builder: (context, state) {
                if (state is ProfileLoaded &&
                    state.profile.rol != "organizador") {
                  return IconButton(
                    icon: const Icon(Icons.edit),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => BlocProvider(
                            create: (_) => EditProfileBloc(),
                            child: const EditProfileScreen(),
                          ),
                        ),
                      ).then((_) {
                        context.read<ProfileBloc>().add(LoadProfileRequested());
                      });
                    },
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ],
        ),
        body: BlocBuilder<ProfileBloc, ProfileState>(
          builder: (context, state) {
            if (state is ProfileLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is ProfileError) {
              return Center(child: Text("Error: ${state.message}"));
            }

            if (state is ProfileLoaded) {
              final Profile profile = state.profile;

              return Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Nombre",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold)),
                    Text('${profile.nombre} (${profile.rol})',
                        style: const TextStyle(fontSize: 14)),
                    const SizedBox(height: 10),
                    const Text("Biografía",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold)),
                    Text(profile.biografia,
                        style: const TextStyle(fontSize: 14)),
                    const SizedBox(height: 10),
                    const Text("Alergias",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold)),
                    Text(profile.alergias,
                        style: const TextStyle(fontSize: 14)),
                    const SizedBox(height: 130),
                    Center(
                      child: ElevatedButton(
                        onPressed: () => logout(context),
                        child: const Text('Cerrar Sesión'),
                      ),
                    ),
                  ],
                ),
              );
            }

            return const SizedBox.shrink(); // fallback
          },
        ),
      ),
    );
  }
}
