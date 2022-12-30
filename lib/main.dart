import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:movies/database/local_database.dart';
import 'package:movies/modal_class/movie.dart';
import 'package:movies/providers/buttons_provider.dart';
import 'package:movies/providers/movie_provider.dart';
import 'package:provider/provider.dart';
import 'package:movies/screens/favoritesScreen.dart';
import 'package:hive/hive.dart';
import 'package:movies/constants/theme_constraints.dart';
import 'package:movies/screens/shimmer_loading.dart';
import 'package:movies/screens/home_screen.dart';

void main() async {
  //Registering the type adapter which required for Hive to handle custom classes
  Hive.registerAdapter(MovieAdapter());
  await Hive.initFlutter();

  // opening Hive box
  await Hive.openBox('mybox');

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => MovieProvider(),
        ),
        ChangeNotifierProvider(create: (context) => ButtonsProvider())
      ],
      child: MaterialApp(
        title: 'Movies',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            primarySwatch: Colors.blue, canvasColor: Colors.transparent),
        home: MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  FavoritesDataBase db = FavoritesDataBase();
  bool isloading = true;

  void getGenresData() async {
    final provider = Provider.of<MovieProvider>(context, listen: false);
    await provider.getAllGenres();
  }

  void getDiscoverMoviesData() async {
    final provider = Provider.of<MovieProvider>(context, listen: false);
    await provider.getDiscoverMovies();
  }

  void getNowPlayingData() async {
    final provider = Provider.of<MovieProvider>(context, listen: false);
    await provider.getNowPlayingMovies();
  }

  void getUpcomingMoviesData() async {
    final provider = Provider.of<MovieProvider>(context, listen: false);
    await provider.getUpcomingMovies();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final provider = Provider.of<MovieProvider>(context, listen: false);
      setState(() {
        db.loadData();
        provider.setFavorites(db.favoritesLocalDb, db.favoritesMoviesIdsDb);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<MovieProvider>(context);

    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'Movies',
            style: kMoviesTheme.textTheme.headline5,
          ),
          backgroundColor: kMoviesTheme.primaryColor,
          actions: <Widget>[
            IconButton(
              color: kMoviesTheme.colorScheme.secondary,
              onPressed: () {
                print('favorite list is ${provider.favoritesList.length}');
                print('IDs list is ${provider.favoritesIds.length}');
                print('localdb list is ${db.favoritesLocalDb.length}');
                print('localid list is ${db.favoritesMoviesIdsDb.length}');
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => FavoritesScreen()));
              },
              icon: Icon(Icons.favorite),
            )
          ],
        ),
        body: provider.nowPlayingList.isEmpty ||
                provider.upcomingMovies.isEmpty ||
                provider.trendingMovies.isEmpty ||
                provider.genresList.isEmpty
            ? const HomeShimmer()
            : HomeScreenBody(provider: provider));
  }
}
