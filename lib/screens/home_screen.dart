import 'package:flutter/material.dart';

import 'package:peliculas/widgets/widgets.dart';
import 'package:provider/provider.dart';

import 'package:peliculas/search/search_delegate.dart';
import 'package:peliculas/providers/movies_provider.dart';

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
              onPressed: () => showSearch(context: context, delegate: MovieSearchDelegate()),
              icon: const Icon(Icons.search_outlined),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              // Tarjetas principales
              CardSwiper(movies: moviesPovider.onDisplayMovies),

              // Slider de
              // películas
              MovieSlider(
                movies: moviesPovider.popularMovies,
                title: 'Populares!',
                onNextPage: () => moviesPovider.getPopularMovies(),
              ), // Listado horizontal películas
            ],
          ),
        ));
  }
}
