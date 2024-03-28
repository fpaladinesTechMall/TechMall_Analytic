import 'package:flutter/material.dart';
import 'package:flutterflow_ui/flutterflow_ui.dart';

import 'package:techmall_analytic/Site/adm/PagSubirData/FormularioData.dart';
import 'package:techmall_analytic/Site/adm/menuAdmi.dart';

class EnviarDataMap extends StatefulWidget {
  const EnviarDataMap({super.key});

  @override
  State<EnviarDataMap> createState() => _EnviarDataMapState();
}

class _EnviarDataMapState extends State<EnviarDataMap> {
  final scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child:
                Row(mainAxisSize: MainAxisSize.max, crossAxisAlignment: CrossAxisAlignment.start, children: [
      if (responsiveVisibility(
        context: context,
        phone: false,
        tablet: false,
      ))
        MenuWidgetAdm(),
      Expanded(child: FormularioData())
    ])));
  }
}
