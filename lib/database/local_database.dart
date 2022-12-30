import 'package:hive_flutter/hive_flutter.dart';

class FavoritesDataBase {
  final _myBox = Hive.box('mybox');

  List favoritesLocalDb = [];
  List favoritesMoviesIdsDb = [];

  //load data

  void loadData() {
    favoritesLocalDb = _myBox.get("FAVORITESLIST");
    favoritesMoviesIdsDb = _myBox.get("ID");
  }

  //Update the database

  void updateDataBase() {
    _myBox.put("FAVORITESLIST", favoritesLocalDb);
    _myBox.put("ID", favoritesMoviesIdsDb);
  }

}
