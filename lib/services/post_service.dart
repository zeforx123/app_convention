import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';

class PostService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> createPost(String description, File image) async {
    final user = _auth.currentUser;
    if (user == null) throw Exception('Usuario no autenticado');

    final uid = user.uid;

    // Subir imagen a Firebase Storage
    final imageId = const Uuid().v4();
    final ref = _storage.ref().child('publicaciones/$imageId.jpg');
    await ref.putFile(image);
    final imageUrl = await ref.getDownloadURL();

    // Obtener nombre y rol del usuario
    final userDoc = await _firestore.collection('usuarios').doc(uid).get();
    final nombre = userDoc.data()?['nombre'] ?? 'Anónimo';
    final rol = userDoc.data()?['rol'] ?? 'participante';

    // Guardar publicación en Firestore
    await _firestore.collection('publicaciones').add({
      'descripcion': description,
      'imagenUrl': imageUrl,
      'autorId': uid,
      'autorNombre': nombre,
      'autorRol': rol,
      'fecha': FieldValue.serverTimestamp(),
    });
  }
}
