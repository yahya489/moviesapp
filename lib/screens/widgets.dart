import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:movies/constants/api_constants.dart';
import 'package:movies/modal_class/credits.dart';
import 'package:movies/modal_class/genres.dart';
import 'package:movies/modal_class/movie.dart';
import 'package:movies/providers/buttons_provider.dart';
import 'package:movies/providers/movie_provider.dart';
import 'package:movies/screens/castncrew.dart';
import 'package:movies/screens/genremovies.dart';
import 'package:movies/screens/movie_detail.dart';
import 'package:provider/provider.dart';
import 'package:movies/database/local_database.dart';
import 'package:movies/constants/theme_constraints.dart';

class NowPlayingMovies extends StatelessWidget {
  final List dataList;
  NowPlayingMovies({required this.dataList});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<MovieProvider>(context);

    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child:
                  Text('Now Playing', style: kMoviesTheme.textTheme.headline5),
            ),
          ],
        ),
        SizedBox(
          width: double.infinity,
          height: 350,
          child: dataList.isEmpty
              //moviesList!.isEmpty
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : CarouselSlider.builder(
                  options: CarouselOptions(
                    disableCenter: true,
                    viewportFraction: 0.8,
                    enlargeCenterPage: true,
                  ),
                  itemBuilder:
                      (BuildContext context, int index, pageViewIndex) {
                    return GestureDetector(
                        onTap: () {
                          provider.getGenresForMovie(
                              dataList[index].genreIds ?? []);
                          provider.getCreditsForaMovie(dataList[index].id);

                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MovieDetailsScreen(
                                      selectedIndex: index,
                                      movie: dataList[index],
                                      heroId:
                                          '${dataList[index].id}now playing',
                                      dataList: dataList)));
                        },
                        child: Hero(
                          tag: '${dataList[index].id}now playing',
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8.0),
                            child: Image(
                              image: NetworkImage(baseImageUrl +
                                  'w500/' +
                                  dataList[index].posterPath!),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ));
                  },
                  itemCount: dataList.length,
                ),
        ),
      ],
    );
    ;
  }
}

class Scrolling extends StatelessWidget {
  final String? title;
  final List dataList;
  Scrolling({this.title, required this.dataList});
  FavoritesDataBase db = FavoritesDataBase();
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<MovieProvider>(context);

    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(title!, style: kMoviesTheme.textTheme.headline5),
            ),
          ],
        ),
        SizedBox(
          width: double.infinity,
          height: 200,
          child: ListView.builder(
            physics: const BouncingScrollPhysics(),
            itemCount: dataList.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: () {
                    provider.getGenresForMovie(dataList[index].genreIds ?? []);
                    provider.getCreditsForaMovie(dataList[index].id);

                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => MovieDetailsScreen(
                                selectedIndex: index,
                                movie: dataList[index],
                                heroId: '${dataList[index].id}$title',
                                dataList: dataList)));
                  },
                  child: Hero(
                    tag: '${dataList[index].id}$title',
                    child: SizedBox(
                      width: 100,
                      child: Column(
                        children: <Widget>[
                          Expanded(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8.0),
                              child: Image(
                                image: NetworkImage(baseImageUrl +
                                    'w500/' +
                                    dataList[index].posterPath!),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              dataList[index].title!,
                              style: kMoviesTheme.textTheme.bodyText1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

class FavoritesMoviesCards extends StatelessWidget {
  List dataList;

  FavoritesMoviesCards({
    required this.dataList,
  });

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<MovieProvider>(context);
    return Container(
      color: kMoviesTheme.primaryColor.withOpacity(0.8),
      child: dataList.isEmpty
          ? Center(
              child: Text(
                'Your Favorites List has ${provider.favoritesList.length.toString()} movie ',
                textAlign: TextAlign.center,
                style: kMoviesTheme.textTheme.bodyMedium,
              ),
            )
          : ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: dataList.length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: () {
                      provider
                          .getGenresForMovie(dataList[index].genreIds ?? []);

                      provider.getCreditsForaMovie(dataList[index].id);

                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MovieDetailsScreen(
                                  selectedIndex: index,
                                  movie: dataList[index],
                                  //dataList[index],
                                  dataList: dataList,
                                  heroId: '${dataList[index].id}')));
                    },
                    child: Container(
                      height: 150,
                      child: Stack(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(top: 40.0),
                            child: Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  color: kMoviesTheme.primaryColor,
                                  borderRadius: BorderRadius.circular(8.0),
                                  border: Border.all(
                                      width: 1,
                                      color:
                                          kMoviesTheme.colorScheme.secondary)),
                              height: 100,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 118.0, top: 8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      dataList[index].title!,
                                      style: kMoviesTheme.textTheme.bodyText2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        children: <Widget>[
                                          Text(
                                            dataList[index].voteAverage!,
                                            style: kMoviesTheme
                                                .textTheme.bodyText1,
                                          ),
                                          const Icon(
                                            Icons.star,
                                            color: Colors.green,
                                          ),
                                          IconButton(
                                              onPressed: () {
                                                provider
                                                    .removeMovieFromFavoriteList(
                                                        dataList[index]);
                                              },
                                              icon: const Icon(
                                                Icons.delete,
                                                color: Colors.red,
                                              )),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            top: 0,
                            left: 8,
                            child: Hero(
                              tag: '${dataList[index].id}',
                              child: SizedBox(
                                width: 100,
                                height: 125,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8.0),
                                  child: FadeInImage(
                                    image: NetworkImage(baseImageUrl +
                                        'w500/' +
                                        dataList[index].posterPath!),
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
                  ),
                );
              },
            ),
    );
    ;
  }
}

class GenreMoviesCards extends StatelessWidget {
  List dataList;
  GenreMoviesCards({
    required this.dataList,
  });

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<MovieProvider>(context);
    return Container(
      color: kMoviesTheme.primaryColor.withOpacity(0.8),
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: dataList.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: GestureDetector(
              onTap: () {
                provider.getGenresForMovie(dataList[index].genreIds ?? []);

                provider.getCreditsForaMovie(dataList[index].id);

                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => MovieDetailsScreen(
                            selectedIndex: index,
                            movie: dataList[index],
                            dataList: dataList,
                            heroId: '${dataList[index].id}')));
              },
              child: Container(
                height: 150,
                child: Stack(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 40.0),
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: kMoviesTheme.primaryColor,
                            borderRadius: BorderRadius.circular(8.0),
                            border: Border.all(
                                width: 1,
                                color: kMoviesTheme.colorScheme.secondary)),
                        height: 100,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 118.0, top: 8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                dataList[index].title!,
                                style: kMoviesTheme.textTheme.bodyText2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: <Widget>[
                                    Text(
                                      dataList[index].voteAverage!,
                                      style: kMoviesTheme.textTheme.bodyText1,
                                    ),
                                    const Icon(
                                      Icons.star,
                                      color: Colors.green,
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 0,
                      left: 8,
                      child: Hero(
                        tag: '${dataList[index].id}',
                        child: SizedBox(
                          width: 100,
                          height: 125,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8.0),
                            child: FadeInImage(
                              image: NetworkImage(baseImageUrl +
                                  'w500/' +
                                  dataList[index].posterPath!),
                              fit: BoxFit.cover,
                              placeholder:
                                  const AssetImage('assets/images/loading.gif'),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class ScrollingArtists extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<MovieProvider>(context);
    // final state = Provider.of<ThemeState>(context);

    void modalBottomSheetMenu(Cast cast) {
      showModalBottomSheet(
          context: context,
          builder: (builder) {
            return Container(
              // height: height / 2,
              color: Colors.transparent,
              child: Stack(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 50),
                    child: Container(
                        padding: const EdgeInsets.only(top: 54),
                        decoration: BoxDecoration(
                            color: kMoviesTheme.primaryColor,
                            borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(16.0),
                                topRight: Radius.circular(16.0))),
                        child: Center(
                          child: ListView(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: <Widget>[
                                    Text(
                                      '${cast.name}',
                                      style: kMoviesTheme.textTheme.bodyText2,
                                    ),
                                    Text(
                                      'as',
                                      style: kMoviesTheme.textTheme.bodyText2,
                                    ),
                                    Text(
                                      '${cast.character}',
                                      style: kMoviesTheme.textTheme.bodyText2,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        )),
                  ),
                  Align(
                      alignment: Alignment.topCenter,
                      child: SizedBox(
                        width: 100,
                        height: 100,
                        child: Container(
                          decoration: BoxDecoration(
                              color: kMoviesTheme.primaryColor,
                              border: Border.all(
                                  color: kMoviesTheme.colorScheme.secondary,
                                  width: 3),
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: (cast.profilePath == null
                                      ? const AssetImage('assets/images/na.jpg')
                                      : NetworkImage(baseImageUrl +
                                          'w500/' +
                                          cast.profilePath!)) as ImageProvider<
                                      Object>),
                              shape: BoxShape.circle),
                        ),
                      ))
                ],
              ),
            );
          });
    }

    return Column(
      children: <Widget>[
        provider.credits == null
            ? Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: <Widget>[
                    Text('Cast', style: kMoviesTheme.textTheme.bodyText1),
                  ],
                ),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child:
                        Text('Cast', style: kMoviesTheme.textTheme.bodyText1),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CastAndCrew(
                                    themeData: kMoviesTheme,
                                    credits: provider.credits,
                                  )));
                    },
                    child: Text('See full cast & crew',
                        style: kMoviesTheme.textTheme.caption),
                  ),
                ],
              ),
        SizedBox(
          width: double.infinity,
          height: 120,
          child: provider.credits == null
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : ListView.builder(
                  physics: BouncingScrollPhysics(),
                  itemCount: provider.credits!.cast!.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        onTap: () {
                          modalBottomSheetMenu(provider.credits!.cast![index]);
                        },
                        child: SizedBox(
                          width: 80,
                          child: Column(
                            children: <Widget>[
                              Expanded(
                                child: SizedBox(
                                  width: 70,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(8.0),
                                    child: provider.credits!.cast![index]
                                                .profilePath ==
                                            null
                                        ? Image.asset(
                                            'assets/images/na.jpg',
                                            fit: BoxFit.cover,
                                          )
                                        : FadeInImage(
                                            image: NetworkImage(baseImageUrl +
                                                'w500/' +
                                                provider.credits!.cast![index]
                                                    .profilePath!),
                                            fit: BoxFit.cover,
                                            placeholder: const AssetImage(
                                                'assets/images/loading.gif'),
                                          ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  provider.credits!.cast![index].name!,
                                  style: kMoviesTheme.textTheme.caption,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
        ),
      ],
    );
    ;
  }
}

class GenreListWidgetForMovie extends StatelessWidget {
  final List<Genres> genresListToDisplay;
  final Movie? movie;
  // List<Movie> dataList;
  List dataList;
  Function? onTap;

  GenreListWidgetForMovie(
      {required this.genresListToDisplay,
      this.movie,
      required this.dataList,
      this.onTap});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<MovieProvider>(context);
    // final state = Provider.of<ThemeState>(context);

    return SizedBox(
        width: double.infinity,
        height: 50,
        child: Center(
          child: genresListToDisplay.isEmpty
              ? CircularProgressIndicator()
              : ListView.builder(
                  shrinkWrap: true,
                  physics: BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemCount: genresListToDisplay.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4.0),
                      child: InkWell(
                        onTap: () {
                          provider.getMoviesForParticularGenre(
                              genresListToDisplay[index].id);

                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => GenreMovies(
                                        genre: genresListToDisplay[index],
                                        genres: provider.genresList,
                                      )));
                        },
                        child: Chip(
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                                width: 1,
                                style: BorderStyle.solid,
                                color: kMoviesTheme.colorScheme.secondary),
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          label: Text(
                            genresListToDisplay[index].name!,
                            style: kMoviesTheme.textTheme.bodyText1,
                          ),
                          backgroundColor: Colors.transparent,
                        ),
                      ),
                    );
                  },
                ),
        ));
    ;
  }
}

class ScrollingGenerView extends StatelessWidget {
  final List<Genres> genresListToDisplay;
  final Movie? movie;
  // List<Movie> dataList;
  List dataList;
  Function? onTap;

  ScrollingGenerView(
      {required this.genresListToDisplay,
      this.movie,
      required this.dataList,
      this.onTap});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<MovieProvider>(context);

    return SizedBox(
        width: double.infinity,
        height: 50,
        child: Center(
          child: genresListToDisplay.isEmpty
              ? CircularProgressIndicator()
              : ListView.builder(
                  shrinkWrap: true,
                  physics: BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemCount: genresListToDisplay.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4.0),
                      child: GenreChip(
                          provider: provider,
                          genresListToDisplay: genresListToDisplay,
                          theme: kMoviesTheme,
                          genreId: genresListToDisplay[index].id!,
                          genreName: genresListToDisplay[index].name!),
                    );
                  },
                ),
        ));
    ;
  }
}

class GenreChip extends StatelessWidget {
  GenreChip({
    Key? key,
    required this.provider,
    required this.genresListToDisplay,
    required this.theme,
    required this.genreId,
    required this.genreName,
  }) : super(key: key);

  final MovieProvider provider;
  final List<Genres> genresListToDisplay;
  final ThemeData theme;
  final int genreId;
  final String genreName;
  FavoritesDataBase db = FavoritesDataBase();
  @override
  Widget build(BuildContext context) {
    final buttonsProvider = Provider.of<ButtonsProvider>(context);
    return InkWell(
      onTap: () {
        provider.updateScrollingGenreTitle(genreName);
        buttonsProvider.isPressedCheck(genreId);
        provider.getMoviesForParticularGenre(genreId);
      },
      child: Chip(
        shape: RoundedRectangleBorder(
          side: BorderSide(
              width: 1,
              style: BorderStyle.solid,
              color: theme.colorScheme.secondary),
          borderRadius: BorderRadius.circular(20.0),
        ),
        label: Text(
          genreName,
          style: theme.textTheme.bodyText1,
        ),
        backgroundColor: buttonsProvider.isPressedId == genreId
            ? theme.colorScheme.secondary
            : Colors.transparent,
      ),
    );
  }
}
