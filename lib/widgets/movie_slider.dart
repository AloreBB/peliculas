import 'package:flutter/material.dart';

import 'package:peliculas/models/models.dart';

class MovieSlider extends StatelessWidget {

  final String? title;
  final List<Movie> movies;

  const MovieSlider({
    super.key, 
    this.title, 
    required this.movies
  });

  @override
  Widget build(BuildContext context) {

    return Container(
      // padding: const EdgeInsets.all(0),

      width: double.infinity,
      height: 300,
      // color: Colors.red,
      margin: const EdgeInsets.symmetric(vertical: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        children: [

          if( title != null )
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                title!,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
          const SizedBox(height: 5),
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: movies.length,
              itemBuilder: ( _, index) => _MoviePoster(movie: movies[index]),
            ),
          )
        ],
      ),
    );
  }
}

class _MoviePoster extends StatelessWidget {

  final Movie movie;

  const _MoviePoster({
    required this.movie
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 130,
      height: 190,
      // color: Colors.green,
      margin: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [

          GestureDetector(
            onTap: () => Navigator.pushNamed(context, 'details',
                arguments: 'movie-instance'),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: FadeInImage(
                placeholder: const AssetImage('assets/no-image.jpg'),
                image: NetworkImage(movie.fullPosterImg),
                width: 130,
                height: 190,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 5),
          Text(
            movie.title,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}
