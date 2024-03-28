import 'package:flutter/material.dart';

Future<void> navigateWithLoading(BuildContext context) async {
  showLoadingDialog(context); // Muestra el diálogo de carga

  // Aquí podrías insertar tu operación asíncrona, como una llamada a una API.
  // Simularemos una espera con un delay.
  await Future.delayed(Duration(seconds: 2));

  // Cierra el diálogo de carga justo antes de la navegación
  Navigator.of(context).pop();

  // Navega a la nueva página
  Navigator.pushNamed(context, "/Dashboard");
}

void showLoadingDialog(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false, // El usuario no puede cerrar el diálogo tocando fuera de él.
    builder: (BuildContext context) {
      return Dialog(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircularProgressIndicator(),
              SizedBox(width: 20),
              Text("Cargando..."),
            ],
          ),
        ),
      );
    },
  );
}
