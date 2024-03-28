import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:html' as html;
import 'package:provider/provider.dart';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:techmall_analytic/Color/ColorWidget.dart';
import 'package:path_provider/path_provider.dart';
import 'package:techmall_analytic/provider/variablesExt.dart';

class ImagenHomePrincipalWeb extends StatelessWidget {
  final String urlRGB;
  final String urlNDVI;
  const ImagenHomePrincipalWeb({
    super.key,
    required this.urlRGB,
    required this.urlNDVI,
  });

  @override
  Widget build(BuildContext context) {
    var ancho = MediaQuery.sizeOf(context).width;
    var alto = MediaQuery.sizeOf(context).height;
    var storageRefNDVI = FirebaseStorage.instance.ref().child(urlNDVI).getDownloadURL();
    var storageRefRGB = FirebaseStorage.instance.ref().child(urlRGB).getDownloadURL();

    return Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: alto * 0.5,
            width: ancho * 0.35,
            child: FutureBuilder<String>(
              future: storageRefRGB,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else if (!snapshot.hasData || snapshot.data == null) {
                  return Text('No hay URL de imagen disponible.');
                } else {
                  return ImagenCentro(
                    url: snapshot.data.toString(),
                    titulo: 'RGB',
                  );
                }
              },
            ),
          ),
          SizedBox(width: ancho * 0.02),
          Container(
            height: alto * 0.5,
            width: ancho * 0.35,
            child: FutureBuilder<String>(
              future: storageRefNDVI,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else if (!snapshot.hasData || snapshot.data == null) {
                  return Text('No hay URL de imagen disponible.');
                } else {
                  return ImagenCentroDesplegable(
                    url: snapshot.data.toString(),
                    titulo: 'NDVI',
                  );
                }
              },
            ),
          ),
        ],
      ),
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

  @override
  void initState() {
    super.initState();
    _transformationController = TransformationController();
    _interactiveViewer = InteractiveViewer(
      transformationController: _transformationController,
      boundaryMargin: EdgeInsets.all(double.infinity),
      minScale: 0.125,
      maxScale: 20,
      constrained: true,
      child: Image.network(
        height: 500,
        width: 600,
        widget.url, // Replace with your image URL
        fit: BoxFit.contain,
      ),
    );
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

  void _showImageInLargeView() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // Crear un nuevo TransformationController para el diálogo
        final TransformationController controller = TransformationController();

        return Dialog(
          child: InteractiveViewer(
            transformationController: controller,
            boundaryMargin: EdgeInsets.all(20.0),
            minScale: 0.1,
            maxScale: 4.0,
            child: Container(
              child: Image.network(
                widget.url,
                fit: BoxFit.contain,
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        _interactiveViewer,
        Positioned(
          top: 16.0,
          left: 16.0,
          child: Container(
            padding: EdgeInsets.all(12.0),
            decoration: BoxDecoration(
              color: AppColors.colorFondoTech(), // Color de fondo morado
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Text(
              widget.titulo,
              style: TextStyle(
                color: Colors.white, // Color del texto blanco
                fontWeight: FontWeight.bold,
              ),
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
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.colorFondoTech(), // Color de fondo del botón
                ),
                child: Icon(
                  Icons.zoom_in,
                  color: Colors.white,
                ),
              ),
              SizedBox(width: 20.0),
              ElevatedButton(
                onPressed: _zoomOut,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.colorFondoTech(), // Color de fondo del botón
                ),
                child: Icon(Icons.zoom_out, color: Colors.white),
              ),
              SizedBox(width: 20.0),
              ElevatedButton(
                onPressed: _downloadImage,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.colorFondoTech(), // Color de fondo del botón
                ),
                child: Icon(
                  Icons.download,
                  color: Colors.white,
                ),
              ),
              SizedBox(width: 20.0),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.colorFondoTech(), // Color de fondo del botón
                ),
                onPressed: _showImageInLargeView,
                child: Icon(Icons.aspect_ratio, color: Colors.white),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class ImagenCentroDesplegable extends StatefulWidget {
  final String titulo;
  final String url;
  const ImagenCentroDesplegable({super.key, required this.url, required this.titulo});

  @override
  State<ImagenCentroDesplegable> createState() => _ImagenCentroDesplegableState();
}

class _ImagenCentroDesplegableState extends State<ImagenCentroDesplegable> {
  late TransformationController _transformationController;
  late InteractiveViewer _interactiveViewer;
  String dropdownValue = 'NDVI';

  @override
  void initState() {
    super.initState();
    _transformationController = TransformationController();
    // No pongas tu InteractiveViewer aquí, lo moveremos al método build.
  }

  void _zoomIn() {
    _transformationController.value *= Matrix4.diagonal3Values(1.2, 1.2, 1);
  }

  void _zoomOut() {
    _transformationController.value *= Matrix4.diagonal3Values(0.8, 0.8, 1);
  }

  void _showTextInputDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Indices multiespectrales'),
          content: const Text(
              "NDVI:Este índice es la relación de la diferencia entre la reflectancia de una banda de infrarrojo cercano y una banda rojo a su suma. Es el indicador más utilizado para el contenido de clorofila en la vegetación y refleka la salud de la vegetación. Se utilizar para monitorizar el crecimiento y la cobertura de la vegetación.\n"
              "Fórmula: NDVI=(NIR-Rojo)/(NIR+Rojo)\n\n"
              "GNDVI: Este índice utiliza una banda verde para reemplazar la banda roja utilizada en NDVI. Mide el verde la superficie, que es un indicador de la cobertura de la aspesura de vegetación. GNDVI puede monitorizar la recesión de biomasa causada por la escasez de agua, la deficiencia de nutrientes o la maduración.\n"
              "Fórmula: GNDVI=(NIR-verde)/(NIR+verde)\n\n"
              "NDRE: Este índice utiliza una banda de borde rojo para reemplazar la banda roja utilizada en NDVI. La banda del borde rojo es una región espectral que se encuentra en la zona de transición entre la luz roja e infrarroja cercana. con NDRE, el usuario puede gestionar la siembra en función de variables como el contenido de clorofila y azúcar.\n"
              "Fórmula: NDRE=(NIR-RedEdge)/(NIR+RedEdge)\n\n"
              "LCI: El contenido de clorofila en las hojas es un índice importante para evaluar el crecimiento y producción de la vegetación. Es un indicador de estrés, enfermedades, crecimiento y envejecimiento de los nutrientes de las plantas.\n"
              "Fórmula: LCI=(NIR-RedEdge)/(NIR+Red)\n\n"
              "OSAVI: Este índice es un índice de vegetación ajustado al suelo, basado en NDVI y otros datos de observación relevantes. Este índice elimina el impacto de la condiciones del suelo en los índices de vegetación.\n"
              "Fórmula: OSACI=(NIR-Red)/(NIR+Red+0.16)\n\n"),
          actions: <Widget>[
            TextButton(
              child: Text('Cerrar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<VariablesExt>(context, listen: true);
    var ancho = MediaQuery.sizeOf(context).width;
    var alto = MediaQuery.sizeOf(context).height;
    // Crea la URL modificada en cada build, asegurándote de que la nueva imagen se cargue cuando cambie dropdownValue.
    String modifiedUrl = widget.url.replaceAll('NDVI', dropdownValue);

    // Crea el InteractiveViewer en cada build con la nueva imagen.
    _interactiveViewer = InteractiveViewer(
      transformationController: _transformationController,
      boundaryMargin: EdgeInsets.all(double.infinity),
      minScale: 0.125,
      maxScale: 20,
      constrained: true,
      child: Image.network(
        height: 500,
        width: 600,
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
                        //provider.setindice(newValue!);
                        dropdownValue = newValue!;
                        _interactiveViewer.onInteractionUpdate;
                      });
                    },
                    items: <String>['NDVI', 'GNVI', 'LCI', 'OSAVI']
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
          right: 0,
          top: 0,
          child: SafeArea(
            child: IconButton(
              icon: Icon(Icons.question_mark),
              onPressed: () => _showTextInputDialog(context),
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
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.colorFondoTech(), // Color de fondo del botón
                ),
                child: Icon(
                  Icons.zoom_in,
                  color: Colors.white,
                ),
              ),
              SizedBox(width: 20.0),
              ElevatedButton(
                onPressed: _zoomOut,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.colorFondoTech(), // Color de fondo del botón
                ),
                child: Icon(Icons.zoom_out, color: Colors.white),
              ),
              SizedBox(width: 20.0),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.colorFondoTech(), // Color de fondo del botón
                ),
                onPressed: () {
                  final html.AnchorElement anchor = html.AnchorElement(href: modifiedUrl);
                  anchor.setAttribute("download", "$dropdownValue.png");
                  anchor.click();
                },
                child: Icon(
                  Icons.download,
                  color: Colors.white,
                ),
              ),
              SizedBox(width: 20.0),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.colorFondoTech(), // Color de fondo del botón
                ),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      // Crear un nuevo TransformationController para el diálogo
                      final TransformationController controller = TransformationController();

                      return Dialog(
                        child: InteractiveViewer(
                          transformationController: controller,
                          boundaryMargin: EdgeInsets.all(20.0),
                          minScale: 0.1,
                          maxScale: 4.0,
                          child: Image.network(
                            modifiedUrl,
                            fit: BoxFit.contain,
                          ),
                        ),
                      );
                    },
                  );
                },
                child: Icon(Icons.aspect_ratio, color: Colors.white),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
