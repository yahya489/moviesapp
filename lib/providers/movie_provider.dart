import 'package:flutter/material.dart';
import 'package:movies/modal_class/movie.dart';
import 'package:movies/modal_class/function.dart';
import 'package:movies/api/endpoints.dart';
import 'package:movies/modal_class/genres.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:movies/database/local_database.dart';
import 'package:movies/modal_class/credits.dart';

class MovieProvider extends ChangeNotifier {
  // Initiating required callbacks when the app starts
  MovieProvider() {
    notifyListeners();
    getInistialData();
    setFavorites(db.favoritesLocalDb, db.favoritesMoviesIdsDb);
    notifyListeners();
    print('favorite list is ${favoritesList.length}');
    print('IDs list is ${favoritesIds.length}');
    print('localdb list is ${db.favoritesLocalDb.length}');
    print('localid list is ${db.favoritesMoviesIdsDb.length}');
  }

  void getInistialData() async {
    notifyListeners();
    await getUpcomingMovies();
    await getDiscoverMovies();
    await getNowPlayingMovies();
    await getAllGenres();
    await getTrendingMovie();
    notifyListeners();
  }

// Initiate required instances that is utilized in this provider
  final _service = Services();
  SharedPreferences? prefs;
  FavoritesDataBase db = FavoritesDataBase();
  bool dataSynced = false;

//<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<< Movies List >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
//DISCOVER LIST
  List _discoverMovies = [];
  List get discoverMovies => _discoverMovies;
  Future<void> getDiscoverMovies() async {
    try {
      _discoverMovies =
          await (_service.fetchMovies(Endpoints.discoverMoviesUrl(1)));
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  //NOW PLAYING LIST
  List _nowPlayingList = [];
  List get nowPlayingList => _nowPlayingList;
  Future<void> getNowPlayingMovies() async {
    try {
      _nowPlayingList = await (_service.fetchMovies(
        Endpoints.nowPlayingMoviesUrl(1),
      ));
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  //UPCOMING MOVIES LIST
  List _upcomingMovies = [];
  List get upcomingMovies => _upcomingMovies;
  Future<void> getUpcomingMovies() async {
    try {
      _upcomingMovies = await (_service.fetchMovies(
        Endpoints.upcomingMoviesUrl(1),
      ));
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  // TRENDING MOVIES LIST
  List _trendingMovies = [];
  List get trendingMovies => _trendingMovies;
  Future<void> getTrendingMovie() async {
    try {
      _trendingMovies =
          await (_service.fetchMovies(Endpoints.getTrendingMovies(1)));
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  //PARTICULAR GENRE MOVIES
  List<Movie> _moviesForParticularGenreList = [];
  List<Movie> get moviesForParticularGenreList => _moviesForParticularGenreList;
  Future<void> getMoviesForParticularGenre(int? genreId) async {
    try {
      _moviesForParticularGenreList = [];
      _moviesForParticularGenreList = await (_service
          .fetchMovies(Endpoints.getMoviesForGenre(genreId!, 1)));
      _discoverMovies = _moviesForParticularGenreList;
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

// FAVORITES LIST
  List _favoritesList = [];
  List get favoritesList => _favoritesList;
  List
      _favoritesIds = // >>>>  it will be used to check if the movie is already added in the favorites.
      [];
  List get favoritesIds => _favoritesIds;

  addMovieToFavorites(Movie movie) {
    _favoritesList.add(movie);
    db.favoritesLocalDb =
        _favoritesList; // >>>>>>>> to update the list that is stored in local storage
    notifyListeners();
    _favoritesIds.add(movie.id);
    notifyListeners();
    db.favoritesMoviesIdsDb =
        _favoritesIds; // >>>>>>> to update the list that is stored in local storage
    notifyListeners();
    db.updateDataBase(); //>>>> Hive function to update the local database
    print('favorite list is ${favoritesList.length}');
    print('IDs list is ${favoritesIds.length}');
    print('localdb list is ${db.favoritesLocalDb.length}');
    print('localid list is ${db.favoritesMoviesIdsDb.length}');
  }

  void removeMovieFromFavoriteList(Movie movie) {
    _favoritesList.remove(movie);
    notifyListeners();
    _favoritesIds.remove(movie.id);
    notifyListeners();
    db.favoritesLocalDb = _favoritesList;
    notifyListeners();
    db.updateDataBase();
    db.favoritesMoviesIdsDb = _favoritesIds;
    notifyListeners();
    db.updateDataBase();
    print('favorite list is ${_favoritesList.length}');
    print('IDs list is ${_favoritesIds.length}');
    print('localdb list is ${db.favoritesLocalDb.length}');
    print('localid list is ${db.favoritesMoviesIdsDb.length}');
  }

  void setFavorites(favDb, favMovieIdDb) {
    _favoritesList = favDb;
    _favoritesIds = favMovieIdDb;
    notifyListeners();
  } //>>>>>> // This function is used to get the values from the list that stored locally when app is initializing

  //<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<< Movies details >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
  getGenresForMovie(List<int> genresIdsForMovie) {
    _genresListForMovie = [];
    Future.delayed(Duration.zero, () {
      _genresList.forEach((valueGenre) {
        genresIdsForMovie.forEach((genre) {
          if (valueGenre.id == genre) {
            _genresListForMovie.add(valueGenre);
          }
        });
      });
    });
    notifyListeners();
  }

  // CREDITS
  Credits? _credits;
  Credits? get credits => _credits;
  Future<void> getCreditsForaMovie(int movieId) async {
    _credits = await _service.fetchCredits(Endpoints.getCreditsUrl(movieId));
    notifyListeners();
  }

  // GENERIS
  GenresList? _genres;
  GenresList? get genres => _genres;
  List<Genres> _genresList = [];
  List<Genres> get genresList => _genresList;
  Future<void> getAllGenres() async {
    _genres = await (_service.fetchGenres(Endpoints.genresUrl()));
    _genresList = _genres!.genres ?? [];
    notifyListeners();
  }

  List<int> _genresIdsForMovie = [];
  List<int> get genresIdsForMovie => _genresIdsForMovie;
  List<Genres> _genresListForMovie = [];
  List<Genres> get genresListForMovie => _genresListForMovie;

  String _genreTitle = 'Discover By Category';
  String get genreTitle => _genreTitle;
  updateScrollingGenreTitle(String name) {
    _genreTitle = name;
    notifyListeners();
  } // >>> used in Home page to help navigating movies by categories.
}
