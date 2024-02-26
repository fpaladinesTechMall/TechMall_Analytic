import 'package:flutter/material.dart';

void showSuccessDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: Colors.white,
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Text(
              '¡Datos cargados exitosamente!',
              style: TextStyle(
                fontSize: 24.0, // Ajusta el tamaño de la fuente a 24 puntos
                color: const Color.fromARGB(
                    255, 117, 29, 132), // Establece el color del texto a morado
                fontWeight: FontWeight
                    .bold, // Hace que el texto sea en negrita (opcional)
              ),
            ),
            Image.asset(
                'assets/Check.png'), // Asegúrate de cambiar la ruta al lugar correcto donde se encuentra tu GIF
          ],
        ),
        actions: <Widget>[
          TextButton(
            child: Text('OK'),
            onPressed: () {
              Navigator.of(context).pop(); // Cierra el dialog
            },
          ),
        ],
      );
    },
  );
}

void mostrarDialogoCarga(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false, // Impide que se cierre el diálogo al tocar fuera
    builder: (BuildContext context) {
      return Dialog(
        child: Container(
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset('assets/upload.gif'), // Tu archivo GIF
              SizedBox(height: 15),
              Text("Cargando...", style: TextStyle(fontSize: 16)),
            ],
          ),
        ),
      );
    },
  );
}
