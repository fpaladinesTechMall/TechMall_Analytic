import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:techmall_analytic/Reporte.dart';
import 'package:techmall_analytic/Screens/FormularioIngreso.dart';
import 'package:techmall_analytic/Screens/PruebaSubida.dart';
import 'package:techmall_analytic/Screens/UnKnowbPage.dart';
import 'package:techmall_analytic/Site/historial.dart';
import 'package:techmall_analytic/auth.dart';
import 'package:techmall_analytic/firebase/firebase_options.dart';
import 'package:techmall_analytic/home.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';
import 'package:techmall_analytic/provider/variablesExt.dart';
import 'package:firebase_auth/firebase_auth.dart';

//
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await initializeDateFormatting('es');

  if (kDebugMode) {
    final storageRef = FirebaseStorage.instance.ref();
  }
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => VariablesExt()),
      ],
      child: MaterialApp(
        initialRoute: "/Reportes",
        routes: {
          "/Auth": (context) => AuthWidget(),
          "/Dashboard": (context) => HomePageWidget(),
          "/Historial": (context) => HistorialWidget(),
          "/Reportes": (context) => Reportes(),
        },
        onGenerateRoute: (settings) {
          final user = FirebaseAuth.instance.currentUser;

          // Verifica si el usuario intenta navegar a la página home sin estar autenticado
          if (settings.name == '/Dashboard' && user == null) {
            // Redirige al usuario a la página de inicio de sesión
            return MaterialPageRoute(builder: (context) => AuthWidget());
          }

          // Aquí podrías manejar otras rutas y condiciones según sea necesario
          switch (settings.name) {
            case '/Auth':
              return MaterialPageRoute(builder: (context) => AuthWidget());
            case '/Dashboard':
              return MaterialPageRoute(builder: (context) => HomePageWidget());
            case '/Historial':
              return MaterialPageRoute(builder: (context) => HistorialWidget());
            default:
              // Implementa una página de error o desconocida como fallback
              return MaterialPageRoute(builder: (context) => UnknownPage());
          }
        },

        //HomePageWidget(),
        //FormularioData(),
      ),
    );
  }
}
