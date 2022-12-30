import 'package:flutter/material.dart';
import 'package:movies/modal_class/genres.dart';
import 'package:movies/screens/shimmer_loading.dart';
import 'package:movies/screens/widgets.dart';
import 'package:movies/providers/movie_provider.dart';
import 'package:provider/provider.dart';
import 'package:movies/constants/theme_constraints.dart';

class GenreMovies extends StatelessWidget {
  //final ThemeData themeData;
  final Genres genre;
  final List<Genres> genres;

  //final Movie movie;

  GenreMovies({
    required this.genre,
    required this.genres,
  });
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<MovieProvider>(context);
    // final state = Provider.of<ThemeState>(context);

    return genre.name == null
        ? Center(
            child: CircularProgressIndicator(),
          )
        : Scaffold(
            appBar: AppBar(
              backgroundColor: kMoviesTheme.primaryColor,
              title: Text(
                genre.name!,
                style: kMoviesTheme.textTheme.headline5,
              ),
              leading: IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  color: kMoviesTheme.colorScheme.secondary,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
            body: provider.moviesForParticularGenreList.isEmpty
                ? MovieShimmer()
                :
                //Container()
                GenreMoviesCards(
                    dataList: provider.moviesForParticularGenreList,
                  ),
          );
  }
}
