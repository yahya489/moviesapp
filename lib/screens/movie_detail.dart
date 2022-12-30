import 'package:flutter/material.dart';
import 'package:movies/constants/api_constants.dart';
import 'package:movies/modal_class/movie.dart';
import 'package:movies/screens/widgets.dart';
import 'package:provider/provider.dart';
import 'package:movies/providers/movie_provider.dart';
import 'package:movies/database/local_database.dart';
import 'package:movies/constants/theme_constraints.dart';

class MovieDetailsScreen extends StatelessWidget {
  final String heroId;
  final int selectedIndex;
  List dataList;
  final Movie movie;
  MovieDetailsScreen(
      {required this.heroId,
      required this.dataList,
      required this.movie,
      required this.selectedIndex});

  FavoritesDataBase db = FavoritesDataBase();

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<MovieProvider>(context);
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Column(
            children: <Widget>[
              Expanded(
                child: Stack(
                  children: <Widget>[
                    movie.backdropPath == null
                        ? Image.asset(
                            'assets/images/na.jpg',
                            fit: BoxFit.cover,
                          )
                        : FadeInImage(
                            width: double.infinity,
                            height: double.infinity,
                            image: NetworkImage(baseImageUrl +
                                'original/' +
                                movie.backdropPath!),
                            fit: BoxFit.cover,
                            placeholder:
                                const AssetImage('assets/images/loading.gif'),
                          ),
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          gradient: LinearGradient(
                              begin: FractionalOffset.bottomCenter,
                              end: FractionalOffset.topCenter,
                              colors: [
                                kMoviesTheme.colorScheme.secondary,
                                kMoviesTheme.colorScheme.secondary
                                    .withOpacity(0.3),
                                kMoviesTheme.colorScheme.secondary
                                    .withOpacity(0.2),
                                kMoviesTheme.colorScheme.secondary
                                    .withOpacity(0.1),
                              ],
                              stops: const [
                                0.0,
                                0.25,
                                0.5,
                                0.75
                              ])),
                    )
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  color: kMoviesTheme.colorScheme.secondary,
                ),
              )
            ],
          ),
          Column(
            children: <Widget>[
              AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
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
              Expanded(
                child: Container(
                  color: Colors.transparent,
                  child: Stack(
                    children: <Widget>[
                      SizedBox(
                        width: double.infinity,
                        height: double.infinity,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(16, 75, 16, 16),
                          child: Card(
                            elevation: 5,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            color: kMoviesTheme.primaryColor,
                            child: Column(
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(left: 120.0),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          movie.title!,
                                          style:
                                              kMoviesTheme.textTheme.headline5,
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            children: <Widget>[
                                              Text(
                                                movie.voteAverage!,
                                                style: kMoviesTheme
                                                    .textTheme.bodyText1,
                                              ),
                                              const Icon(
                                                Icons.star,
                                                color: Colors.green,
                                              ),
                                              IconButton(
                                                onPressed: () {
                                                  // check if its already added in the favorites list
                                                  provider.favoritesIds
                                                          .contains(dataList[
                                                                  selectedIndex]
                                                              .id)
                                                      ? provider
                                                          .removeMovieFromFavoriteList(
                                                              dataList[
                                                                  selectedIndex])
                                                      : provider
                                                          .addMovieToFavorites(
                                                              dataList[
                                                                  selectedIndex]);
                                                  print(
                                                      'favorites list = ${provider.favoritesList.length}');
                                                  print(
                                                      ' IDs list = ${provider.favoritesIds.length}');
                                                },
                                                icon: Icon(Icons.favorite,
                                                    color: provider.favoritesIds
                                                            .contains(dataList[
                                                                    selectedIndex]
                                                                .id)
                                                        ? Colors.red
                                                        : Colors.white),
                                              )
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: SingleChildScrollView(
                                    physics: const BouncingScrollPhysics(),
                                    child: Column(
                                      children: <Widget>[
                                        provider.genresList.isEmpty
                                            ? Container()
                                            : GenreListWidgetForMovie(
                                                dataList: dataList,
                                                movie: movie,
                                                genresListToDisplay: provider
                                                    .genresListForMovie),
                                        Row(
                                          children: <Widget>[
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 8.0),
                                              child: Text(
                                                'Overview',
                                                style: kMoviesTheme
                                                    .textTheme.bodyText1,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            movie.overview!,
                                            style:
                                                kMoviesTheme.textTheme.caption,
                                          ),
                                        ),
                                        Row(
                                          children: <Widget>[
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 8.0, bottom: 4.0),
                                              child: Text(
                                                'Release date : ${movie.releaseDate}',
                                                style: kMoviesTheme
                                                    .textTheme.bodyText1,
                                              ),
                                            ),
                                          ],
                                        ),
                                        ScrollingArtists()
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 0,
                        left: 40,
                        child: Hero(
                          tag: heroId,
                          child: SizedBox(
                            width: 100,
                            height: 150,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8.0),
                              child: movie.posterPath == null
                                  ? Image.asset(
                                      'assets/images/na.jpg',
                                      fit: BoxFit.cover,
                                    )
                                  : FadeInImage(
                                      image: NetworkImage(baseImageUrl +
                                          'w500/' +
                                          movie.posterPath!),
                                      fit: BoxFit.cover,
                                      placeholder: const AssetImage(
                                          'assets/images/loading.gif'),
                                    ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
