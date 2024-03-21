import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutterflow_ui/flutterflow_ui.dart';
import 'package:techmall_analytic/Color/ColorWidget.dart';
import 'package:techmall_analytic/firebase/data.dart';
import 'package:techmall_analytic/provider/variablesExt.dart';
import 'package:techmall_analytic/widgets/AuthGuard.dart';
import 'package:techmall_analytic/widgets/BarraTop.dart';
import 'package:techmall_analytic/widgets/DatosContainer.dart';
import 'package:techmall_analytic/widgets/DropDownCampo.dart';
import 'package:techmall_analytic/widgets/DropDownLote.dart';
import 'package:techmall_analytic/widgets/ImagenEstadistica.dart';
import 'package:techmall_analytic/widgets/ImagenPrincipalMovil.dart';
import 'package:techmall_analytic/widgets/ImagenPrincipalWeb.dart';
import 'package:techmall_analytic/widgets/ImagenTopografia.dart';
import 'package:techmall_analytic/widgets/MenuUsuario.dart';
import 'package:techmall_analytic/widgets/MenuWidget.dart';
import 'package:techmall_analytic/widgets/textfirebasehome.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomePageWidget extends StatefulWidget {
  const HomePageWidget({Key? key}) : super(key: key);

  @override
  _HomePageWidgetState createState() => _HomePageWidgetState();
}

class _HomePageWidgetState extends State<HomePageWidget> with TickerProviderStateMixin {
  late HomePageModel _model;
  String loteInicial = "";
  bool menuDesplegable = false;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    super.initState();

    _model = createModel(context, () => HomePageModel());
  }

  @override
  void dispose() {
    _model.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<VariablesExt>(context, listen: true);

    // Usa el valor seleccionado

    if (isiOS) {
      SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(
          statusBarBrightness: Theme.of(context).brightness,
          systemStatusBarContrastEnforced: true,
        ),
      );
    }
    CollectionReference users = FirebaseFirestore.instance.collection('Correo');

//AuthGuard(child:
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
                key: scaffoldKey,
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
                            decoration: BoxDecoration(),
                            child: SingleChildScrollView(
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(16, 16, 16, 0),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        BarraTop(
                                          titulo: 'Mapas Multiespectrales',
                                        ),
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
                                  FutureBuilder<List<String>>(
                                      future: obtenerDocumentosDeSubcoleccion(
                                          provider.correo, provider.hacienda, provider.lote),
                                      builder:
                                          (BuildContext context, AsyncSnapshot<List<String>> snapshotRuta) {
                                        if (snapshotRuta.connectionState == ConnectionState.waiting) {
                                          return Center(child: CircularProgressIndicator());
                                        } else if (snapshotRuta.hasError) {
                                          return Text("Error: ${snapshotRuta.error}");
                                        } else {
                                          loteInicial = provider.lote;
                                          return FutureBuilder<DocumentSnapshot>(
                                              future: users.doc(snapshotRuta.data!.last).get(),
                                              builder: (BuildContext context,
                                                  AsyncSnapshot<DocumentSnapshot> snapshot) {
                                                if (snapshot.connectionState == ConnectionState.waiting) {
                                                  return Container();
                                                } else if (snapshot.hasError) {
                                                  return Text('Error: ${snapshot.error}');
                                                } else {
                                                  loteInicial = provider.lote;
                                                  return Column(
                                                    children: [
                                                      Center(
                                                        child: Row(
                                                          mainAxisSize: MainAxisSize.max,
                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                          children: [
                                                            Container(
                                                              child: Text(
                                                                "Fecha de Mapeo:",
                                                                textAlign: TextAlign.start,
                                                                style: FlutterFlowTheme.of(context)
                                                                    .bodyMedium
                                                                    .override(
                                                                      fontFamily: 'Readex Pro',
                                                                      color: FlutterFlowTheme.of(context)
                                                                          .primaryText,
                                                                      fontSize: 17,
                                                                    ),
                                                              ),
                                                            ),
                                                            Container(
                                                              width: MediaQuery.sizeOf(context).width * 0.02,
                                                            ),
                                                            Container(
                                                              width: MediaQuery.sizeOf(context).width * 0.55,
                                                              height:
                                                                  MediaQuery.sizeOf(context).height * 0.06,
                                                              decoration: BoxDecoration(
                                                                color: FlutterFlowTheme.of(context)
                                                                    .secondaryBackground,
                                                              ),
                                                              child: Align(
                                                                  alignment: AlignmentDirectional(0, 0),
                                                                  child: DataDisplayFecha()),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Container(
                                                        width: 400,
                                                        height: 10,
                                                        decoration: BoxDecoration(),
                                                      ),
                                                      if (responsiveVisibility(
                                                        context: context,
                                                        phone: false,
                                                        tablet: false,
                                                      ))
                                                        ImagenHomePrincipalWeb(
                                                          urlRGB: "${snapshot.data!['PNG_RGB']}",
                                                          urlNDVI: "${snapshot.data!['PNG_NDVI']}",
                                                        ),
                                                      if (responsiveVisibility(
                                                        context: context,
                                                        desktop: false,
                                                        tabletLandscape: false,
                                                      ))
                                                        ImagenHomePrincipalMOVIL(
                                                          urlRGB: "${snapshot.data!['PNG_RGB']}",
                                                        ),
                                                      Container(
                                                        height: 10,
                                                        decoration: BoxDecoration(),
                                                      ),
                                                      //Fecha desplegable--------------------
                                                      Row(
                                                        children: [
                                                          Container(
                                                            width: 20,
                                                          ),
                                                        ],
                                                      ),

                                                      Container(
                                                        height: 10,
                                                      ),
                                                      Container(
                                                        width: MediaQuery.of(context).size.width,
                                                        margin: EdgeInsets.symmetric(
                                                            vertical: 5), // Espaciado vertical
                                                        child: Divider(
                                                          color: AppColors
                                                              .colorFondoTech(), // Color del separador
                                                          height: 0.5, // Altura del contenedor del separador
                                                        ),
                                                      ),
                                                      Container(
                                                        height: 30,
                                                      ),
                                                      Row(
                                                        children: [
                                                          Container(
                                                            width: 20,
                                                          ),
                                                          Container(
                                                            child: Text(
                                                              'Datos obtenidos en el monitoreo:',
                                                              textAlign: TextAlign.start,
                                                              style: FlutterFlowTheme.of(context)
                                                                  .bodyMedium
                                                                  .override(
                                                                    fontFamily: 'Readex Pro',
                                                                    color: FlutterFlowTheme.of(context)
                                                                        .primaryText,
                                                                    fontSize: 18,
                                                                  ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      SizedBox(
                                                        height: 10,
                                                      ),
                                                      Container(
                                                        width: MediaQuery.of(context).size.width,
                                                        child: Wrap(
                                                          children: [
                                                            //snapshot.data!['Campo']
                                                            InfoContainer(
                                                                title: 'Nombre de la hacienda',
                                                                content: '${snapshot.data!['Campo']}'),
                                                            InfoContainer(
                                                                title: 'Ubicación',
                                                                content: '${snapshot.data!['Ubicación']}'),
                                                            InfoContainer(
                                                                title: 'Propietario',
                                                                content: '${snapshot.data!['Propietario']}'),
                                                            InfoContainer(
                                                                title: 'Tipo de cultivo',
                                                                content: '${snapshot.data!['Cultivo']}'),
                                                            InfoContainer(
                                                                title: 'Temperatura',
                                                                content: "${snapshot.data!['Temperatura']}"),
                                                            InfoContainer(
                                                                title: 'Fecha de siembra',
                                                                content:
                                                                    '${snapshot.data!['FechaDeSiembra']}'),
                                                            InfoContainer(
                                                                title: 'Hectareas',
                                                                content: '${snapshot.data!['Hectareas']}'),
                                                            InfoContainer(
                                                                title: 'Porcentaje NDVI',
                                                                content:
                                                                    '${snapshot.data!['Porcentaje NDVI']}'),
                                                            // Agrega más InfoContainer según necesites...
                                                          ],
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        height: 10,
                                                      ),
                                                      ImagenEstadistica(
                                                        urlPie: "${snapshot.data!['PNG_PieNDVI']}",
                                                        urlHistograma: "${snapshot.data!['PNG_Histograma']}",
                                                      ),
                                                      Container(
                                                        width: MediaQuery.of(context).size.width,
                                                        margin: EdgeInsets.symmetric(
                                                            vertical: 5), // Espaciado vertical
                                                        child: Divider(
                                                          color: AppColors
                                                              .colorFondoTech(), // Color del separador
                                                          height: 0.5, // Altura del contenedor del separador
                                                        ),
                                                      ),
                                                      Container(
                                                        height: 30,
                                                      ),
                                                      Padding(
                                                        padding: const EdgeInsets.all(8.0),
                                                        child: Container(
                                                          width: MediaQuery.of(context).size.width,
                                                          child: Text(
                                                            'Mapa Topografico:',
                                                            textAlign: TextAlign.start,
                                                            style: FlutterFlowTheme.of(context)
                                                                .bodyMedium
                                                                .override(
                                                                  fontFamily: 'Readex Pro',
                                                                  color: FlutterFlowTheme.of(context)
                                                                      .primaryText,
                                                                  fontSize: 18,
                                                                ),
                                                          ),
                                                        ),
                                                      ),
                                                      Container(
                                                        height: 2,
                                                      ),
                                                      Padding(
                                                        padding: const EdgeInsets.all(8.0),
                                                        child: Container(
                                                          width: MediaQuery.of(context).size.width,
                                                          child: Text(
                                                            'La imagen muestra un mapa topográfico que utiliza colores para representar diferentes altitudes del terreno. La escala de colores está presente en la parte derecha de la imagen, que va desde la altura mas baja en azul hasta la mas alta en rojo.',
                                                            textAlign: TextAlign.start,
                                                            style: FlutterFlowTheme.of(context)
                                                                .bodyMedium
                                                                .override(
                                                                  fontFamily: 'Readex Pro',
                                                                  color: FlutterFlowTheme.of(context)
                                                                      .primaryText,
                                                                  fontSize: 13,
                                                                ),
                                                          ),
                                                        ),
                                                      ),

                                                      ImagenTopografia(
                                                        urlTopografia: "${snapshot.data!['Topografia']}",
                                                      ),

                                                      SizedBox(
                                                        height: 10,
                                                      ),
                                                      /* if (responsiveVisibility(
                                                            context: context,
                                                            phone: false,
                                                            tablet: false,
                                                          ))
                                                            Container(
                                                                width: MediaQuery.of(context).size.width * 0.7,
                                                                child: Wrap(children: [
                                                                  //snapshot.data!['Campo']
                                                                  InfoContainer(
                                                                      title: 'Observaciones',
                                                                      content:
                                                                          '${snapshot.data!['Observaciones']}'),
                
                                                                  InfoContainer(
                                                                      title: 'Recomendaciones',
                                                                      content:
                                                                          '${snapshot.data!['Recomendaciones']}'),
                                                                ])),
                                                          if (responsiveVisibility(
                                                            context: context,
                                                            desktop: false,
                                                            tabletLandscape: false,
                                                          ))
                                                            Container(
                                                                width: MediaQuery.of(context).size.width * 0.9,
                                                                child: Wrap(children: [
                                                                  //snapshot.data!['Campo']
                                                                  InfoContainer(
                                                                      title: 'Observaciones',
                                                                      content:
                                                                          '${snapshot.data!['Observaciones']}'),
                
                                                                  InfoContainer(
                                                                      title: 'Recomendaciones',
                                                                      content:
                                                                          '${snapshot.data!['Recomendaciones']}'),
                                                                ])) */
                                                    ],
                                                  );
                                                }
                                              });
                                        }
                                      })
                                ].addToEnd(SizedBox(height: 24)),
                              ),
                            ),
                          ),
                        ),
                      )
                    ]));
          }
        });
  }
}

//---AtuGuard
//);

class HomePageModel extends FlutterFlowModel<HomePageWidget> {
  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  // State field(s) for DropDown widget.
  String? dropDownValue;
  FormFieldController<String>? dropDownValueController;
  // State field(s) for RiveAnimation widget.
  final riveAnimationAnimationsList = [
    'Main Loop',
  ];
  List<FlutterFlowRiveController> riveAnimationControllers = [];

  /// Initialization and disposal methods.

  void initState(BuildContext context) {
    riveAnimationAnimationsList.forEach((name) {
      riveAnimationControllers.add(FlutterFlowRiveController(
        name,
      ));
    });
  }

  void dispose() {
    unfocusNode.dispose();
  }

  /// Action blocks are added here.

  /// Additional helper methods are added here.
}

/* 
FlutterFlowDropDown(
                                
                                options: ['NDRE', 'RGB', 'NDVI', 'OSAVI'],
                                onChanged: /* (val) =>
                                      setState(() => _model.dropDownValue = val) */
                                    (val) {},
                                width: 120,
                                height:
                                    MediaQuery.sizeOf(context).height * 0.05,
                                textStyle: FlutterFlowTheme.of(context)
                                    .bodyMedium
                                    .override(
                                      fontFamily: 'Readex Pro',
                                      fontSize: 12,
                                      fontWeight: FontWeight.normal,
                                    ),
                                icon: Icon(
                                  Icons.keyboard_arrow_down_rounded,
                                  color: FlutterFlowTheme.of(context)
                                      .secondaryText,
                                  size: 24,
                                ),
                                fillColor: FlutterFlowTheme.of(context)
                                    .secondaryBackground,
                                elevation: 2,
                                borderColor: Colors.transparent,
                                borderWidth: 1,
                                borderRadius: 8,
                                margin: EdgeInsetsDirectional.fromSTEB(
                                    16, 4, 16, 4),
                                hidesUnderline: true,
                              ), */
