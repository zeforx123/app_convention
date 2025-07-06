import * as admin from "firebase-admin";
import * as functions from "firebase-functions/v1";

admin.initializeApp();

export const notificarPublicacion = functions
  .region("us-central1")
  .runWith({
    memory: "256MB",
    timeoutSeconds: 60,
    minInstances: 0,
    maxInstances: 1,
    ingressSettings: "ALLOW_ALL",
    serviceAccount:
      "firebase-adminsdk-fbsvc@app-convention.iam.gserviceaccount.com", // ✅ debe ser string
  }) // ✅ Correcto para funciones modernas
  .firestore.document("publicaciones/{pubId}")
  .onCreate(async (snap, context) => {
    const data = snap.data() as {
      descripcion?: string;
      tokens?: string[];
    };

    if (!data) {
      console.log("No hay datos en la publicación.");
      return null;
    }

    const tokens = data.tokens ?? [];

    if (tokens.length === 0) {
      console.log("No hay tokens para enviar notificaciones.");
      return null;
    }

    const message = {
      notification: {
        title: "Nueva publicación",
        body: data.descripcion ?? "¡Hay una nueva publicación disponible!",
      },
      tokens, // lista de tokens
    };

    try {
      const response = await admin.messaging().sendEachForMulticast(message);

      const fallidos = response.responses.filter((r) => !r.success).length;

      console.log(`Notificaciones enviadas: ${response.successCount}`);
      console.log(`Errores al enviar: ${fallidos}`);

      return null;
    } catch (error) {
      console.error("Error al enviar notificación:", error);
      return null;
    }
  });
