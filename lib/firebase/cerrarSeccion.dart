import 'package:firebase_auth/firebase_auth.dart';

void cerrarSesion() async {
  try {
    await FirebaseAuth.instance.signOut();
    print("Se ha cerrado la sesión exitosamente.");
    // Aquí puedes redirigir al usuario a la pantalla de inicio de sesión
    // o realizar otras acciones necesarias después de cerrar la sesión.
  } catch (e) {
    print("Ocurrió un error al cerrar sesión: $e");
    // Maneja el error, por ejemplo, mostrando un mensaje al usuario.
  }
}
