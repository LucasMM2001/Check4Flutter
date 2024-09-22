import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/common/utils.dart';
import 'package:movie_app/models/series_datail_model.dart';
import 'package:movie_app/models/series_model.dart'; // Ajuste conforme seu modelo
import 'package:movie_app/services/api_services.dart';

class SeriesDetailPage extends StatefulWidget {
  final int seriesId;

  const SeriesDetailPage({super.key, required this.seriesId});

  @override
  State<SeriesDetailPage> createState() => _SeriesDetailPageState();
}

class _SeriesDetailPageState extends State<SeriesDetailPage> {
  final ApiServices apiServices = ApiServices();
  late Future<SeriesDetailModel> seriesDetail;

  @override
  void initState() {
    super.initState();
    seriesDetail = apiServices.getSeriesDetail(widget.seriesId); // Chame o método para obter detalhes da série
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Detalhes da Série"),
      ),
      body: SingleChildScrollView(
        child: FutureBuilder<SeriesDetailModel>(
          future: seriesDetail,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasError) {
              return const Center(child: Text("Erro ao carregar detalhes da série."));
            }

            if (snapshot.hasData) {
              final series = snapshot.data!;
              String genresText = series.genres.map((genre) => genre.name).join(', ');

              return Column(
                children: [
                  // Imagem da série
                  CachedNetworkImage(
                    imageUrl: "$imageUrl${series.posterPath}",
                    width: size.width,
                    height: size.height * 0.4,
                    fit: BoxFit.cover,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Título da série e Avaliação
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              series.name,
                              style: const TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Row(
                              children: [
                                const Icon(
                                  Icons.star,
                                  color: Colors.yellow,
                                  size: 24,
                                ),
                                const SizedBox(width: 5),
                                Text(
                                  series.voteAverage.toString(),
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(width: 5),
                                const Text(
                                  "/ 10",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),

                        // Removido o ano de lançamento
                        const SizedBox(height: 20),

                        // Gêneros
                        Text(
                          "Gêneros: $genresText",
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 20),

                        // Sinopse (overview)
                        const Text(
                          "Sinopse",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          series.overview,
                          style: const TextStyle(fontSize: 16),
                          textAlign: TextAlign.justify,
                        ),
                      ],
                    ),
                  ),
                ],
              );
            }

            return const Center(child: Text("Série não encontrada."));
          },
        ),
      ),
    );
  }
}
