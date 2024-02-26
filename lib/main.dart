import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:techmall_analytic/Screens/FormularioIngreso.dart';
import 'package:techmall_analytic/Screens/PruebaSubida.dart';
import 'package:techmall_analytic/auth.dart';
import 'package:techmall_analytic/firebase/firebase_options.dart';
import 'package:techmall_analytic/home.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';
import 'package:techmall_analytic/provider/variablesExt.dart';

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
        initialRoute: "/Auth",
        routes: {
          "/Auth": (context) => AuthWidget(),
          "/Dashboard": (context) => HomePageWidget(),
        },

        //HomePageWidget(),
        //FormularioData(),
      ),
    );
  }
}
