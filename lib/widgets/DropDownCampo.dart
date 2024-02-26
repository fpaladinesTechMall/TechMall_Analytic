import 'package:flutter/material.dart';
import 'package:flutterflow_ui/flutterflow_ui.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:techmall_analytic/provider/variablesExt.dart';

class CampoWidget extends StatefulWidget {
  final String campoInicial;
  const CampoWidget({
    super.key,
    required this.campoInicial,
  });

  @override
  _CampoWidgetState createState() => _CampoWidgetState();
}

class _CampoWidgetState extends State<CampoWidget> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  String? campoSeleccionado;
  Future<List<String>> obtenerDocumentosDeSubcoleccion() async {
    QuerySnapshot querySnapshot = await _firestore
        .collection('Usuario')
        .doc('GonzaloQuintana@techmall.com') // Sustituye esto por el ID real de tu documento
        .collection('Hacienda') // Sustituye esto por el nombre de tu subcolección
        .get();
    List<String> nombres = querySnapshot.docs.map((doc) => doc['Nombre'] as String).toList();
    return nombres;
  }

  @override
  void initState() {
    super.initState();
    // Asegúrate de que el valor inicial está en la lista de lotes
    campoSeleccionado = widget.campoInicial;
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<VariablesExt>(context, listen: true);
    return FutureBuilder<List<String>>(
        future: obtenerDocumentosDeSubcoleccion(),
        builder: (BuildContext context, AsyncSnapshot<List<String>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Text("Error: ${snapshot.error}");
          } else if (snapshot.hasData) {
            final List<String>? haciendas = snapshot.data;
            if (provider.hacienda2 != "") {
              campoSeleccionado = provider.hacienda2;
            }
            return DropdownButton<String>(
              value: campoSeleccionado, // Asegúrate de que este valor está en 'lotes'
              //Actualizar la informacion dado que obtiene el primer valor mas no el cambio

              onChanged: (String? newValue) {
                //provider.setlote(lotes!.first);
                provider.sethacienda2(newValue!);
                setState(() {
                  campoSeleccionado = newValue;
                });
              },
              underline: Container(),
              focusColor: Colors.white,
              dropdownColor: Colors.white,
              items: haciendas?.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(
                    value,
                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                          fontFamily: 'Readex Pro',
                          color: FlutterFlowTheme.of(context).secondaryText,
                          fontSize: 17,
                        ),
                  ),
                );
              }).toList(),
            );
          } else {
            return Text("No hay datos disponibles");
          }
        });
  }
}
