import 'package:movies/constants/api_constants.dart';

class Endpoints {
  static String discoverMoviesUrl(int page) {
    return '$apiBaseUrl'
        '/discover/movie?api_key='
        '$apiKey'
        '&include_adult=false&page=$page';
  }

  static String nowPlayingMoviesUrl(int page) {
    return '$apiBaseUrl'
        '/movie/now_playing?api_key='
        '$apiKey'
        '&include_adult=false&page=$page';
  }

  static String getCreditsUrl(int id) {
    return '$apiBaseUrl' + '/movie/$id/credits?api_key=$apiKey';
  }

  static String getTrendingMovies(int page) {
    return '$apiBaseUrl'
        '/trending/movie/day?api_key=$apiKey'
        '&include_adult=false&page=$page';
  }

  static String topRatedUrl(int page) {
    return '$apiBaseUrl'
        '/movie/top_rated?api_key='
        '$apiKey'
        '&include_adult=false&page=$page';
  }

  static String popularMoviesUrl(int page) {
    return '$apiBaseUrl'
        '/movie/popular?api_key='
        '$apiKey'
        '&include_adult=false&page=$page';
  }

  static String upcomingMoviesUrl(int page) {
    return '$apiBaseUrl'
        '/movie/upcoming?api_key='
        '$apiKey'
        '&include_adult=false&page=$page';
  }

  static String movieDetailsUrl(int movieId) {
    return '$apiBaseUrl/movie/$movieId?api_key=$apiKey&append_to_response=credits,'
        'images';
  }

  static String genresUrl() {
    return '$apiBaseUrl/genre/movie/list?api_key=$apiKey&language=en-US';
  }

  static String getMoviesForGenre(int genreId, int page) {
    return '$apiBaseUrl/discover/movie?api_key=$apiKey'
        '&language=en-US'
        '&sort_by=popularity.desc'
        '&include_adult=false'
        '&include_video=false'
        '&page=$page'
        '&with_genres=$genreId';
  }

  static String movieReviewsUrl(int movieId, int page) {
    return '$apiBaseUrl/movie/$movieId/reviews?api_key=$apiKey'
        '&language=en-US&page=$page';
  }

  static String movieSearchUrl(String query) {
    return "$apiBaseUrl/search/movie?query=$query&api_key=$apiKey";
  }

  static String personSearchUrl(String query) {
    return "$apiBaseUrl/search/person?query=$query&api_key=$apiKey";
  }

  static getPerson(int personId) {
    return "$apiBaseUrl/person/$personId?api_key=$apiKey&append_to_response=movie_credits";
  }
}
