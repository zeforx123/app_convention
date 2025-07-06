class Publicacion {
  final String? id;
  final String descripcion;
  final String autorNombre;
  final String? imagenUrl;
  final DateTime fecha;

  Publicacion({
    this.id,
    required this.descripcion,
    required this.autorNombre,
    required this.fecha,
    this.imagenUrl,
  });
}