import 'package:flutter/material.dart';
import 'package:movie_app/models/movie_model.dart';
import 'package:movie_app/models/series_model.dart'; // Importar o modelo de séries
import 'package:movie_app/pages/home/widgets/movies_horizontal_list.dart';
import 'package:movie_app/pages/home/widgets/series_horizontal_list.dart'; // Importar a lista horizontal de séries
import 'package:movie_app/services/api_services.dart';
import 'package:movie_app/pages/search/search_page.dart'; // Importar a página de busca

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ApiServices apiServices = ApiServices();

  // Variáveis para filmes
  late Future<Result> popularMovies;
  late Future<Result> nowPlayingMovies;
  late Future<Result> upcomingMovies;
  late Future<Result> topRatedMovies; // Variável para filmes top-rated

  // Variáveis para séries
  late Future<SeriesResult> popularSeries;
  late Future<SeriesResult> topRatedSeries;

  @override
  void initState() {
    super.initState();
    // Filmes
    popularMovies = apiServices.getPopularMovies();
    nowPlayingMovies = apiServices.getNowPlayingMovies();
    upcomingMovies = apiServices.getUpcomingMovies();
    topRatedMovies = apiServices.getTopRatedMovies(); // Chamada para filmes top-rated

    // Séries
    popularSeries = apiServices.getPopularSeries(); // Chamada correta para séries populares
    topRatedSeries = apiServices.getTopRatedSeries(); // Chamada correta para séries top-rated
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Movie & Series App'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Seção de Filmes "Now Playing"
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                child: Text(
                  'Popular Filmes',
                  style: TextStyle(
                    color: Colors.white54,
                    fontWeight: FontWeight.w300,
                    fontSize: 20,
                  ),
                ),
              ),
              FutureBuilder<Result>(
                future: nowPlayingMovies,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return MoviesHorizontalList(result: snapshot.data!);
                  }
                  return const SizedBox();
                },
              ),

              const SizedBox(height: 20),

              // Seção de Séries Populares
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                child: Text(
                  'Popular Series',
                  style: TextStyle(
                    color: Colors.white54,
                    fontWeight: FontWeight.w300,
                    fontSize: 20,
                  ),
                ),
              ),
              FutureBuilder<SeriesResult>(
                future: popularSeries, // Usar a chamada para séries populares
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return SeriesHorizontalList(result: snapshot.data!); // Usar o widget para exibir séries
                  }
                  return const SizedBox();
                },
              ),

              // Seção de Filmes "Top Rated"
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                child: Text(
                  'Top Rated Movies', // Título para filmes top-rated
                  style: TextStyle(
                    color: Colors.white54,
                    fontWeight: FontWeight.w300,
                    fontSize: 20,
                  ),
                ),
              ),
              FutureBuilder<Result>(
                future: topRatedMovies, // Usar a chamada para filmes top-rated
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return MoviesHorizontalList(result: snapshot.data!); // Usar o widget para exibir filmes
                  }
                  return const SizedBox();
                },
              ),

              const SizedBox(height: 20),

              // Seção de Séries "Top Rated"
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                child: Text(
                  'Top Rated Series',
                  style: TextStyle(
                    color: Colors.white54,
                    fontWeight: FontWeight.w300,
                    fontSize: 20,
                  ),
                ),
              ),
              FutureBuilder<SeriesResult>(
                future: topRatedSeries, // Usar a chamada para séries top-rated
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return SeriesHorizontalList(result: snapshot.data!); // Usar o widget para exibir séries
                  }
                  return const SizedBox();
                },
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
