import 'package:flutter/material.dart';
import 'package:movie_app/models/series_model.dart';
import 'package:movie_app/services/api_services.dart';
import 'package:movie_app/pages/home/widgets/series_horizontal_list.dart';

class SeriesPage extends StatefulWidget {
  const SeriesPage({super.key});

  @override
  State<SeriesPage> createState() => _SeriesPageState();
}

class _SeriesPageState extends State<SeriesPage> {
  ApiServices apiServices = ApiServices();
  
  // Chamar apenas as séries
  late Future<SeriesResult> popularSeries;
  late Future<SeriesResult> topRatedSeries;

  @override
  void initState() {
    super.initState();
    popularSeries = apiServices.getPopularSeries();
    topRatedSeries = apiServices.getTopRatedSeries(); // Chamada para séries top-rated
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Séries'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                child: Text(
                  'Séries Populares',
                  style: TextStyle(color: Colors.white54, fontWeight: FontWeight.w300, fontSize: 20),
                ),
              ),
              FutureBuilder<SeriesResult>(
                future: popularSeries,
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
                  return const SizedBox(); // Retornar um SizedBox vazio se não houver dados
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
                  return const SizedBox(); // Retornar um SizedBox vazio se não houver dados
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
