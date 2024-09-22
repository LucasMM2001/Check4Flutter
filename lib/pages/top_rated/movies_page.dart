import 'package:flutter/material.dart';
import 'package:movie_app/models/movie_model.dart';
import 'package:movie_app/services/api_services.dart';
import 'package:movie_app/pages/home/widgets/movies_horizontal_list.dart';

class MoviesPage extends StatefulWidget {
  const MoviesPage({super.key});

  @override
  State<MoviesPage> createState() => _MoviesPageState();
}

class _MoviesPageState extends State<MoviesPage> {
  ApiServices apiServices = ApiServices();
  
  late Future<Result> popularMovies;
  late Future<Result> topRatedMovies;

  @override
  void initState() {
    super.initState();
    popularMovies = apiServices.getPopularMovies();
    topRatedMovies = apiServices.getTopRatedMovies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Filmes'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                child: Text(
                  'Filmes Populares',
                  style: TextStyle(color: Colors.white54, fontWeight: FontWeight.w300, fontSize: 20),
                ),
              ),
              FutureBuilder<Result>(
                future: popularMovies,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasError) {
                    return Center(child: Text('Erro: ${snapshot.error}'));
                  }
                  if (snapshot.hasData) {
                    return MoviesHorizontalList(result: snapshot.data!);
                  }
                  return const SizedBox();
                },
              ),

              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                child: Text(
                  'Top Rated Movies',
                  style: TextStyle(color: Colors.white54, fontWeight: FontWeight.w300, fontSize: 20),
                ),
              ),
              FutureBuilder<Result>(
                future: topRatedMovies,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasError) {
                    return Center(child: Text('Erro: ${snapshot.error}'));
                  }
                  if (snapshot.hasData) {
                    return MoviesHorizontalList(result: snapshot.data!);
                  }
                  return const SizedBox();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
