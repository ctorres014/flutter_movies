import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:peliculas/src/models/actors_model.dart';
import 'package:peliculas/src/models/movie_model.dart';


class MoviesProvider {
  String _apiKey = '7ad8d5ee84c1f4c2823a24f437bda8b9';
  String _url = 'api.themoviedb.org';
  String _language = 'es-ES';
  bool _loading = false;

  int _popularsPage = 0;

  List<Movie> _populars = List();

  final _popularsStreamController = StreamController<List<Movie>>.broadcast();

  Function(List<Movie>) get popularsSink => _popularsStreamController.sink.add;

  Stream<List<Movie>> get popularsStream => _popularsStreamController.stream;

  void disposeStream() {
    _popularsStreamController?.close();
  }

  Future<List<Movie>> _processResponse(Uri uri) async {
    final response = await http.get(uri);
    final decodeData = json.decode(response.body); // Convierte el objeto string en un objeto js

    final movies = new Movies.fromJsonList(decodeData['results']);

    return movies.items;
}

  Future<List<Movie>> getInCinemas() async {
    final url = Uri.https(_url, '3/movie/now_playing', {
      'api_key'   : _apiKey,
      'language'  : _language
    });

    return await _processResponse(url);
    
  }

  Future<List<Movie>> getPopulars() async {
    if(_loading) return [];

    _loading = true;

    _popularsPage++;
    final url = Uri.https(_url, '3/movie/popular', {
      'api_key'   : _apiKey,
      'language'  : _language,
      'page'      : _popularsPage.toString()
    });

   final resp = await _processResponse(url);

   _populars.addAll(resp);
   popularsSink(_populars);

  _loading = false;
   return resp;

  }

  Future<List<Actor>> getActors( String movieId) async {
     final url = Uri.https(_url, '3/movie/$movieId/credits', {
      'api_key'   : _apiKey,
      'language'  : _language
    });

    final resp = await http.get(url);
    final decodeData = json.decode(resp.body);

    final cast = new Actors.fromJsonList(decodeData['cast']);

    return cast.actors;
  }

   Future<List<Movie>> searchMovie( String query ) async {

    final url = Uri.https(_url, '3/search/movie', {
      'api_key'  : _apiKey,
      'language' : _language,
      'query'    : query
    });

    return await _processResponse(url);

  }


}