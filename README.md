# 📱 App Convention

Una app Flutter moderna para eventos y convenciones, que conecta a los participantes mediante una experiencia al estilo Instagram/TikTok, permite personalizar contenidos, centraliza la comunicación del evento y fomenta la interacción en tiempo real.

---

## 🚀 Características principales

- Autenticación con Firebase Auth.
- Publicaciones con imagen, descripción y feed estilo social media.
- Notificaciones push según el rol (solo organizador).
- Perfil editable con datos como alergias y biografía.
- Consumo de API externa (clima o tipo de cambio).
- Manejo de estado con `flutter_bloc`.
- Integración completa con Firebase (Auth, Firestore, Storage, FCM).

---

## 📦 Requisitos

- **Flutter**: 3.19.6
- **Dart**: 3.3.4
- **SDK**: `>=3.3.4 <4.0.0`

---

## 🛠 Instalación y ejecución

1. **Clona el repositorio**

```bash
git clone <REPO_URL>
cd app_convention
```

2. **Instala las dependencias**

```bash
flutter pub get
```

3. **Ejecuta la app**

```bash
flutter run
```

> Asegúrate de tener un emulador o dispositivo físico conectado.

---

## 📁 Principales dependencias

```yaml
firebase_core: ^3.4.0
firebase_auth: ^5.2.0
cloud_firestore: ^5.4.0
firebase_storage: ^12.2.0
firebase_messaging: ^15.1.0
flutter_bloc: ^9.1.1
equatable: ^2.0.7
http: ^1.2.2
intl: ^0.20.2
image_picker: ^1.1.2
flutter_local_notifications: ^18.0.1
```

---

## 📚 Arquitectura y organización

- `bloc/`: BLoCs para cada funcionalidad (login, post, profile, edit_profile…)
- `models/` y `entities/`: Separación clara entre datos de negocio y estructuras para UI.
- `services/`: Lógica de acceso a Firebase y APIs externas.
- `screens/`: Pantallas por flujo (login, feed, profile, edit, etc).

---

## 🌎 API externa

- **ExchangeRate-API** (gratuita): muestra el tipo de cambio USD a PEN.

📌 Ejemplo de endpoint:

```bash
https://v6.exchangerate-api.com/v6/5e6e439d6b1bdb8801d5e129/latest/USD
```

---

## ✨ Extras

- ✅ Validación de tamaño de imagen (≤ 5MB) antes de subir a Firebase Storage.
- ✅ Adaptado a distintos tamaños de pantalla.
- ✅ Experiencia moderna, fluida y amigable.
- ✅ Estado controlado con `flutter_bloc` en todos los flujos.

---

## 🧑‍💻 Autor

Desarrollado por **Julio Machahuay Giraldo** como parte de una prueba técnica de Flutter para una app de convenciones y eventos.
