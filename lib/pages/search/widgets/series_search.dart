import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:movie_app/common/utils.dart';
import 'package:movie_app/models/series_model.dart'; // O modelo de séries
import 'package:movie_app/pages/movie_detail/series_detail_page.dart'; // A página de detalhes da série

class SeriesSearch extends StatelessWidget {
  const SeriesSearch({
    super.key,
    required this.series,
  });

  final Series series; // O modelo de série

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => SeriesDetailPage(
                  seriesId: series.id, // Usar o id da série
                )));
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 100,
              height: 140,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
              ),
              child: FadeInImage(
                image: NetworkImage('$imageUrl${series.posterPath}'), // URL da imagem
                fit: BoxFit.cover,
                placeholder: const AssetImage("images/netflix.png"),
              ),
            ),
            const SizedBox(
              width: 10.0,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    series.name, // Usar o nome da série
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  // Removido o trecho que usa firstAirDate
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      const Icon(
                        Icons.star,
                        color: Colors.yellow,
                        size: 15,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        '${series.voteAverage.toStringAsFixed(1)}/10', // Média de votos
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
