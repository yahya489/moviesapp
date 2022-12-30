import 'package:flutter/material.dart';
import 'package:movies/providers/movie_provider.dart';
import 'package:movies/screens/widgets.dart';
import 'package:movies/constants/theme_constraints.dart';

class HomeScreenBody extends StatelessWidget {
  const HomeScreenBody({
    Key? key,
    required this.provider,
  }) : super(key: key);

  final MovieProvider provider;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: kMoviesTheme.primaryColor,
      child: ListView(
        physics: const BouncingScrollPhysics(),
        children: <Widget>[
          NowPlayingMovies(
            dataList: provider.nowPlayingList,
          ),
          Scrolling(title: 'Upcoming', dataList: provider.upcomingMovies),
          Scrolling(dataList: provider.trendingMovies, title: 'Trending'),
          ScrollingGenerView(
              genresListToDisplay: provider.genresList,
              dataList: provider.moviesForParticularGenreList),
          Scrolling(
            dataList: provider.moviesForParticularGenreList.isEmpty
                ? provider.discoverMovies
                : provider.moviesForParticularGenreList,
            title: provider.genreTitle,
          )
        ],
      ),
    );
  }
}
