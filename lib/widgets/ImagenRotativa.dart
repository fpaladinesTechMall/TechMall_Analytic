import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutterflow_ui/flutterflow_ui.dart';

class ImagenRotativa extends StatefulWidget {
  @override
  _ImagenRotativaState createState() => _ImagenRotativaState();
}

class _ImagenRotativaState extends State<ImagenRotativa> with SingleTickerProviderStateMixin {
  int _currentIndex = 0;
  final List<String> _imageList = [
    'assets/AuthRGB.png',
    'assets/AuthNDVI.png',
    'assets/AuthGNDVI.png',
    'assets/AuthOsavi.png',
    'assets/AuthLCI.png',
  ];
  final List<String> _textTitulo = [
    'RGB',
    'NDVI',
    'GNDVI',
    'OSAVI',
    'LCI',
  ];
  late AnimationController _controller;
  late Animation<double> _animation;
  Timer? _timer; // Declara una variable para el timer

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 1), // Duración de la animación de desvanecimiento
      vsync: this,
    );
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeIn);

    // Iniciar animación al inicio
    _controller.forward();

    _timer = Timer.periodic(Duration(seconds: 15), (timer) {
      // Asegúrate de que el widget todavía esté montado antes de llamar a setState
      if (mounted) {
        setState(() {
          _currentIndex++;
          if (_currentIndex == _imageList.length) _currentIndex = 0;
          _controller.reset();
          _controller.forward();
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FadeTransition(
        opacity: _animation,
        child: Stack(
          children: [
            Image.asset(
              _imageList[_currentIndex],
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
            Positioned(
              top: 0, // Ajusta la posición según necesites
              left: 0, // Ajusta la posición según necesites
              child: Container(
                color: Colors.black,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    _textTitulo[_currentIndex], // Aquí va el texto que quieres mostrar
                    style: FlutterFlowTheme.of(context).headlineMedium.override(
                          fontFamily: 'Outfit',
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
