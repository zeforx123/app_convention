import 'package:app_convention/entities/profile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfileModel {
  static Future<Profile?> fetchCurrentUserProfile() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) return null;

    final doc = await FirebaseFirestore.instance
        .collection('usuarios')
        .doc(user.uid)
        .get();

    final data = doc.data();
    if (data == null) return null;

    return Profile(
      uid: user.uid,
      nombre: data['nombre'] ?? '',
      email: user.email ?? '',
      rol: data['rol'] ?? '',
      biografia: (data['biografia'] ?? '').isNotEmpty ? data['biografia'] : '-',
      alergias: (data['alergias'] ?? '').isNotEmpty ? data['alergias'] : '-',
    );
  }
}
