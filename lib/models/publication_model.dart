import 'package:app_convention/entities/publication.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PublicacionModel {
  static Publicacion fromMap(Map<String, dynamic> map, String id) {
    return Publicacion(
      id: id,
      descripcion: map['descripcion'] ?? '',
      autorNombre: map['autorNombre'] ?? 'Desconocido',
      imagenUrl: map['imagenUrl'],
      fecha: (map['fecha'] as Timestamp?)?.toDate() ?? DateTime.now(),
    );
  }

  static Map<String, dynamic> toMap(Publicacion publicacion) {
    return {
      'descripcion': publicacion.descripcion,
      'autorNombre': publicacion.autorNombre,
      'imagenUrl': publicacion.imagenUrl,
      'fecha': Timestamp.fromDate(publicacion.fecha),
    };
  }
}
