import 'package:flutter/material.dart';
import 'package:peliculas/search/search_delegate.dart';
import 'package:peliculas/widgets/widgets.dart';
import 'package:provider/provider.dart';

import '../providers/providers.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final moviesProvider = Provider.of<MoviesProvider>(context);
    final authService = Provider.of<AuthService>(context, listen: false);
    String uidGet = authService.readUid().toString();
    print('uidGet: $uidGet');
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Películas en cines'),
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.logout),
          onPressed: () {
            authService.logout();
            Navigator.pushReplacementNamed(context, 'login');
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.search_outlined),
            onPressed: () =>
                showSearch(context: context, delegate: MovieSearchDelegate()),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Tarjetas principales
            CardSwiper(movies: moviesProvider.onDisplayMovies),

            // Slider de películas
            MovieSlider(
              movies: moviesProvider.popularMovies, // populares,
              title: 'Populares', // opcional
              onNextPage: () => moviesProvider.getPopularMovies(),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onNavItemTapped,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Inicio',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Usuario',
          ),
        ],
      ),
    );
  }

  void _onNavItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    // Acciones adicionales según el elemento seleccionado
    if (index == 0) {
      // Acciones para el elemento "Inicio"
      print('Clic en Inicio');
    } else if (index == 1) {
      Navigator.pushReplacementNamed(context, 'profile');
      // Acciones para el elemento "Usuario"
    }
  }
}
