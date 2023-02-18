
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:peliculas/helpers/debouncer.dart';
import 'package:peliculas/models/models.dart';
import 'package:peliculas/models/search_movies_response.dart';

class MoviesProvider extends ChangeNotifier {

  final String _apiKey   = '235fa3ef9bf82ad9f7e36e68229ca3d5';
  final String _baseUrl  = 'api.themoviedb.org';
  final String _language = 'es-ES';

  List<Movie> onDisplayMovies = [];
  List<Movie> popularMovies = [];
  
  Map<int, List<Cast>> movieCast = {};
  Map<String, List<Movie>> suggestMovies = {};

  int _popularPage = 0;

  final debouncer = Debouncer(
    duration: const Duration(milliseconds: 500),
  );

  final StreamController<List<Movie>> _suggestionStreamController = StreamController.broadcast();
  Stream<List<Movie>> get suggestionStream => this._suggestionStreamController.stream;

  MoviesProvider() {

    print('MoviesProvider inicializado');
    getOnDisplayMovies();
    getPopularMovies();
    
  }

  Future <String> _getJsonData(String endpoint, [int page = 1] ) async {
    final url = Uri.https(_baseUrl, endpoint, {
        'api_key': _apiKey,
        'language': _language,
        'page': '$page'
    });

    // Await the http get response, then decode the json-formatted response.
    final response = await http.get(url);
    return response.body;
  }

  getOnDisplayMovies() async {

    final jsonData = await _getJsonData('3/movie/now_playing');
    final nowPlayingResponse = NowPlayingResponse.fromJson(jsonData);

    onDisplayMovies = nowPlayingResponse.results;
    notifyListeners();
  }

  getPopularMovies() async {

    _popularPage++;

    final jsonData = await _getJsonData('3/movie/popular', _popularPage);
    final popularResponse = PopularResponse.fromJson(jsonData);

    popularMovies = [ ...popularMovies, ...popularResponse.results];
    notifyListeners();
  }

  Future<List<Cast>> getMovieCast( int movieId) async {
    
    if( movieCast.containsKey(movieId) ) return movieCast[movieId]!;

    final jsonData = await _getJsonData('3/movie/$movieId/credits');
    final creditsResponse = CreditsResponse.fromJson(jsonData);

    movieCast[movieId] = creditsResponse.cast;

    return creditsResponse.cast;
  }

  Future<List<Movie>> searchMovies( String query ) async {

    if( suggestMovies.containsKey(query) ) return suggestMovies[query]!;

    final url = Uri.https(_baseUrl, '3/search/movie', {
        'api_key': _apiKey,
        'language': _language,
        'query': query
    });

    final response = await http.get(url);
    final searchMovie = SearchMovieResponse.fromJson( response.body );
    
    suggestMovies[query] = searchMovie.results;

    return searchMovie.results;
  }

  void getSuggestionByQuery( String searchTerm ) {

     debouncer.value = '';
     debouncer.onValue = ( value ) async {
      // print('Tenemos valor a buscar: $value');
      final results = await this.searchMovies( value ); 
      this._suggestionStreamController.add( results );
     };

     final timer = Timer.periodic( const Duration( milliseconds: 300 ), ( _ ) {
      debouncer.value = searchTerm;
     });

     Future.delayed(Duration(milliseconds: 301)).then((value) => timer.cancel());

  }

}
