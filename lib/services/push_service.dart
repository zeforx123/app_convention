import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class PushNotificationService {
  static final FirebaseMessaging _messaging = FirebaseMessaging.instance;

  static Future<void> initialize(BuildContext context) async {
    // Solicitar permisos
    NotificationSettings settings = await _messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    print('Permiso otorgado: ${settings.authorizationStatus}');

    // Obtener el token del dispositivo
    final token = await _messaging.getToken();
    print('🔑 Token FCM: $token');

    // Escuchar notificaciones en foreground
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      if (message.notification != null) {
        final notif = message.notification!;
        print('🔔 Notificación recibida: ${notif.title} - ${notif.body}');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('${notif.title}: ${notif.body}')),
        );
      }
    });

    Future<void> saveFcmToken(String userId) async {
      final token = await FirebaseMessaging.instance.getToken();
      if (token != null) {
        await FirebaseFirestore.instance
            .collection('usuarios')
            .doc(userId)
            .update({
          'fcmToken': token,
        });
      }
    }
  }
}
