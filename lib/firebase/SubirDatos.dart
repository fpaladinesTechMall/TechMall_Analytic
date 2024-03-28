import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

//Nota: Son dos funciones, la primera data te guarda la información correspondiente del detalle y la segunda te guarda la ruta de archivo
class DatabaseMethods {
  Future addCorreoDetails(Map<String, dynamic> employeeInfoMap, String id) async {
    return await FirebaseFirestore.instance.collection("Correo").doc(id).set(employeeInfoMap);
  }

  Future addUsuarioDetails(Map<String, dynamic> usuarioInfoMap, String id) async {
    return await FirebaseFirestore.instance.collection("Usuario").doc(id).set(usuarioInfoMap);
  }

  Future addUsuarioDetailsruta(
      Map<String, dynamic> usuarioInfoMap, String id, String hacienda, String lote, String fecha) async {
    return await FirebaseFirestore.instance
        .collection("Usuario")
        .doc(id)
        .collection("hacienda")
        .doc(hacienda)
        .collection("Lote")
        .doc(lote)
        .collection("Fecha")
        .doc(fecha)
        .set(usuarioInfoMap);
  }

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  void addMapDetails(Map<String, dynamic> mapasInfo, String id) {
    _firestore.collection('Correo').doc(id).update(mapasInfo);
  }
}
