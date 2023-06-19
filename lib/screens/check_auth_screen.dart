import 'package:flutter/material.dart';
import 'package:peliculas/screens/home_screen.dart';
import 'package:peliculas/screens/login_screen.dart';
import 'package:provider/provider.dart';

import '../models/models.dart';

class CheckAuthScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context, listen: false);

    return Scaffold(
      body: Center(
        child: FutureBuilder(
          future: authService.readToken(),
          builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
            if (!snapshot.hasData) {
              return Text('Espere...');
            }

            if (snapshot.data == '') {
              Future.microtask(() {
                Navigator.pushReplacement(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (_, __, ___) => LoginScreen(),
                    transitionDuration: Duration(milliseconds: 0),
                  ),
                );
              });
            } else {
              Future.microtask(() {
                Navigator.pushReplacement(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (_, __, ___) => HomeScreen(),
                    transitionDuration: Duration(milliseconds: 0),
                  ),
                );
              });
            }
            return Container(); // Se debe devolver un widget en el builder
          },
        ),
      ),
    );
  }
}
