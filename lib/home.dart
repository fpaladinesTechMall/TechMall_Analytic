import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutterflow_ui/flutterflow_ui.dart';
import 'package:techmall_analytic/Color/ColorWidget.dart';
import 'package:techmall_analytic/firebase/data.dart';
import 'package:techmall_analytic/provider/variablesExt.dart';
import 'package:techmall_analytic/widgets/DatosContainer.dart';
import 'package:techmall_analytic/widgets/DropDownCampo.dart';
import 'package:techmall_analytic/widgets/DropDownLote.dart';
import 'package:techmall_analytic/widgets/ImagenEstadistica.dart';
import 'package:techmall_analytic/widgets/ImagenPrincipalMovil.dart';
import 'package:techmall_analytic/widgets/ImagenPrincipalWeb.dart';
import 'package:techmall_analytic/widgets/textfirebasehome.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';

class HomePageWidget extends StatefulWidget {
  const HomePageWidget({Key? key}) : super(key: key);

  @override
  _HomePageWidgetState createState() => _HomePageWidgetState();
}

class _HomePageWidgetState extends State<HomePageWidget> with TickerProviderStateMixin {
  late HomePageModel _model;
  String correo = "GonzaloQuintana@techmall.com";
  String loteInicial = "";

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
    return Scaffold(
        key: scaffoldKey,
        backgroundColor: Colors.white,
        body: Row(mainAxisSize: MainAxisSize.max, crossAxisAlignment: CrossAxisAlignment.start, children: [
          if (responsiveVisibility(
            context: context,
            phone: false,
            tablet: false,
          ))
            Container(
              width: 270,
              height: double.infinity,
              decoration: BoxDecoration(
                color: AppColors.colorFondoTech().withOpacity(0.96),
                boxShadow: [
                  BoxShadow(
                    blurRadius: 0,
                    color: Color(0xFFE5E7EB),
                    offset: Offset(1, 0),
                  )
                ],
                borderRadius: BorderRadius.circular(0),
              ),
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 16),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 24),
                      child: Container(
                        width: double.infinity,
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Container(
                              height: 20,
                            ),
                            Center(
                              child: Container(
                                height: 50,
                                child: Image.asset('assets/LogoBlanco.png'),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(16, 0, 0, 0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(12, 0, 0, 0),
                                    child: Text(
                                      'TechMall Analytic',
                                      style: FlutterFlowTheme.of(context).headlineMedium.override(
                                            fontFamily: 'Outfit',
                                            color: Colors.white,
                                            fontSize: 24,
                                            fontWeight: FontWeight.w500,
                                          ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(16, 0, 16, 12),
                      child: Container(
                        width: double.infinity,
                        height: 50,
                        decoration: BoxDecoration(
                          color: AppColors.colorFondoTech(),
                          borderRadius: BorderRadius.circular(12),
                          shape: BoxShape.rectangle,
                          border: Border.all(
                            color: AppColors.colorFondoTech(),
                            width: 1,
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(12, 0, 12, 0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(0, 12, 12, 12),
                                child: Container(
                                  width: 4,
                                  height: 100,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                              ),
                              if (responsiveVisibility(
                                context: context,
                                phone: false,
                                tablet: false,
                              ))
                                Icon(
                                  Icons.stacked_bar_chart_rounded,
                                  color: Colors.white,
                                  size: 28,
                                ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(12, 0, 0, 0),
                                child: Text(
                                  'Dashboard',
                                  style: FlutterFlowTheme.of(context).titleSmall.override(
                                        fontFamily: 'Plus Jakarta Sans',
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(16, 0, 16, 12),
                      child: Container(
                        width: double.infinity,
                        height: 50,
                        decoration: BoxDecoration(
                          color: AppColors.colorFondoTech(),
                          borderRadius: BorderRadius.circular(12),
                          shape: BoxShape.rectangle,
                        ),
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(12, 0, 12, 0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(0, 12, 12, 12),
                                child: Container(
                                  width: 4,
                                  height: 100,
                                  decoration: BoxDecoration(
                                    color: Color(0x4D9489F5),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                              ),
                              Icon(
                                Icons.stacked_line_chart_rounded,
                                color: Colors.white,
                                size: 28,
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(12, 0, 0, 0),
                                child: Text(
                                  'Historial',
                                  style: FlutterFlowTheme.of(context).labelMedium.override(
                                        fontFamily: 'Plus Jakarta Sans',
                                        color: Colors.white,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                      ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(16, 0, 16, 12),
                      child: Container(
                        width: double.infinity,
                        height: 50,
                        decoration: BoxDecoration(
                          color: AppColors.colorFondoTech(),
                          borderRadius: BorderRadius.circular(12),
                          shape: BoxShape.rectangle,
                        ),
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(12, 0, 12, 0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(0, 12, 12, 12),
                                child: Container(
                                  width: 4,
                                  height: 100,
                                  decoration: BoxDecoration(
                                    color: Color(0x4D9489F5),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                              ),
                              Icon(
                                Icons.donut_small_rounded,
                                color: Colors.white,
                                size: 28,
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(12, 0, 0, 0),
                                child: Text(
                                  'Reporte',
                                  style: FlutterFlowTheme.of(context).labelMedium.override(
                                        fontFamily: 'Plus Jakarta Sans',
                                        color: Colors.white,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                      ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(16, 0, 16, 12),
                      child: Container(
                        width: double.infinity,
                        height: 50,
                        decoration: BoxDecoration(
                          color: AppColors.colorFondoTech().withOpacity(0.5),
                          borderRadius: BorderRadius.circular(12),
                          shape: BoxShape.rectangle,
                        ),
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(12, 0, 12, 0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(0, 12, 12, 12),
                                child: Container(
                                  width: 4,
                                  height: 100,
                                  decoration: BoxDecoration(
                                    color: Color(0x4D9489F5),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                              ),
                              Icon(
                                Icons.groups,
                                color: Colors.white,
                                size: 28,
                              ),
                              Padding(
                                padding: EdgeInsetsDirectional.fromSTEB(12, 0, 0, 0),
                                child: Text(
                                  'información',
                                  style: FlutterFlowTheme.of(context).titleSmall.override(
                                        fontFamily: 'Plus Jakarta Sans',
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(16, 0, 16, 16),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Divider(
                              height: 12,
                              thickness: 2,
                              color: Color(0x4D9489F5),
                            ),
                            Padding(
                              padding: EdgeInsetsDirectional.fromSTEB(0, 0, 12, 0),
                              child: Container(
                                width: 80,
                                height: 40,
                                decoration: BoxDecoration(
                                  color: Color(0x4D9489F5),
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(
                                    color: Color(0x4D9489F5),
                                    width: 1,
                                  ),
                                ),
                                child: Padding(
                                  padding: EdgeInsets.all(2),
                                  child: Stack(
                                    alignment: AlignmentDirectional(0, 0),
                                    children: [
                                      Align(
                                        alignment: AlignmentDirectional(-0.9, 0),
                                        child: Padding(
                                          padding: EdgeInsetsDirectional.fromSTEB(6, 0, 0, 0),
                                          child: Icon(
                                            Icons.wb_sunny_rounded,
                                            color: Colors.white,
                                            size: 24,
                                          ),
                                        ),
                                      ),
                                      Align(
                                        alignment: AlignmentDirectional(1, 0),
                                        child: Padding(
                                          padding: EdgeInsetsDirectional.fromSTEB(0, 0, 6, 0),
                                          child: Icon(
                                            Icons.mode_night_rounded,
                                            color: Colors.white,
                                            size: 24,
                                          ),
                                        ),
                                      ),
                                      Align(
                                          alignment: AlignmentDirectional(1, 0),
                                          child: Container(
                                            width: 36,
                                            height: 36,
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              boxShadow: [
                                                BoxShadow(
                                                  blurRadius: 4,
                                                  color: Color(0x430B0D0F),
                                                  offset: Offset(0, 2),
                                                )
                                              ],
                                              borderRadius: BorderRadius.circular(30),
                                              shape: BoxShape.rectangle,
                                            ),
                                          )),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ].divide(SizedBox(height: 12)),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          FutureBuilder(
              future: obtenerDataUsuario(correo),
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

                  return Expanded(
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
                                    Expanded(
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Align(
                                            alignment: AlignmentDirectional(0, 0),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.max,
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                if (responsiveVisibility(
                                                  context: context,
                                                  phone: false,
                                                  tablet: false,
                                                ))
                                                  Text(
                                                    "Mapas Multiespectrales",
                                                    textAlign: TextAlign.start,
                                                    style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                          fontFamily: 'Readex Pro',
                                                          color: FlutterFlowTheme.of(context).primaryText,
                                                          fontSize: 20,
                                                        ),
                                                  ),
                                                if (responsiveVisibility(
                                                  context: context,
                                                  tabletLandscape: false,
                                                  desktop: false,
                                                ))
                                                  Icon(
                                                    Icons.menu,
                                                    color: FlutterFlowTheme.of(context).secondaryText,
                                                    size: 24,
                                                  ),
                                                VerticalDivider(
                                                  thickness: 1,
                                                  color: FlutterFlowTheme.of(context).secondaryText,
                                                ),
                                                SizedBox(
                                                  height: 22,
                                                  child: VerticalDivider(
                                                    thickness: 1,
                                                    color: FlutterFlowTheme.of(context).secondaryText,
                                                  ),
                                                ),
                                                Stack(
                                                  children: [
                                                    Text(
                                                      'Campo:',
                                                      textAlign: TextAlign.start,
                                                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                            fontFamily: 'Readex Pro',
                                                            color: FlutterFlowTheme.of(context).secondaryText,
                                                            fontSize: 13,
                                                          ),
                                                    ),
                                                    Column(
                                                      mainAxisSize: MainAxisSize.max,
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        SizedBox(
                                                          height: 6,
                                                        ),
                                                        CampoWidget(
                                                          campoInicial: provider.hacienda,
                                                        ),
                                                      ],
                                                    )
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 22,
                                                  child: VerticalDivider(
                                                    thickness: 1,
                                                    color: FlutterFlowTheme.of(context).secondaryText,
                                                  ),
                                                ),
                                                Stack(
                                                  children: [
                                                    Text(
                                                      'Lote:',
                                                      textAlign: TextAlign.start,
                                                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                            fontFamily: 'Readex Pro',
                                                            color: FlutterFlowTheme.of(context).secondaryText,
                                                            fontSize: 13,
                                                          ),
                                                    ),
                                                    Column(
                                                      mainAxisSize: MainAxisSize.max,
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        SizedBox(
                                                          height: 6,
                                                        ),
                                                        LoteWidget(
                                                          loteInicial: provider.lote,
                                                        ),
                                                      ],
                                                    )
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              FutureBuilder<List<String>>(
                                  future: obtenerDocumentosDeSubcoleccion(
                                      provider.correo, provider.hacienda, provider.lote),
                                  builder: (BuildContext context, AsyncSnapshot<List<String>> snapshotRuta) {
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
                                                    width: 400,
                                                    height: 10,
                                                    decoration: BoxDecoration(),
                                                  ),
                                                  //Fecha desplegable--------------------
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
                                                                  fontSize: 15,
                                                                ),
                                                          ),
                                                        ),
                                                        Container(
                                                          width: MediaQuery.sizeOf(context).width * 0.02,
                                                        ),
                                                        Container(
                                                          width: MediaQuery.sizeOf(context).width * 0.55,
                                                          height: MediaQuery.sizeOf(context).height * 0.06,
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
                                                    width: MediaQuery.of(context).size.width * 0.7,
                                                    margin: EdgeInsets.symmetric(
                                                        vertical: 5), // Espaciado vertical
                                                    child: Divider(
                                                      color:
                                                          AppColors.colorFondoTech(), // Color del separador
                                                      height: 0.5, // Altura del contenedor del separador
                                                    ),
                                                  ),
                                                  Container(
                                                    height: 30,
                                                  ),
                                                  Container(
                                                    width: MediaQuery.of(context).size.width * 0.7,
                                                    child: Text(
                                                      'Datos obtenidos en el monitoreo',
                                                      textAlign: TextAlign.start,
                                                      style: FlutterFlowTheme.of(context).bodyMedium.override(
                                                            fontFamily: 'Readex Pro',
                                                            color: FlutterFlowTheme.of(context).primaryText,
                                                            fontSize: 18,
                                                          ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  Container(
                                                    width: MediaQuery.of(context).size.width * 0.7,
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
                                                            content: '${snapshot.data!['FechaDeSiembra']}'),
                                                        InfoContainer(
                                                            title: 'Hectareas',
                                                            content: '${snapshot.data!['Hectareas']}'),
                                                        InfoContainer(
                                                            title: 'Porcentaje NDVI',
                                                            content: '${snapshot.data!['Porcentaje NDVI']}'),
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
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  Container(
                                                      width: MediaQuery.of(context).size.width * 0.7,
                                                      child: Wrap(children: [
                                                        //snapshot.data!['Campo']
                                                        InfoContainer(
                                                            title: 'Observaciones',
                                                            content: '${snapshot.data!['Observaciones']}'),
                                                        InfoContainer(
                                                            title: 'Recomendaciones',
                                                            content: '${snapshot.data!['Recomendaciones']}'),
                                                      ]))
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
                  );
                }
              })
        ]));
  }
}

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