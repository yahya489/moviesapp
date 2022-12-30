import 'package:flutter/material.dart';

import 'package:movies/modal_class/movie.dart';
import 'package:movies/screens/widgets.dart';

class FavoritesScreen extends StatelessWidget {
  final ThemeData themeData;

  List<Movie>? faveList = [Movie()];

  FavoritesScreen({required this.themeData});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: themeData.primaryColor,
        title: Text(
          'Favorites',
          style: themeData.textTheme.headline5,
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: themeData.colorScheme.secondary,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(),
    );
  }
}
