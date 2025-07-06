import 'dart:io';

import 'package:app_convention/bloc/post/post_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class CreatePostScreen extends StatefulWidget {
  const CreatePostScreen({super.key});

  @override
  State<CreatePostScreen> createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {
  final descripcionController = TextEditingController();

  Future<void> pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: source);
    if (picked != null) {
      final imageFile = File(picked.path);
      final imageSize = await imageFile.length();

      if (imageSize > 5 * 1024 * 1024) {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('❌ La imagen no puede superar los 5MB')),
        );
        return;
      }

      context.read<PostBloc>().add(SelectImageRequested(imageFile));
    }
  }

  void _mostrarSelectorDeImagen() {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return SafeArea(
          child: Wrap(
            children: [
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Seleccionar desde galería'),
                onTap: () async {
                  Navigator.pop(context);
                  await pickImage(ImageSource.gallery);
                },
              ),
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text('Tomar foto con cámara'),
                onTap: () async {
                  Navigator.pop(context);
                  await pickImage(ImageSource.camera);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _publicar(File image) {
    final descripcion = descripcionController.text.trim();
    if (descripcion.isEmpty) return;

    context.read<PostBloc>().add(
          CreatePostRequested(description: descripcion, image: image),
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Nueva publicación')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: BlocConsumer<PostBloc, PostState>(
          listener: (context, state) {
            if (state is PostSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('✅ Publicación creada')),
              );
              Navigator.pop(context);
            } else if (state is PostFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Error: ${state.message}')),
              );
            }
          },
          builder: (context, state) {
            final loading = state is PostLoading;
            final imageSelected =
                state is PostImageSelected ? state.image : null;

            return ListView(
              children: [
                if (imageSelected != null)
                  Image.file(imageSelected, height: 200, fit: BoxFit.cover)
                else
                  TextButton.icon(
                    onPressed: _mostrarSelectorDeImagen,
                    icon: const Icon(Icons.image),
                    label: const Text('Seleccionar imagen'),
                  ),
                const SizedBox(height: 16),
                TextField(
                  controller: descripcionController,
                  maxLines: 3,
                  decoration: const InputDecoration(
                    labelText: 'Descripción',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 24),
                loading
                    ? const Center(child: CircularProgressIndicator())
                    : ElevatedButton(
                        onPressed: imageSelected != null
                            ? () => _publicar(imageSelected)
                            : null,
                        child: const Text('Publicar'),
                      ),
              ],
            );
          },
        ),
      ),
    );
  }
}
