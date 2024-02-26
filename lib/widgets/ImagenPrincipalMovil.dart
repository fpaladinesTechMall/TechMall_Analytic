import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:html' as html;

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:techmall_analytic/Color/ColorWidget.dart';
import 'package:techmall_analytic/provider/variablesExt.dart';

class ImagenHomePrincipalMOVIL extends StatelessWidget {
  final String urlRGB;
  const ImagenHomePrincipalMOVIL({
    super.key,
    required this.urlRGB,
  });

  @override
  Widget build(BuildContext context) {
    var storageRef = FirebaseStorage.instance.ref().child(urlRGB).getDownloadURL();

    return FutureBuilder<String>(
      future: storageRef,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (!snapshot.hasData || snapshot.data == null) {
          return Text('No hay URL de imagen disponible.');
        } else {
          return ImagenCentro(titulo: 'RGB', url: snapshot.data.toString());
        }
      },
    );
  }
}

class ImagenCentro extends StatefulWidget {
  final String titulo;
  final String url;
  const ImagenCentro({super.key, required this.url, required this.titulo});

  @override
  State<ImagenCentro> createState() => _ImagenCentroState();
}

class _ImagenCentroState extends State<ImagenCentro> {
  late TransformationController _transformationController;
  late InteractiveViewer _interactiveViewer;
  String dropdownValue = 'RGB';

  @override
  void initState() {
    super.initState();
    _transformationController = TransformationController();
  }

  void _zoomIn() {
    _transformationController.value *= Matrix4.diagonal3Values(1.2, 1.2, 1);
  }

  void _zoomOut() {
    _transformationController.value *= Matrix4.diagonal3Values(0.8, 0.8, 1);
  }

  void _downloadImage() async {
    // Obtener los bytes de la imagen
    final html.AnchorElement anchor = html.AnchorElement(href: widget.url);
    anchor.setAttribute("download", "RGB.png");
    anchor.click();
  }

  @override
  Widget build(BuildContext context) {
    String modifiedUrl = widget.url.replaceAll('RGB', dropdownValue);

    // Crea el InteractiveViewer en cada build con la nueva imagen.
    _interactiveViewer = InteractiveViewer(
      transformationController: _transformationController,
      boundaryMargin: EdgeInsets.all(double.infinity),
      minScale: 0.125,
      maxScale: 20,
      constrained: true,
      child: Image.network(
        height: 500,
        width: 500,
        modifiedUrl, // Usar la URL modificada
        fit: BoxFit.contain,
      ),
    );

    return Stack(
      children: [
        _interactiveViewer,
        Positioned(
          top: 16.0,
          left: 16.0,
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: 8.0,
            ),
            decoration: BoxDecoration(
              color: AppColors.colorFondoTech(), // Color de fondo morado
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                DropdownButtonHideUnderline(
                    child: Theme(
                  data: Theme.of(context).copyWith(
                    canvasColor: AppColors.colorFondoTech(), // Aquí defines el color del recuadro desplegable
                  ),
                  child: DropdownButton<String>(
                    value: dropdownValue, // Debes definir esta variable
                    icon: Icon(Icons.arrow_drop_down, color: Colors.white),
                    iconSize: 24,
                    elevation: 4,

                    underline: Container(), // Container vacío para quitar el subrayado

                    style: TextStyle(
                      color: Colors.white, // Color del texto blanco
                      fontWeight: FontWeight.bold,
                    ),

                    onChanged: (newValue) {
                      setState(() {
                        dropdownValue = newValue!;
                        _interactiveViewer.onInteractionUpdate;
                      });
                    },
                    items: <String>['RGB', 'NDVI', 'GNVI', 'LCI', 'OSAVI']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                        ),
                      );
                    }).toList(),
                  ),
                )),
              ],
            ),
          ),
        ),
        Positioned(
          bottom: 16.0,
          right: 16.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ElevatedButton(
                onPressed: _zoomIn,
                child: Icon(Icons.zoom_in, color: AppColors.colorFondoTech()),
              ),
              SizedBox(width: 20.0),
              ElevatedButton(
                onPressed: _zoomOut,
                child: Icon(Icons.zoom_out, color: AppColors.colorFondoTech()),
              ),
              SizedBox(width: 20.0),
              ElevatedButton(
                onPressed: () {
                  final html.AnchorElement anchor = html.AnchorElement(href: modifiedUrl);
                  anchor.setAttribute("download", "$dropdownValue.png");
                  anchor.click();
                },
                child: Icon(Icons.download, color: AppColors.colorFondoTech()),
              )
            ],
          ),
        ),
      ],
    );
  }
}
