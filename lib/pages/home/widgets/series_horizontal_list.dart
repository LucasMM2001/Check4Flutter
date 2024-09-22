import 'package:flutter/material.dart';
import 'package:movie_app/models/series_model.dart'; // Importar o modelo de séries
import 'package:movie_app/pages/home/widgets/series_horizontal_item.dart'; // Widget para item de série

class SeriesHorizontalList extends StatelessWidget {
  final SeriesResult result; // Alterado para SeriesResult
  const SeriesHorizontalList({super.key, required this.result});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 28, vertical: 10),
      height: 230,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: result.series.length, // Acessando a lista de séries
        itemBuilder: (context, index) {
          final series = result.series[index]; // Acessando o item da série
          return SeriesHorizontalItem(series: series); // Passando a série para o widget
        },
      ),
    );
  }
}
