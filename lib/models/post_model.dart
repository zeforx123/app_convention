import 'package:app_convention/entities/post.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PostModel {
  static Post fromMap(Map<String, dynamic> map, String id) {
    return Post(
      id: id,
      description: map['descripcion'] ?? '',
      imageUrl: map['imagenUrl'] ?? '',
      authorId: map['autorId'] ?? '',
      authorName: map['autorNombre'] ?? '',
      authorRole: map['autorRol'] ?? '',
      date: (map['fecha'] as Timestamp?)?.toDate() ?? DateTime.now(),
    );
  }

  static Map<String, dynamic> toMap(Post post) {
    return {
      'descripcion': post.description,
      'imagenUrl': post.imageUrl,
      'autorId': post.authorId,
      'autorNombre': post.authorName,
      'autorRol': post.authorRole,
      'fecha': FieldValue.serverTimestamp(),
    };
  }
}
