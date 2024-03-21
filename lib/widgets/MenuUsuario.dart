import 'package:flutter/material.dart';
import 'package:flutterflow_ui/flutterflow_ui.dart';

class MenuUsuario extends StatefulWidget {
  const MenuUsuario({super.key});

  @override
  State<MenuUsuario> createState() => _MenuUsuarioState();
}

class _MenuUsuarioState extends State<MenuUsuario> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min, // Importante para evitar que el Row ocupe más espacio del necesario
      children: [
        CircleAvatar(
          backgroundColor: Colors.white,
          backgroundImage: NetworkImage(
              'https://lapi.com.mx/web/image/product.template/5449/image_1024?unique=580e042'), // Reemplaza con la URL de tu imagen
          radius: 20.0,
        ),
        SizedBox(width: 10),
        if (responsiveVisibility(
          context: context,
          phone: false,
          tablet: false,
        ))
          Text(
            'Maria Fernanda Quintana',
            style: FlutterFlowTheme.of(context).bodyMedium.override(
                  fontFamily: 'Readex Pro',
                  color: FlutterFlowTheme.of(context).primaryText,
                  fontSize: 14,
                ),
          ), // Espacio entre la imagen y el texto
        // Reemplaza con el nombre de tu usuario
        SizedBox(width: 10), // Espacio entre el texto y el icono
        PopupMenuButton(
          onSelected: (value) {
            // Acción al seleccionar una opción
            if (value == 'logout') {
              // Implementa la funcionalidad de cerrar sesión aquí
              print('Cerrar sesión');
            }
          },
          itemBuilder: (BuildContext context) => <PopupMenuEntry>[
            const PopupMenuItem(
              value: 'logout',
              child: Text('Cerrar sesión'),
            ),
          ],
          icon: Icon(Icons.more_vert), // Icono de menú
        ),
      ],
    );
  }
}
