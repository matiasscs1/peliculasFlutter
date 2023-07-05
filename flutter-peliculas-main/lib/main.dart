import 'package:flutter/material.dart';
import 'package:peliculas/providers/providers.dart';
import 'package:peliculas/screens/informacion_usuario.dart';
import 'package:peliculas/screens/screens.dart';
import 'package:provider/provider.dart';

void main() => runApp(AppState());

class AppState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthService()),
        ChangeNotifierProvider(create: (_) => MoviesProvider(), lazy: false),
        ChangeNotifierProvider(create: (_) => DbController()),
      ],
      child: MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Películas',
      initialRoute: 'checkAuth',
      routes: {
        'login': (_) => LoginScreen(),
        'register': (_) => RegisterScreen(),
        'home': (_) => HomeScreen(),
        'details': (_) => DetailsScreen(),
        'checkAuth': (_) => CheckAuthScreen(),
        'profile': (_) => ProfileScreen(),
        //'trailer': (_) => YouTubePlayerScreen(videoId: 'zOnaAGElQg8'),
      },
      scaffoldMessengerKey: NotificationsService.messengerKey,
      theme: ThemeData.light()
          .copyWith(appBarTheme: AppBarTheme(color: Colors.indigo)),
    );
  }
}
