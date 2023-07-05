import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:peliculas/providers/providers.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  File? _profileImage;

  Future<void> _takePicture() async {
    final imagePicker = ImagePicker();
    final image = await imagePicker.pickImage(
      source: ImageSource.camera,
    );

    if (image != null) {
      final File selectedImage = File(image.path);
      setState(() {
        _profileImage = selectedImage;
      });

      // Guarda la imagen seleccionada en tu almacenamiento preferido
      // Puedes usar el paquete `path_provider` para obtener el directorio de almacenamiento
      // y el paquete `flutter_cache_manager` para guardar la imagen en la memoria caché
      // Aquí hay un ejemplo de cómo guardar la imagen en el directorio de documentos de la aplicación:
      // final appDocumentsDir = await getApplicationDocumentsDirectory();
      // final fileName = 'profile_image.jpg';
      // final savedImage = await selectedImage.copy('${appDocumentsDir.path}/$fileName');
    }
  }

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    final controlador = Provider.of<DbController>(context);

    return FutureBuilder<String>(
      future: authService.readUid(),
      builder: (BuildContext context, AsyncSnapshot<String> uidSnapshot) {
        if (uidSnapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        }

        if (uidSnapshot.hasError) {
          return Text('Error al obtener el UID');
        }

        String uidGet = uidSnapshot.data!;

        return FutureBuilder(
          future: controlador.fetchUser(uidGet),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            }

            if (snapshot.hasError) {
              return Text('Error al obtener el usuario');
            }

            final usuario = snapshot.data;

            return Scaffold(
              appBar: AppBar(
                title: Text('Perfil de usuario'),
                actions: [
                  IconButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, 'home');
                    },
                    icon: Icon(Icons.home),
                  )
                ],
              ),
              body: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.indigo, width: 2),
                      ),
                      child: CircleAvatar(
                        backgroundImage: _profileImage != null
                            ? FileImage(_profileImage!)
                            : null,
                        child: _profileImage == null
                            ? Icon(Icons.person, size: 60, color: Colors.indigo)
                            : null,
                      ),
                    ),
                    SizedBox(height: 16),
                    TextField(
                      decoration: InputDecoration(
                        labelText: 'Nombres',
                        labelStyle: TextStyle(color: Colors.indigo),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.indigo),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.indigo),
                        ),
                      ),
                      controller:
                          TextEditingController(text: usuario.nombresUsuario),
                      readOnly: true,
                    ),
                    SizedBox(height: 16),
                    TextField(
                      decoration: InputDecoration(
                        labelText: 'Apellidos',
                        labelStyle: TextStyle(color: Colors.indigo),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.indigo),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.indigo),
                        ),
                      ),
                      controller:
                          TextEditingController(text: usuario.apellidosUsuario),
                      readOnly: true,
                    ),
                    SizedBox(height: 16),
                    TextField(
                      decoration: InputDecoration(
                        labelText: 'Cédula',
                        labelStyle: TextStyle(color: Colors.indigo),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.indigo),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.indigo),
                        ),
                      ),
                      controller:
                          TextEditingController(text: usuario.cedulaUsuario),
                      readOnly: true,
                    ),
                    SizedBox(height: 16),
                    TextField(
                      decoration: InputDecoration(
                        labelText: 'Fecha de Nacimiento',
                        labelStyle: TextStyle(color: Colors.indigo),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.indigo),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.indigo),
                        ),
                      ),
                      controller: TextEditingController(
                          text: usuario.fechaNacimientoUsuario.toString()),
                      readOnly: true,
                    ),
                    SizedBox(height: 16),
                    TextField(
                      decoration: InputDecoration(
                        labelText: 'Edad',
                        labelStyle: TextStyle(color: Colors.indigo),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.indigo),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.indigo),
                        ),
                      ),
                      controller: TextEditingController(
                          text: usuario.edasUsuario.toString()),
                      readOnly: true,
                    ),
                    SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: _takePicture,
                      child: Text('Tomar foto'),
                    ),
                    if (_profileImage != null)
                      Image.file(_profileImage!, width: 200, height: 200),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
