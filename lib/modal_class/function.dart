import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:movies/modal_class/credits.dart';
import 'package:movies/modal_class/genres.dart';
import 'package:movies/modal_class/movie.dart';

class Services {
  Future<List<Movie>> fetchMovies(String api) async {
    MovieList movieList;
    var res = await http.get(Uri.parse(api));
    if (kDebugMode) {
      print(res.statusCode);
    }
    var decodeRes = jsonDecode(res.body);
    movieList = MovieList.fromJson(decodeRes);
    return movieList.movies ?? [];
  }

  Future<GenresList> fetchGenres(String api) async {
    GenresList genresList;
    var res = await http.get(Uri.parse(api));
    if (kDebugMode) {
      print(res.statusCode);
    }
    var decodeRes = jsonDecode(res.body);
    genresList = GenresList.fromJson(decodeRes);
    return genresList;
  }


  Future<Credits> fetchCredits(String api) async {
    Credits credits;
    var res = await http.get(Uri.parse(api));
    if (kDebugMode) {
      print(res.statusCode);
    }
    var decodeRes = jsonDecode(res.body);
    credits = Credits.fromJson(decodeRes);
    return credits;
  }

}
