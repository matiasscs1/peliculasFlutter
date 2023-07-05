// To parse this JSON data, do
//
//     final usuarios = usuariosFromMap(jsonString);

import 'dart:convert';

class Usuarios {
  String tokenUsuario;
  String nombresUsuario;
  String apellidosUsuario;
  String cedulaUsuario;
  DateTime fechaNacimientoUsuario;
  int edasUsuario;

  Usuarios({
    required this.tokenUsuario,
    required this.nombresUsuario,
    required this.apellidosUsuario,
    required this.cedulaUsuario,
    required this.fechaNacimientoUsuario,
    required this.edasUsuario,
  });

  factory Usuarios.fromJson(String str) => Usuarios.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Usuarios.fromMap(Map<String, dynamic> json) => Usuarios(
        tokenUsuario: json["Token_Usuario"],
        nombresUsuario: json["Nombres_Usuario"],
        apellidosUsuario: json["Apellidos_Usuario"],
        cedulaUsuario: json["Cedula_Usuario"],
        fechaNacimientoUsuario: DateTime.parse(json["FechaNacimiento_Usuario"]),
        edasUsuario: json["Edas_Usuario"],
      );

  Map<String, dynamic> toMap() => {
        "Token_Usuario": tokenUsuario,
        "Nombres_Usuario": nombresUsuario,
        "Apellidos_Usuario": apellidosUsuario,
        "Cedula_Usuario": cedulaUsuario,
        "FechaNacimiento_Usuario":
            "${fechaNacimientoUsuario.year.toString().padLeft(4, '0')}-${fechaNacimientoUsuario.month.toString().padLeft(2, '0')}-${fechaNacimientoUsuario.day.toString().padLeft(2, '0')}",
        "Edas_Usuario": edasUsuario,
      };
}
