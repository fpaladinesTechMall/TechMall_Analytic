import 'package:flutter/material.dart';
import 'package:flutterflow_ui/flutterflow_ui.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:techmall_analytic/provider/variablesExt.dart';

class DataConexion extends StatelessWidget {
  const DataConexion({super.key});
  Future<Map<String, dynamic>?> obtenerDatosDeDocumento(
      String correo, String hacienda, String lote) async {
    // Obtén una referencia al documento específico
    DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance
        .collection('Usuario')
        .doc(correo) // El ID real del documento del usuario
        .collection('Hacienda')
        .doc(hacienda) // El ID real del documento de hacienda
        .collection('Lote')
        .doc(lote) // El ID real del documento de lote
        .get();

    // Verifica si el documento existe y devuelve sus datos
    if (documentSnapshot.exists) {
      return documentSnapshot.data() as Map<String, dynamic>?;
    } else {
      // Devuelve null si el documento no existe
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<VariablesExt>(context, listen: true);
    print("object");
    return FutureBuilder<Map<String, dynamic>?>(
      future: obtenerDatosDeDocumento(
          provider.correo, provider.hacienda, provider.lote),
      builder: (BuildContext context,
          AsyncSnapshot<Map<String, dynamic>?> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator(); // Mostrar un indicador de carga mientras espera
        } else if (snapshot.hasError) {
          return Text("Error: ${snapshot.error}"); // Manejar errores
        } else if (snapshot.hasData) {
          print("${snapshot.data!}");
          // Mostrar los datos del documento
          Map<String, dynamic>? datos = snapshot.data;
          // Asumiendo que el documento tiene un campo 'nombre'
          String nombre = datos?['nombre'] ?? 'Nombre no disponible';
          return Text("Nombre: $nombre");
        } else {
          return Text("No hay datos disponibles");
        }
      },
    );
  }
}
