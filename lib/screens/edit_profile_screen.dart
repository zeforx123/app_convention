import 'package:app_convention/bloc/profile/edit/edit_profile_bloc.dart';
import 'package:app_convention/models/edit_profile_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final nombreController = TextEditingController();
  final biografiaController = TextEditingController();
  final alergiasController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<EditProfileBloc>().add(LoadUserProfile());
  }

  void guardarCambios(EditProfileModel user) {
    final updatedUser = EditProfileModel(
      id: user.id,
      name: nombreController.text.trim(),
      biography: biografiaController.text.trim(),
      allergies: alergiasController.text.trim(),
    );

    context.read<EditProfileBloc>().add(UpdateUserProfile(updatedUser));
  }

  @override
  void dispose() {
    nombreController.dispose();
    biografiaController.dispose();
    alergiasController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<EditProfileBloc, EditProfileState>(
      listener: (context, state) {
        if (state is ProfileUpdated) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('✅ Perfil actualizado')),
          );
          Navigator.pop(context);
        } else if (state is EditProfileError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('❌ ${state.message}')),
          );
        }
      },
      builder: (context, state) {
        if (state is EditProfileLoading || state is EditProfileInitial) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (state is EditProfileLoaded) {
          final user = state.user;
          nombreController.text = user.name;
          biografiaController.text = user.biography;
          alergiasController.text = user.allergies;

          return Scaffold(
            appBar: AppBar(title: const Text('Editar perfil')),
            body: Padding(
              padding: const EdgeInsets.all(16),
              child: ListView(
                children: [
                  TextField(
                    controller: nombreController,
                    decoration: const InputDecoration(labelText: 'Nombre'),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: biografiaController,
                    decoration: const InputDecoration(labelText: 'Biografía'),
                    maxLines: 2,
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: alergiasController,
                    decoration: const InputDecoration(labelText: 'Alergias'),
                  ),
                  const SizedBox(height: 32),
                  state is ProfileUpdating
                      ? const Center(child: CircularProgressIndicator())
                      : ElevatedButton(
                          onPressed: () => guardarCambios(user),
                          child: const Text('Guardar'),
                        ),
                ],
              ),
            ),
          );
        }

        return const Scaffold(
          body: Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}
