import 'package:flutter/material.dart';

class UnknownPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Página no encontrada'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              Icons.error_outline,
              color: Colors.red,
              size: 100,
            ),
            Text(
              '404',
              style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Text(
              'Lo sentimos, la página que buscas no existe.',
              style: TextStyle(fontSize: 18),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Navegar de regreso a la página principal o de inicio
                Navigator.of(context).pop();
              },
              child: Text('Volver'),
            ),
          ],
        ),
      ),
    );
  }
}
