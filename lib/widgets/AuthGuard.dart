import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthGuard extends StatelessWidget {
  final Widget child;
  AuthGuard({required this.child});

  @override
  Widget build(BuildContext context) {
    // Verifica el estado de autenticación del usuario
    final user = FirebaseAuth.instance.currentUser;

    // Si el usuario no está autenticado, redirige a la página de inicio de sesión
    if (user == null) {
      Future.microtask(() => Navigator.of(context).pushReplacementNamed('/Auth'));
      // Muestra un widget de carga o un contenedor vacío mientras se procesa la redirección
      return Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    // Si el usuario está autenticado, permite el acceso a la página solicitada
    return child;
  }
}
