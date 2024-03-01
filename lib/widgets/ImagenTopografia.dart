import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:techmall_analytic/Color/ColorWidget.dart';

class ImagenTopografia extends StatelessWidget {
  final String urlTopografia;
  const ImagenTopografia({
    super.key,
    required this.urlTopografia,
  });

  @override
  Widget build(BuildContext context) {
    var storageRefPie = FirebaseStorage.instance.ref().child(urlTopografia).getDownloadURL();
    return Wrap(
      spacing: 10, // Espacio horizontal entre los elementos
      runSpacing: 10, // Espacio vertical entre los elementos
      children: <Widget>[
        FutureBuilder<String>(
            future: storageRefPie,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else if (!snapshot.hasData || snapshot.data == null) {
                return Text('No hay URL de imagen disponible.');
              } else {
                return Container(
                  width: 500,
                  height: 500,
                  child: Stack(
                    children: [
                      Center(
                        child: Container(
                          width: 500,
                          height: 500,
                          decoration: BoxDecoration(
                            // Color de fondo
                            borderRadius: BorderRadius.circular(15), // Bordes redondos
                            image: DecorationImage(
                              image: NetworkImage(snapshot.data.toString()), // Primera imagen
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 10,
                        top: 20,
                        child: Container(
                          padding: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color:
                                AppColors.colorFondoTech(), // Fondo del cuadro, puedes cambiarlo a tu gusto
                            borderRadius: BorderRadius.circular(10), // Bordes redondeados
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                spreadRadius: 5,
                                blurRadius: 7,
                                offset: Offset(0, 3), // Cambia la sombra a tu gusto
                              ),
                            ],
                          ),
                          child: Text(
                            'Topografia',
                            style: TextStyle(
                              color: Colors.white, // Color del texto, cambia a tu gusto
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }
            }),
      ],
    );
  }
}
