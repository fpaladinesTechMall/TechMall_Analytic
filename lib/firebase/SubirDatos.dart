import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DatabaseMethods {
  Future addCorreoDetails(
      Map<String, dynamic> employeeInfoMap, String id) async {
    return await FirebaseFirestore.instance
        .collection("Correo")
        .doc(id)
        .set(employeeInfoMap);
  }

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  void addMapDetails(Map<String, dynamic> mapasInfo, String id) {
    _firestore.collection('Correo').doc(id).update(mapasInfo);
  }
}
