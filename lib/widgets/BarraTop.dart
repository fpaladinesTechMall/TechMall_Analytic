import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutterflow_ui/flutterflow_ui.dart';
import 'package:techmall_analytic/Color/ColorWidget.dart';
import 'package:techmall_analytic/firebase/data.dart';
import 'package:techmall_analytic/provider/variablesExt.dart';

import 'package:techmall_analytic/widgets/DropDownCampo.dart';
import 'package:techmall_analytic/widgets/DropDownLote.dart';

import 'package:techmall_analytic/widgets/MenuUsuario.dart';
import 'package:techmall_analytic/widgets/MenuWidget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';

class BarraTop extends StatefulWidget {
  final String titulo;
  const BarraTop({Key? key, required this.titulo}) : super(key: key);

  @override
  State<BarraTop> createState() => _BarraTopState();
}

class _BarraTopState extends State<BarraTop> {
  @override
  Widget build(BuildContext context) {
    print("");
    var provider = Provider.of<VariablesExt>(context, listen: true);

    return Expanded(
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
              widget.titulo,
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
            GestureDetector(
              onTap: () {},
              child: Icon(
                Icons.menu,
                color: FlutterFlowTheme.of(context).secondaryText,
                size: 24,
              ),
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
                    correodata: provider.correo,
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
          Spacer(),
          MenuUsuario(),
        ],
      ),
    );
  }
}
