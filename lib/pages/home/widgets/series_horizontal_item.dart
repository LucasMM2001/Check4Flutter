import 'package:flutter/material.dart';
import 'package:movie_app/common/utils.dart';
import 'package:movie_app/models/series_model.dart'; // Importar o modelo de séries
import 'package:movie_app/pages/movie_detail/series_detail_page.dart'; // Página de detalhes da série

class SeriesHorizontalItem extends StatelessWidget {
  const SeriesHorizontalItem({
    super.key,
    required this.series,
  });

  final Series series; // Alterado para o modelo de séries

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Navegação para a página de detalhes da série
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SeriesDetailPage(seriesId: series.id), // Página de detalhes da série
          ),
        );
      },
      child: Stack(
        children: [
          Container(
            height: 200,
            width: 140,
            foregroundDecoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [
                  Colors.black.withOpacity(0.8),
                  Colors.transparent,
                ],
              ),
            ),
            margin: const EdgeInsets.symmetric(horizontal: 8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18),
              image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage('$imageUrl${series.posterPath}'), // Usando o poster da série
              ),
            ),
          ),
          Positioned(
            left: 15,
            right: 15,
            bottom: 0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  series.name, // Nome da série
                  maxLines: 1,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end, // Alinhamento ajustado
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          series.voteAverage.toInt().toString(), // Média de votos
                          maxLines: 1,
                          overflow: TextOverflow.clip,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                        const SizedBox(width: 5),
                        const Icon(
                          Icons.star,
                          color: Colors.yellow,
                          size: 15,
                        ),
                        const SizedBox(height: 5),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
