import 'package:flutter/material.dart';
import 'package:movie_app/models/movie_model.dart';
import 'package:movie_app/models/series_model.dart';
import 'package:movie_app/services/api_services.dart';
import 'package:movie_app/pages/home/widgets/movies_horizontal_list.dart';
import 'package:movie_app/pages/home/widgets/series_horizontal_list.dart'; // Importar a lista horizontal de séries

class TopRatedPage extends StatefulWidget {
  const TopRatedPage({super.key});

  @override
  State<TopRatedPage> createState() => _TopRatedPageState();
}

class _TopRatedPageState extends State<TopRatedPage> {
  ApiServices apiServices = ApiServices();
  
  late Future<Result> topRatedMovies;
  late Future<SeriesResult> topRatedSeries;

  @override
  void initState() {
    super.initState();
    topRatedMovies = apiServices.getTopRatedMovies();
    topRatedSeries = apiServices.getTopRatedSeries();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Top Rated'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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

              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                child: Text(
                  'Top Rated Series',
                  style: TextStyle(color: Colors.white54, fontWeight: FontWeight.w300, fontSize: 20),
                ),
              ),
              FutureBuilder<SeriesResult>(
                future: topRatedSeries,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasError) {
                    return Center(child: Text('Erro: ${snapshot.error}'));
                  }
                  if (snapshot.hasData) {
                    return SeriesHorizontalList(result: snapshot.data!);
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
