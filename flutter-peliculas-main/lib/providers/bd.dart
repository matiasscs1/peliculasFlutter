import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:peliculas/models/usuarios.dart';

class DbController extends ChangeNotifier {
// Asegúrate de tener la clase Usuarios definida aquí o importada correctamente.

// Asegúrate de tener la clase Usuarios definida aquí o importada correctamente.

  Future<Usuarios> fetchUser(String id) async {
    final url = Uri.parse('http://10.0.2.2:8000/api/usuarios/$id');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      // Aquí procesas la respuesta
      // Convertir los datos JSON a una instancia de la clase Usuarios
      final usuarios = Usuarios.fromMap(json.decode(response.body));
      return usuarios;
    } else {
      throw Exception('Error al cargar los datos');
    }
  }
}
