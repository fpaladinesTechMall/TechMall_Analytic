import 'package:flutter/material.dart';
import 'package:flutterflow_ui/flutterflow_ui.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:techmall_analytic/firebase/DatosRutadata.dart';
import 'package:techmall_analytic/provider/variablesExt.dart';

class LoteWidget extends StatefulWidget {
  final String loteInicial;
  const LoteWidget({
    super.key,
    required this.loteInicial,
  });

  @override
  _LoteWidgetState createState() => _LoteWidgetState();
}

class _LoteWidgetState extends State<LoteWidget> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  String? loteSeleccionado;
  Future<List<String>> obtenerDocumentosDeSubcoleccionLote(correo, hacienda, hacienda2) async {
    if (hacienda2 == "") {
      QuerySnapshot querySnapshot = await _firestore
          .collection('Usuario')
          .doc(correo) // Sustituye esto por el ID real de tu documento
          .collection('Hacienda')
          .doc(hacienda) // Sustituye esto por el ID real de tu documento
          .collection('Lote') // Sustituye esto por el nombre de tu subcolección
          .get();
      List<String> nombres = querySnapshot.docs.map((doc) => doc['Nombre'] as String).toList();
      return nombres;
    } else {
      QuerySnapshot querySnapshot = await _firestore
          .collection('Usuario')
          .doc(correo) // Sustituye esto por el ID real de tu documento
          .collection('Hacienda')
          .doc(hacienda2) // Sustituye esto por el ID real de tu documento
          .collection('Lote') // Sustituye esto por el nombre de tu subcolección
          .get();
      List<String> nombres = querySnapshot.docs.map((doc) => doc['Nombre'] as String).toList();
      return nombres;
    }
  }

  @override
  void initState() {
    super.initState();
    // Asegúrate de que el valor inicial está en la lista de lotes
    loteSeleccionado = widget.loteInicial;
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<VariablesExt>(context, listen: true);
    return FutureBuilder<List<String>>(
        future: obtenerDocumentosDeSubcoleccionLote(provider.correo, provider.hacienda, provider.hacienda2),
        builder: (BuildContext context, AsyncSnapshot<List<String>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Text("Error: ${snapshot.error}");
          } else if (snapshot.hasData) {
            final List<String>? lotes = snapshot.data;
            if (!lotes!.contains(loteSeleccionado)) {
              loteSeleccionado = lotes.first;
              provider.sethacienda(provider.hacienda2);

              provider.setlote(loteSeleccionado!);
            }
            return DropdownButton<String>(
              value: loteSeleccionado, // Asegúrate de que este valor está en 'lotes'
              onChanged: (String? newValue) {
                provider.setlote(newValue!);
                provider.sethacienda(provider.hacienda2);
                setState(() {
                  loteSeleccionado = newValue;
                });
                //print("${provider.correo},${provider.hacienda2},${provider.lote}");
              },
              underline: Container(),
              focusColor: Colors.white,
              dropdownColor: Colors.white,
              items: lotes?.map<DropdownMenuItem<String>>((String value) {
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
