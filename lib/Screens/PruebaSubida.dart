import 'dart:html' as html;
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:path/path.dart' as p;
import 'package:flutter/material.dart';
import 'package:flutterflow_ui/flutterflow_ui.dart';
import 'package:techmall_analytic/Screens/ShowDialog.dart';
import 'package:techmall_analytic/firebase/SubirDatos.dart';

class FormularioData extends StatefulWidget {
  @override
  State<FormularioData> createState() => _FormularioDataState();
}

class _FormularioDataState extends State<FormularioData> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Firebase Storage Example',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _fieldController = TextEditingController();
  final _lotController = TextEditingController();
  final _cropTypeController = TextEditingController();
  final _ownerController = TextEditingController();
  final _datecontroller = TextEditingController();
  bool mostrarCarga = false;
  String textoCargo = "NDVI";
  double _uploadProgress = 0;
  html.File? _selectedFileRGB;
  html.File? _selectedFileNDVI;
  html.File? _selectedFileGNDVI;
  html.File? _selectedFileLCI;
  html.File? _selectedFileNDRE;
  html.File? _selectedFileOSAVI;

  @override
  void initState() {
    super.initState();
    // Establecer la fecha actual como valor inicial
    _datecontroller.text = DateFormat('dd-MM-yyyy').format(DateTime.now());
  }

  @override
  void dispose() {
    _datecontroller.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != DateTime.now()) {
      setState(() {
        _datecontroller.text = DateFormat('dd-MM-yyyy').format(picked);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: Size(360, 690));

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(124, 255, 255, 255),
        flexibleSpace: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            return Container(
              height: kToolbarHeight,
              child: Image.asset(
                'assets/TechMallAnaliticLogo.png', // reemplaza 'assets/logo.png' con la ruta de tu imagen local
                height: constraints.biggest.height,
              ),
            );
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Stack(
            children: [
              Padding(
                padding: EdgeInsets.all(25.w),
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        'Llenar información de lote',
                        style:
                            FlutterFlowTheme.of(context).labelMedium.override(
                                  fontFamily: 'Plus Jakarta Sans',
                                  color: Colors.black54,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.0),
                      child: Divider(
                        color:
                            Colors.black54, // Cambia el color si es necesario
                        thickness: 0.7, // Ajusta el grosor de la línea
                      ),
                    ),
                    TextFormField(
                      controller: _emailController,
                      decoration: const InputDecoration(
                        labelText: 'Correo',
                        labelStyle: TextStyle(color: Colors.grey),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromARGB(127, 158, 158, 158)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromARGB(127, 158, 158, 158)),
                        ),
                      ),
                      validator: (value) {
                        if (value!.isEmpty || !value.contains('@')) {
                          return 'Porfavor ingresa un correo valido';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    TextFormField(
                      controller: _datecontroller,
                      readOnly: true,
                      decoration: InputDecoration(
                        hintText: 'Fecha del Monitoreo',
                        labelStyle: TextStyle(color: Colors.grey),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromARGB(127, 158, 158, 158)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromARGB(127, 158, 158, 158)),
                        ),
                        suffixIcon: Icon(Icons.calendar_today),
                      ),
                      onTap: () => _selectDate(context),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    TextFormField(
                      controller: _fieldController,
                      decoration: const InputDecoration(
                        labelText: 'Campo',
                        labelStyle: TextStyle(color: Colors.grey),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromARGB(127, 158, 158, 158)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromARGB(127, 158, 158, 158)),
                        ),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Porfavor ingresa un Campo';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    TextFormField(
                      controller: _lotController,
                      decoration: const InputDecoration(
                        labelText: 'Lote',
                        labelStyle: TextStyle(color: Colors.grey),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromARGB(127, 158, 158, 158)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromARGB(127, 158, 158, 158)),
                        ),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Porfavor ingresa un lote';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    TextFormField(
                      controller: _cropTypeController,
                      decoration: const InputDecoration(
                        labelText: 'Tipo de Cultivo',
                        labelStyle: TextStyle(color: Colors.grey),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromARGB(127, 158, 158, 158)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromARGB(127, 158, 158, 158)),
                        ),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Porfavor ingresa un cultivo';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    TextFormField(
                      controller: _ownerController,
                      decoration: InputDecoration(
                        labelText: 'Propietario',
                        labelStyle: TextStyle(color: Colors.grey),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromARGB(127, 158, 158, 158)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Color.fromARGB(127, 158, 158, 158)),
                        ),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Porfavor ingresa un propietario';
                        }
                        return null;
                      },
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        'Subir imágenes espectrales',
                        style:
                            FlutterFlowTheme.of(context).labelMedium.override(
                                  fontFamily: 'Plus Jakarta Sans',
                                  color: Colors.black54,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.0),
                      child: Divider(
                        color:
                            Colors.black54, // Cambia el color si es necesario
                        thickness: 0.7, // Ajusta el grosor de la línea
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text('Subir RGB'),
                              _selectedFileRGB != null
                                  ? Text('Image selected')
                                  : Text('No image selected'),
                            ],
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.cloud_upload),
                          onPressed: () async {
                            html.InputElement uploadInput = html.InputElement()
                              ..type = 'file';
                            uploadInput.click();
                            uploadInput.onChange.listen((event) {
                              final file = uploadInput.files!.first;
                              setState(() {
                                _selectedFileRGB =
                                    file; // Guarda el archivo seleccionado
                              });
                            });
                            ;
                          },
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text('Subir NDVI'),
                              _selectedFileNDVI != null
                                  ? Text('Image selected')
                                  : Text('No image selected'),
                            ],
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.cloud_upload),
                          onPressed: () async {
                            html.InputElement uploadInput = html.InputElement()
                              ..type = 'file';
                            uploadInput.click();
                            uploadInput.onChange.listen((event) {
                              final file = uploadInput.files!.first;
                              setState(() {
                                _selectedFileNDVI =
                                    file; // Guarda el archivo seleccionado
                              });
                            });
                            ;
                          },
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text('Subir GNDVI'),
                              _selectedFileGNDVI != null
                                  ? Text('Image selected')
                                  : Text('No image selected'),
                            ],
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.cloud_upload),
                          onPressed: () async {
                            html.InputElement uploadInput = html.InputElement()
                              ..type = 'file';
                            uploadInput.click();
                            uploadInput.onChange.listen((event) {
                              final file = uploadInput.files!.first;
                              setState(() {
                                _selectedFileGNDVI =
                                    file; // Guarda el archivo seleccionado
                              });
                            });
                            ;
                          },
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text('Subir LCI'),
                              _selectedFileLCI != null
                                  ? Text('Image selected')
                                  : Text('No image selected'),
                            ],
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.cloud_upload),
                          onPressed: () async {
                            html.InputElement uploadInput = html.InputElement()
                              ..type = 'file';
                            uploadInput.click();
                            uploadInput.onChange.listen((event) {
                              final file = uploadInput.files!.first;
                              setState(() {
                                _selectedFileLCI =
                                    file; // Guarda el archivo seleccionado
                              });
                            });
                            ;
                          },
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text('Subir NDRE'),
                              _selectedFileNDRE != null
                                  ? Text('Image selected')
                                  : Text('No image selected'),
                            ],
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.cloud_upload),
                          onPressed: () async {
                            html.InputElement uploadInput = html.InputElement()
                              ..type = 'file';
                            uploadInput.click();
                            uploadInput.onChange.listen((event) {
                              final file = uploadInput.files!.first;
                              setState(() {
                                _selectedFileNDRE =
                                    file; // Guarda el archivo seleccionado
                              });
                            });
                            ;
                          },
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text('Subir OSAVI'),
                              _selectedFileOSAVI != null
                                  ? Text('Image selected')
                                  : Text('No image selected'),
                            ],
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.cloud_upload),
                          onPressed: () async {
                            html.InputElement uploadInput = html.InputElement()
                              ..type = 'file';
                            uploadInput.click();
                            uploadInput.onChange.listen((event) {
                              final file = uploadInput.files!.first;
                              setState(() {
                                _selectedFileOSAVI =
                                    file; // Guarda el archivo seleccionado
                              });
                            });
                          },
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 30,
                    ),

                    ElevatedButton(
                      onPressed: () async {
                        //SubirLaData
                        String id =
                            "${_lotController.text}-${_datecontroller.text}";
                        Map<String, dynamic> correoInfoMap = {
                          "Correo": _emailController.text,
                          "Campo": _fieldController.text,
                          "Lote": _lotController.text,
                          "Cultivo": _cropTypeController.text,
                          "Fecha": _datecontroller.text,
                          "Propietario": _ownerController.text,
                        };
                        DatabaseMethods().addCorreoDetails(correoInfoMap, id);

                        if (_formKey.currentState!.validate()) {
                          if (_selectedFileRGB != null) {
                            textoCargo = "RGB";
                            mostrarCarga = true;
                            final uploadTask = uploadFile(
                                _selectedFileRGB!,
                                _emailController.text,
                                _lotController.text,
                                _datecontroller.text,
                                "RGB",
                                id);
                            if (uploadTask != null) {
                              uploadTask.snapshotEvents.listen(
                                  (firebase_storage.TaskSnapshot snapshot) {
                                setState(() {
                                  _uploadProgress =
                                      snapshot.bytesTransferred.toDouble() /
                                          snapshot.totalBytes.toDouble();
                                });
                              });
                              await uploadTask.whenComplete(
                                  () => _showUploadComplete(context, "RGB"));
                            }
                          }

                          if (_selectedFileNDVI != null) {
                            textoCargo = "NDVI";

                            _uploadProgress = 0;
                            final uploadTask = uploadFile(
                                _selectedFileNDVI!,
                                _emailController.text,
                                _lotController.text,
                                _datecontroller.text,
                                "NDVI",
                                id);
                            if (uploadTask != null) {
                              uploadTask.snapshotEvents.listen(
                                  (firebase_storage.TaskSnapshot snapshot) {
                                setState(() {
                                  _uploadProgress =
                                      snapshot.bytesTransferred.toDouble() /
                                          snapshot.totalBytes.toDouble();
                                });
                              });
                              await uploadTask.whenComplete(
                                  () => _showUploadComplete(context, "NDVI"));
                            }
                          }
                          if (_selectedFileGNDVI != null) {
                            _uploadProgress = 0;
                            textoCargo = "GNVI";
                            final uploadTask = uploadFile(
                                _selectedFileGNDVI!,
                                _emailController.text,
                                _lotController.text,
                                _datecontroller.text,
                                "GNDVI",
                                id);
                            if (uploadTask != null) {
                              uploadTask.snapshotEvents.listen(
                                  (firebase_storage.TaskSnapshot snapshot) {
                                setState(() {
                                  _uploadProgress =
                                      snapshot.bytesTransferred.toDouble() /
                                          snapshot.totalBytes.toDouble();
                                });
                              });
                              await uploadTask.whenComplete(
                                  () => _showUploadComplete(context, "GNDVI"));
                            }
                          }
                          if (_selectedFileLCI != null) {
                            _uploadProgress = 0;
                            textoCargo = "LCI";
                            final uploadTask = uploadFile(
                                _selectedFileLCI!,
                                _emailController.text,
                                _lotController.text,
                                _datecontroller.text,
                                "LCI",
                                id);
                            if (uploadTask != null) {
                              uploadTask.snapshotEvents.listen(
                                  (firebase_storage.TaskSnapshot snapshot) {
                                setState(() {
                                  _uploadProgress =
                                      snapshot.bytesTransferred.toDouble() /
                                          snapshot.totalBytes.toDouble();
                                });
                              });
                              await uploadTask.whenComplete(
                                  () => _showUploadComplete(context, "LCI"));
                            }
                          }
                          if (_selectedFileNDRE != null) {
                            _uploadProgress = 0;
                            textoCargo = "NDRE";
                            final uploadTask = uploadFile(
                                _selectedFileNDRE!,
                                _emailController.text,
                                _lotController.text,
                                _datecontroller.text,
                                "NDRE",
                                id);
                            if (uploadTask != null) {
                              uploadTask.snapshotEvents.listen(
                                  (firebase_storage.TaskSnapshot snapshot) {
                                setState(() {
                                  _uploadProgress =
                                      snapshot.bytesTransferred.toDouble() /
                                          snapshot.totalBytes.toDouble();
                                });
                              });
                              await uploadTask.whenComplete(
                                  () => _showUploadComplete(context, "NDRE"));
                            }
                          }
                          if (_selectedFileOSAVI != null) {
                            textoCargo = "OSAVI";
                            _uploadProgress = 0;
                            final uploadTask = uploadFile(
                                _selectedFileOSAVI!,
                                _emailController.text,
                                _lotController.text,
                                _datecontroller.text,
                                "OSAVI",
                                id);
                            if (uploadTask != null) {
                              uploadTask.snapshotEvents.listen(
                                  (firebase_storage.TaskSnapshot snapshot) {
                                setState(() {
                                  _uploadProgress =
                                      snapshot.bytesTransferred.toDouble() /
                                          snapshot.totalBytes.toDouble();
                                });
                              });
                              await uploadTask.whenComplete(
                                  () => _showUploadComplete(context, "OSAVI"));
                            }
                          }
                          mostrarCarga = false;

                          showSuccessDialog(context);
                        }
                      },
                      child: Text('Subir archivo'),
                    ),
                    SizedBox(
                      height: 10,
                    ),

                    //ImagenFirebase(),
                  ],
                ),
              ),
              //Mensaje
              Visibility(
                visible: mostrarCarga,
                child: Container(
                  color: Colors.black45,
                  width:
                      MediaQuery.of(context).size.width, // Ancho de la pantalla
                  height: MediaQuery.of(context).size.height,
                  child: Container(
                    height: 400,
                    width: 400,
                    decoration: BoxDecoration(
                      color: Colors.white, // Color de fondo del Container
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Dialog(
                      backgroundColor: Colors.transparent,
                      child: Material(
                        color: Colors.white,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Text(
                              'Subiendo información',
                              style: TextStyle(
                                fontSize:
                                    20.0, // Ajusta el tamaño de la fuente a 24 puntos
                                color: Color.fromARGB(255, 117, 29,
                                    132), // Establece el color del texto a morado
                                fontWeight: FontWeight
                                    .bold, // Hace que el texto sea en negrita (opcional)
                              ),
                            ),
                            Image.asset(
                                'assets/UploadFinish.gif'), // Tu archivo GIF
                            SizedBox(height: 15),
                            LinearProgressIndicator(
                              value: _uploadProgress,
                              backgroundColor: Colors.grey,
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(Colors.purple),
                            ),
                            Text(
                                'Subiendo $textoCargo ${(_uploadProgress * 100).toStringAsFixed(2)} %'),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void _showUploadComplete(BuildContext context, String texto) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text('Archivo $texto subido con éxito'),
      duration: Duration(seconds: 3),
    ),
  );
}

firebase_storage.UploadTask? uploadFile(
    html.File file, String email, String lote, String fecha, String name, id) {
  if (file != null) {
    final String fileName = file.name;
    final String extension1 = fileName.contains('.')
        ? fileName.substring(fileName.lastIndexOf('.') + 1)
        : '';

    print(fileName);
    print(extension1);

    final firebase_storage.Reference storageRef = firebase_storage
        .FirebaseStorage.instance
        .ref()
        .child('$email/$lote/$fecha/$name.$extension1');
    DatabaseMethods().addMapDetails({
      "$name": '$email/$lote/$fecha/$name.$extension1',
    }, id);

    return storageRef.putBlob(file);
  }
  return null;
}

/* Future<void> uploadFile(html.File file) async {
  try {
    if (file != null) {
      // Nombre único para el archivo en Firebase Storage
      String fileName = DateTime.now().millisecondsSinceEpoch.toString();
      // Referencia al bucket de almacenamiento
      final firebase_storage.Reference storageRef = firebase_storage
          .FirebaseStorage.instance
          .ref()
          .child('techmall-410119.appspot.com/$fileName.png');
      // Sube el archivo
      await storageRef.putBlob(file);
      // Obtiene la URL de descarga del archivo
      String downloadURL = await storageRef.getDownloadURL();
      print('Archivo subido con éxito. URL de descarga: $downloadURL');
    }
  } catch (e) {
    print('Error al subir el archivo: $e');
  }
}
 */