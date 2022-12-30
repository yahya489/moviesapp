import 'package:flutter/material.dart';
import 'package:movies/providers/movie_provider.dart';
import 'package:provider/provider.dart';
import 'package:movies/screens/widgets.dart';
import 'package:movies/constants/theme_constraints.dart';

class FavoritesScreen extends StatelessWidget {
  FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<MovieProvider>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: kMoviesTheme.primaryColor,
        title: Text(
          'My Favorites',
          style: kMoviesTheme.textTheme.headline5,
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: kMoviesTheme.colorScheme.secondary,
          ),
          onPressed: () {
            print('favorite list is ${provider.favoritesList.length}');
            print('IDs list is ${provider.favoritesIds.length}');
            Navigator.pop(context);
          },
        ),
      ),
      body:
          //Container()
          FavoritesMoviesCards(
              isFavoriteList: true, dataList: provider.favoritesList),
    );
  }
}
