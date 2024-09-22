import 'package:flutter/material.dart';
import 'package:movie_app/models/movie_model.dart';
import 'package:movie_app/services/api_services.dart';
import 'package:movie_app/pages/home/widgets/movies_horizontal_list.dart';

class PopularMoviesPage extends StatefulWidget {
  const PopularMoviesPage({super.key});

  @override
  State<PopularMoviesPage> createState() => _PopularMoviesPageState();
}

class _PopularMoviesPageState extends State<PopularMoviesPage> {
  ApiServices apiServices = ApiServices();
  late Future<Result> popularMovies;

  @override
  void initState() {
    super.initState();
    popularMovies = apiServices.getPopularMovies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Filmes Populares'),
      ),
      body: FutureBuilder<Result>(
        future: popularMovies,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return const Center(child: Text("Erro ao carregar filmes populares."));
          }

          if (snapshot.hasData) {
            return MoviesHorizontalList(result: snapshot.data!);
          }

          return const Center(child: Text("Nenhum filme encontrado."));
        },
      ),
    );
  }
}
