import 'package:app_convention/models/publication_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:timeago/timeago.dart' as timeago;

class FeedScreen extends StatefulWidget {
  const FeedScreen({super.key});

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('publicaciones')
                .orderBy('fecha', descending: true)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }

              if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                return const Center(child: Text('No hay publicaciones aún.'));
              }

              final publicaciones = snapshot.data!.docs
                  .map((doc) => PublicacionModel.fromMap(
                      doc.data() as Map<String, dynamic>, doc.id))
                  .toList();

              return ListView.builder(
                itemCount: publicaciones.length,
                itemBuilder: (context, index) {
                  final publicacion = publicaciones[index];

                  return Card(
                    margin:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (publicacion.imagenUrl != null)
                          Image.network(publicacion.imagenUrl!),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            publicacion.descripcion,
                            style: const TextStyle(fontSize: 16),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Por ${publicacion.autorNombre}\n${timeago.format(publicacion.fecha, locale: 'es')}',
                                style: const TextStyle(color: Colors.grey),
                              ),
                              IconButton(
                                icon: const Icon(Icons.share),
                                onPressed: () {
                                  final texto =
                                      "${publicacion.descripcion}\n\nImagen: ${publicacion.imagenUrl}";
                                  Share.share(texto);
                                },
                              )
                            ],
                          ),
                        ),
                        const SizedBox(height: 8),
                      ],
                    ),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
