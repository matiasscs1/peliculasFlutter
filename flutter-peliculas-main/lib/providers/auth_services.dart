import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class AuthService extends ChangeNotifier {
  final String _baseUrl = 'identitytoolkit.googleapis.com';
  final String _firebaseToken = 'AIzaSyCyizUVgPVefWnXSQ3X3KPQJSFF0-ZR3Zk';
  final Storage = new FlutterSecureStorage();

  Future<String?> createUser(String email, String password) async {
    final Map<String, dynamic> authData = {
      'email': email,
      'password': password,
    };

    final url = Uri.https(_baseUrl, '/v1/accounts:signUp', {
      'key': _firebaseToken,
    });

    final resp = await http.post(url, body: json.encode(authData));
    final Map<String, dynamic> decodedResp = json.decode(resp.body);

    if (decodedResp.containsKey('idToken')) {
      // Guardar token en lugar seguro
      await Storage.write(key: 'token', value: decodedResp['idToken']);

      // Devolver el UID del usuario registrado
      return decodedResp['localId'];
    } else {
      return decodedResp['error']['message'];
    }
  }

  Future<String?> login(String email, String password) async {
    final Map<String, dynamic> authData = {
      'email': email,
      'password': password,
    };

    final url = Uri.https(_baseUrl, '/v1/accounts:signInWithPassword', {
      'key': _firebaseToken,
    });

    final resp = await http.post(url, body: json.encode(authData));
    final Map<String, dynamic> decodedResp = json.decode(resp.body);

    if (decodedResp.containsKey('idToken')) {
      // Guardar token en lugar seguro
      await Storage.write(key: 'token', value: decodedResp['idToken']);

      // Obtener el UID del usuario registrado

      String uid = decodedResp['localId'];
      await Storage.write(key: 'uid', value: uid);
      return null;
    } else {
      return decodedResp['error']['message'];
    }
  }

  Future logout() async {
    await Storage.delete(key: 'uid');

    await Storage.delete(key: 'token');
    return;
  }

  Future<String> readToken() async {
    return await Storage.read(key: 'token') ?? '';
  }

  Future<String> readUid() async {
    return await Storage.read(key: 'uid') ?? '';
  }
}
