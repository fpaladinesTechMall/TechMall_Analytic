import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutterflow_ui/flutterflow_ui.dart';
import 'package:techmall_analytic/Color/ColorWidget.dart';

class MenuWidget extends StatelessWidget {
  const MenuWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
            MouseRegion(
              cursor: SystemMouseCursors.click,
              child: GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, "/Dashboard");
                },
                child: Padding(
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
              ),
            ),
            MouseRegion(
              cursor: SystemMouseCursors.click,
              child: GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, "/Historial");
                },
                child: Padding(
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
              ),
            ),
            MouseRegion(
              cursor: SystemMouseCursors.click,
              child: GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, "/Reportes");
                },
                child: Padding(
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
    );
  }
}
