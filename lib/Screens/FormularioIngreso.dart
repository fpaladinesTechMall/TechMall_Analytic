import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UploadForm extends StatefulWidget {
  @override
  _UploadFormState createState() => _UploadFormState();
}

class _UploadFormState extends State<UploadForm> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _fieldController = TextEditingController();
  final _lotController = TextEditingController();
  final _cropTypeController = TextEditingController();
  final _ownerController = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  Map<String, File> _images = {};

  Future<void> pickImage(String field) async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _images[field] = File(pickedFile.path);
      });
    }
  }

  Future<void> uploadImage(String field) async {
    if (_images[field] != null) {
      File? imageFile = _images[field];
      try {
        Reference ref = FirebaseStorage.instance
            .ref()
            .child('images/$field/${imageFile?.path}');
        await ref.putFile(imageFile!);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Image uploaded for $field')),
        );
      } on FirebaseException catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to upload image: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: Size(360, 690));

    return Scaffold(
      appBar: AppBar(
        title: Text('TechMall Form'),
        backgroundColor: Color.fromARGB(127, 158, 158, 158),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.w),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: 'Correo',
                  labelStyle: TextStyle(color: Colors.grey),
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Color.fromARGB(127, 158, 158, 158)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Color.fromARGB(127, 158, 158, 158)),
                  ),
                ),
                validator: (value) {
                  if (value!.isEmpty || !value.contains('@')) {
                    return 'Please enter a valid email';
                  }
                  return null;
                },
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
                    borderSide:
                        BorderSide(color: Color.fromARGB(127, 158, 158, 158)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Color.fromARGB(127, 158, 158, 158)),
                  ),
                ),
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
                    borderSide:
                        BorderSide(color: Color.fromARGB(127, 158, 158, 158)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Color.fromARGB(127, 158, 158, 158)),
                  ),
                ),
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
                    borderSide:
                        BorderSide(color: Color.fromARGB(127, 158, 158, 158)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Color.fromARGB(127, 158, 158, 158)),
                  ),
                ),
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
                    borderSide:
                        BorderSide(color: Color.fromARGB(127, 158, 158, 158)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Color.fromARGB(127, 158, 158, 158)),
                  ),
                ),
              ),
              ...['RGB', 'NDVI', 'GNDVI', 'LCI', 'NDRE', 'OSAVI'].map((field) {
                return ListTile(
                  title: Text('Upload $field Image'),
                  trailing: IconButton(
                    icon: Icon(Icons.camera_alt),
                    onPressed: () {
                      pickImage(field);
                    },
                  ),
                  subtitle: _images[field] != null
                      ? Text('Image selected')
                      : Text('No image selected'),
                );
              }).toList(),
              SizedBox(
                height: 8,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.purple, // Color del botón
                  onPrimary: Colors.white, // Color del texto del botón
                ),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _images.keys.forEach((field) => uploadImage(field));
                  }
                },
                child: Text('Submit & Upload Images'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
