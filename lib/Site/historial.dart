import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutterflow_ui/flutterflow_ui.dart';
import 'package:techmall_analytic/Color/ColorWidget.dart';
import 'package:techmall_analytic/firebase/data.dart';
import 'package:techmall_analytic/provider/variablesExt.dart';
import 'package:provider/provider.dart';
import 'package:techmall_analytic/widgets/AuthGuard.dart';
import 'package:techmall_analytic/widgets/BarraTop.dart';
import 'package:techmall_analytic/widgets/MenuWidget.dart';
import 'package:fl_chart/fl_chart.dart';

class HistorialWidget extends StatefulWidget {
  const HistorialWidget({super.key});

  @override
  State<HistorialWidget> createState() => _HistorialWidgetState();
}

class _HistorialWidgetState extends State<HistorialWidget> {
  final List<DateTime> dates = [
    DateTime(2023, 1, 15),
    DateTime(2023, 2, 20),
    DateTime(2023, 3, 25),
    DateTime(2023, 4, 30),
    DateTime(2023, 5, 23),
  ];
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<VariablesExt>(context, listen: true);

    // Usa el valor seleccionado

    altura:
    MediaQuery.sizeOf(context).height;
    ancho:
    MediaQuery.sizeOf(context).width;

    if (isiOS) {
      SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(
          statusBarBrightness: Theme.of(context).brightness,
          systemStatusBarContrastEnforced: true,
        ),
      );
    }
    final user = FirebaseAuth.instance.currentUser;
//AuthGuard(child: agregar para inicio con usuario
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
                                constraints: BoxConstraints(
                                  maxWidth: 1370,
                                ),
                                child: SingleChildScrollView(
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(16, 16, 16, 0),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            BarraTop(titulo: "NDVI"),
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
                                      Container(
                                        padding: EdgeInsets.all(20),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: <Widget>[
                                                Flexible(
                                                  child: Text(
                                                    'Historial NDVI',
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
                                            Row(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                SizedBox(width: 60),
                                                Column(
                                                  children: [
                                                    Text(
                                                      'Promedio:',
                                                      style: TextStyle(
                                                        fontWeight: FontWeight.bold,
                                                      ),
                                                    ),
                                                    Text('70%'),
                                                  ],
                                                ),
                                                SizedBox(width: 40), // Espacio entre los grupos de texto
                                                Column(
                                                  children: [
                                                    Text(
                                                      'Valor más alto:',
                                                      style: TextStyle(
                                                        fontWeight: FontWeight.bold,
                                                      ),
                                                    ),
                                                    Text('85%'),
                                                  ],
                                                ),
                                                SizedBox(width: 40), // Espacio entre los grupos de texto
                                                Column(
                                                  children: [
                                                    Text(
                                                      'Hectáreas:',
                                                      style: TextStyle(
                                                        fontWeight: FontWeight.bold,
                                                      ),
                                                    ),
                                                    Text('120'),
                                                  ],
                                                ),
                                              ],
                                            ),
                                            SizedBox(height: 20),
                                            Container(
                                              height: 300,
                                              width: MediaQuery.of(context).size.width * 1,
                                              child: LineChart(
                                                LineChartData(
                                                  borderData: FlBorderData(show: false),
                                                  titlesData: FlTitlesData(
                                                    leftTitles: AxisTitles(
                                                      sideTitles: SideTitles(
                                                        showTitles: true,
                                                        getTitlesWidget: (value, meta) {
                                                          return Text('${value.toInt()}%');
                                                        },
                                                        reservedSize: 50,
                                                        interval: 20, // Define el intervalo de los títulos
                                                      ),
                                                    ),
                                                    rightTitles: AxisTitles(
                                                      sideTitles: SideTitles(showTitles: false),
                                                    ),
                                                    topTitles: AxisTitles(
                                                      sideTitles: SideTitles(showTitles: false),
                                                    ),
                                                    bottomTitles: AxisTitles(
                                                      sideTitles: SideTitles(
                                                        showTitles: true,
                                                        getTitlesWidget: (value, meta) {
                                                          final index = value.toInt();
                                                          // Verifica que el índice esté dentro del rango de tus fechas
                                                          if (index < 0 || index >= dates.length) {
                                                            return Text('');
                                                          }
                                                          DateTime date = dates[index];
                                                          String formattedDate =
                                                              DateFormat('dd MMM').format(date);
                                                          String year = DateFormat('yyyy').format(date);
                                                          return Padding(
                                                            padding: const EdgeInsets.only(
                                                                top:
                                                                    5), // Ajusta el padding según sea necesario
                                                            child: Column(
                                                              mainAxisSize: MainAxisSize.min,
                                                              children: [
                                                                Text(formattedDate,
                                                                    style: TextStyle(
                                                                        color: Colors.black,
                                                                        fontWeight: FontWeight.bold,
                                                                        fontSize: 10)),
                                                                Divider(
                                                                    color: Colors.grey,
                                                                    height: 2,
                                                                    thickness:
                                                                        1), // Línea separadora para el año
                                                                Text(year,
                                                                    style: TextStyle(
                                                                        color: Colors.grey, fontSize: 8)),
                                                              ],
                                                            ),
                                                          );
                                                        },
                                                        reservedSize: 60,
                                                        // Asegura que los títulos solo se muestren para los índices específicos de tus datos
                                                        interval:
                                                            1, // Intervalo de 1 para alinear con índices de puntos de datos
                                                      ),
                                                    ),
                                                  ),
                                                  gridData: FlGridData(show: true),
                                                  lineBarsData: [
                                                    LineChartBarData(
                                                      spots: [
                                                        FlSpot(0, 70),
                                                        FlSpot(1, 80),
                                                        FlSpot(2, 75),
                                                        FlSpot(3, 85),
                                                        FlSpot(4, 30),
                                                      ],
                                                      isCurved: true,
                                                      color: AppColors.colorFondoTech(),
                                                      barWidth: 5,
                                                      isStrokeCapRound: true,
                                                      dotData: FlDotData(show: false),
                                                      belowBarData: BarAreaData(show: false),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Text(
                                                "En el gráfico, el eje Y muestra el porcentaje de NDVI que se considera sano para un campo de banano, variando desde un 40% hasta un 85%, mientras que el eje X representa la línea de tiempo mencionada. La línea negra del gráfico muestra un aumento inicial en la salud de la vegetación, comenzando cerca del 50% y subiendo hasta un poco más del 80% alrededor de finales de febrero de 2023. Este aumento puede interpretarse como un periodo de crecimiento o recuperación saludable de las plantas de banano. Posteriormente, desde finales de febrero hasta aproximadamente finales de abril, el NDVI se mantiene estable en torno al 80%, lo que podría significar que la vegetación se mantuvo saludable y no hubo cambios significativos en las condiciones de las plantas. Después de este periodo de estabilidad, hay un descenso notable que comienza al final de abril y continúa hasta el 23 de mayo, cayendo por debajo del 60%. Esta tendencia decreciente puede ser indicativa de estrés en las plantas, posiblemente debido a factores como enfermedades, falta de agua o nutrientes, o daño por plagas, entre otros.")
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          )
                        ]));
              }
            }));
  }
}
