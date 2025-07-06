import 'package:cloud_firestore/cloud_firestore.dart';

import '../entities/user.dart';

class EditProfileModel extends User {
  EditProfileModel({
    required super.id,
    required super.name,
    required super.biography,
    required super.allergies,
  });

  factory EditProfileModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return EditProfileModel(
      id: doc.id,
      name: data['nombre'] ?? '',
      biography: data['biografia'] ?? '',
      allergies: data['alergias'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'nombre': name,
      'biografia': biography,
      'alergias': allergies,
    };
  }
}
