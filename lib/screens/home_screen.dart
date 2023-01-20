import 'package:flutter/material.dart';

import 'package:peliculas/providers/movies_provider.dart';
import 'package:peliculas/widgets/widgets.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final moviesPovider = Provider.of<MoviesProvider>(context);

    return Scaffold(
        appBar: AppBar(
          title: const Text('Películas en cines'),
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.search_outlined),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              
              // Tarjetas principales
              CardSwiper( movies: moviesPovider.onDisplayMovies ),
        
              // Slider de películas
              MovieSlider(title: 'Populares'),        
              // Listado horizontal películas
            ],
          ),
        )
      );
  }
}
