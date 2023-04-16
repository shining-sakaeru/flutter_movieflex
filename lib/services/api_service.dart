import 'dart:convert';
import 'dart:core';

import 'package:flutter_movieflix/models/movie_model.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static String baseUrl = "https://movies-api.nomadcoders.workers.dev";
  static String popular = "popular";
  static String nowPlaying = "now-playing";
  static String upcoming = "coming-soon";
  static String movie = "movie";

  static Future<List<MovieModel>> getMovies(String order) async {
    List<MovieModel> movieInstances = [];
    if (order == "popular") {
      order = popular;
    } else if (order == "nowPlaying") {
      order = nowPlaying;
    } else if (order == "upcoming") {
      order = upcoming;
    }
    final url = Uri.parse('$baseUrl/$order');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final movies = jsonDecode(response.body);
      for (var movie in movies['results']) {
        final mov = MovieModel.fromJson(movie);
        movieInstances.add(mov);
      }
      return movieInstances;
    }
    throw Error();
  }

  static Future<MovieDetailModel> getMovieByID(String id) async {
    final url = Uri.parse('$baseUrl/$movie?id=$id');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final movie = jsonDecode(response.body);
      final mov = MovieDetailModel.fromJson(movie);
      return mov;
    }
    throw Error();
  }
}
