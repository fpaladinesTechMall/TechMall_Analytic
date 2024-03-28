import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutterflow_ui/flutterflow_ui.dart';
import 'package:techmall_analytic/Color/ColorWidget.dart';
import 'package:techmall_analytic/firebase/data.dart';
import 'package:techmall_analytic/provider/variablesExt.dart';
import 'package:flutter/services.dart';
import 'package:techmall_analytic/widgets/AuthGuard.dart';
import 'package:techmall_analytic/widgets/BarraTop.dart';

import 'package:techmall_analytic/widgets/MenuWidget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Reportes extends StatefulWidget {
  const Reportes({super.key});

  @override
  State<Reportes> createState() => _ReportesState();
}

class _ReportesState extends State<Reportes> {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<VariablesExt>(context, listen: true);

    return AuthGuard(
        child: FutureBuilder(
            future: obtenerDataUsuario(provider.correo),
            builder: (BuildContext context, AsyncSnapshot<Map<String, dynamic>?> snapshotUser) {
              if (snapshotUser.connectionState == ConnectionState.waiting) {
                return Container();
              } else if (snapshotUser.hasError) {
                return Text('Error: ${snapshotUser.error}');
              } else {
                CollectionReference users = FirebaseFirestore.instance.collection('Correo');
                if (provider.lote == "") {
                  provider.setdata("${snapshotUser.data!["DataInicial"]}");
                  provider.sethacienda("${snapshotUser.data!["HaciendaInicial"]}");
                  provider.setlote("${snapshotUser.data!["LoteInicial"]}");
                }

                return Scaffold(
                    backgroundColor: Colors.white,
                    body: Row(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (responsiveVisibility(
                            context: context,
                            phone: false,
                            tablet: false,
                          ))
                            MenuWidget(),
                          Expanded(
                              child: Align(
                                  alignment: AlignmentDirectional(0, -1),
                                  child: Container(
                                      width: double.infinity,
                                      constraints: BoxConstraints(
                                        maxWidth: 1370,
                                      ),
                                      child: SingleChildScrollView(
                                          child: Column(mainAxisSize: MainAxisSize.max, children: <Widget>[
                                        Padding(
                                          padding: EdgeInsetsDirectional.fromSTEB(16, 16, 16, 0),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              BarraTop(titulo: "Reportes"),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          width: MediaQuery.of(context).size.width * 1,
                                          margin: EdgeInsets.symmetric(vertical: 5), // Espaciado vertical
                                          child: Divider(
                                            color: AppColors.colorFondoTech(), // Color del separador
                                            height: 0.5, // Altura del contenedor del separador
                                          ),
                                        ),
                                        Imagenes()
                                      ])))))
                        ]));
              }
            }));
  }
}

//-----------------------------Generacion de imagen

class Imagenes extends StatefulWidget {
  Imagenes({
    super.key,
  });

  @override
  State<Imagenes> createState() => _ImagenesState();
}

class _ImagenesState extends State<Imagenes> {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<VariablesExt>(context, listen: true);
    var ancho = MediaQuery.sizeOf(context).width;
    var alto = MediaQuery.sizeOf(context).height;

    return Container(
      height: alto * 1,
      width: ancho * 1,
      child: StreamBuilder<QuerySnapshot>(
        stream: firestore.collection('Correo/${provider.data}/Reporte').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Algo salió mal');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text("Cargando...");
          }

          final data = snapshot.requireData;

          return ListView.builder(
            itemCount: data.size,
            itemBuilder: (context, index) {
              var reporte = Reporte.fromMap(data.docs[index].data() as Map<String, dynamic>);
              return Card(
                color: Color.fromARGB(255, 240, 246, 252),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              reporte.titulo,
                              style: TextStyle(
                                fontFamily: 'Outfit',
                                fontSize: 24,
                                fontWeight: FontWeight.w500,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Text(
                            "${reporte.fecha.day.toString().padLeft(2, '0')}-${reporte.fecha.month.toString().padLeft(2, '0')}-${reporte.fecha.year.toString()}",
                            style: TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 8), // Espacio entre el texto y la imagen
                      FutureBuilder<String>(
                        future: FirebaseStorage.instance.ref(reporte.imagen).getDownloadURL(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return CircularProgressIndicator();
                          } else if (snapshot.hasError) {
                            return Text('Error: ${snapshot.error}');
                          } else if (!snapshot.hasData || snapshot.data == null) {
                            return Text('No hay URL de imagen disponible.');
                          } else {
                            return Image.network(
                              snapshot.data.toString(), // URL de la imagen

                              fit: BoxFit.contain,
                            );
                          }
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class Reporte {
  final DateTime fecha;
  final String titulo;
  final String imagen;

  Reporte({required this.fecha, required this.titulo, required this.imagen});

  factory Reporte.fromMap(Map<String, dynamic> map) {
    return Reporte(
      fecha: DateTime.fromMillisecondsSinceEpoch(map['Fecha'].seconds * 1000),
      titulo: map['Titulo'] as String,
      imagen: map['Imagen'] as String,
    );
  }
}
