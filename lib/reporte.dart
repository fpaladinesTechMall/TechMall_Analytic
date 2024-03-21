import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutterflow_ui/flutterflow_ui.dart';
import 'package:techmall_analytic/Color/ColorWidget.dart';
import 'package:techmall_analytic/firebase/data.dart';
import 'package:techmall_analytic/provider/variablesExt.dart';
import 'package:flutter/services.dart';
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

    return FutureBuilder(
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
                                    Card(
                                      color: Color.fromARGB(255, 250, 250, 250), // Color casi blanco
                                      elevation: 0,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: <Widget>[
                                                Flexible(
                                                  child: Text(
                                                    'Análisis de Seguridad Perimetral: Detección de Brechas en la Cobertura Vegetal mediante RGB y NDVI',
                                                    style:
                                                        FlutterFlowTheme.of(context).headlineMedium.override(
                                                              fontFamily: 'Outfit',
                                                              fontSize: 24,
                                                              fontWeight: FontWeight.w500,
                                                            ),
                                                    softWrap:
                                                        true, // Permite que el texto se envuelva en la pantalla
                                                    overflow: TextOverflow
                                                        .visible, // Muestra el texto aunque se desborde el espacio
                                                    maxLines: 2, // Limita el texto a mostrar en dos líneas
                                                  ),
                                                ),
                                                Text(
                                                  '11-03-2024', // Aquí deberías formatear la fecha real
                                                  style: TextStyle(
                                                    color: Colors.grey[600],
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(height: 10),
                                            Imagenes(provider: provider)
                                          ],
                                        ),
                                      ),
                                    ),
                                  ])))))
                    ]));
          }
        });
  }
}

class Imagenes extends StatelessWidget {
  const Imagenes({
    super.key,
    required this.provider,
  });

  final VariablesExt provider;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: obtenerReportes(provider.data),
        builder: (BuildContext context, AsyncSnapshot<List<Map<String, dynamic>>> snapshotUser) {
          if (snapshotUser.connectionState == ConnectionState.waiting) {
            return Container();
          } else if (snapshotUser.hasError) {
            return Text('Error: ${snapshotUser.error}');
          } else {
            List<String> imageUrls = extractImageUrls(snapshotUser.data);

            return Container(
                height: 400,
                width: 400,
                child: ListView.builder(
                  itemCount: imageUrls.length,
                  itemBuilder: (context, index) {
                    return FutureBuilder(
                      future: FirebaseStorage.instance.ref().child(imageUrls[index]).getDownloadURL(),
                      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                        if (snapshot.connectionState == ConnectionState.done && snapshot.hasData) {
                          return Image.network(snapshot.data!);
                        } else if (snapshot.connectionState == ConnectionState.waiting) {
                          return Center(child: CircularProgressIndicator());
                        } else {
                          return Center(child: Text("Error al cargar la imagen"));
                        }
                      },
                    );
                  },
                ));
          }
        });
  }
}

List<String> extractImageUrls(data) {
  List<String> urls = [];
  for (var item in data) {
    List<dynamic> images = item["Imagen"];
    urls.addAll(images.cast<String>());
  }
  return urls;
}
