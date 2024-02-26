import 'package:cloud_firestore/cloud_firestore.dart';

class DataService {
  late final String url;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<Map<String, dynamic>>> getData() async {
    QuerySnapshot snapshot = await _firestore.collection('Usuario').get();
    return snapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
  }
}

class DataServiceHacienda {
  late final String hacienda;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<Map<String, dynamic>>> getData(hacienda) async {
    QuerySnapshot snapshot = await _firestore.collection('Usuario/$hacienda/Hacienda').get();
    return snapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
  }
}

Future<Map<String, dynamic>?> obtenerDataUsuario(correo) async {
  DocumentSnapshot docSnapshot = await FirebaseFirestore.instance.collection('Usuario').doc(correo).get();
  // Aquí podrías realizar operaciones asíncronas adicionales si fuera necesario

  if (docSnapshot.exists) {
    // Devuelve los datos del documento como un mapa
    return docSnapshot.data() as Map<String, dynamic>?;
  } else {
    // Devuelve null si el documento no existe
    return null; // Retorna la ruta del documento
  }
}

Future<List<String>> obtenerDocumentosDeSubcoleccion(usuario, hacienda, lote) async {
  QuerySnapshot querySnapshot = await FirebaseFirestore.instance
      .collection('Usuario')
      .doc(usuario) // Sustituye esto por el ID real de tu documento
      .collection('Hacienda')
      .doc(hacienda)
      .collection('Lote')
      .doc(lote)
      .collection('Fecha')
      .get();
  List<String> nombres = querySnapshot.docs.map((doc) => doc['Informacion'] as String).toList();
  return nombres;
}
