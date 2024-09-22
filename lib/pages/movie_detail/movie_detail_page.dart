import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/common/utils.dart';
import 'package:movie_app/models/movie_detail_model.dart';
import 'package:movie_app/services/api_services.dart';

class MovieDetailPage extends StatefulWidget {
  final int movieId;

  const MovieDetailPage({super.key, required this.movieId});

  @override
  State<MovieDetailPage> createState() => _MovieDetailPageState();
}

class _MovieDetailPageState extends State<MovieDetailPage> {
  ApiServices apiServices = ApiServices();

  late Future<MovieDetailModel> movieDetail;

  @override
  void initState() {
    super.initState();
    movieDetail = apiServices.getMovieDetail(widget.movieId);
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Detalhes do Filme"),
      ),
      body: SingleChildScrollView(
        child: FutureBuilder<MovieDetailModel>(
          future: movieDetail,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasError) {
              return const Center(child: Text("Erro ao carregar detalhes do filme."));
            }

            if (snapshot.hasData) {
              final movie = snapshot.data!;

              String genresText = movie.genres.map((genre) => genre.name).join(', ');

              return Column(
                children: [
                  // Imagem do filme
                  CachedNetworkImage(
                    imageUrl: "$imageUrl${movie.posterPath}",
                    width: size.width,
                    height: size.height * 0.4,
                    fit: BoxFit.cover,
                  ),

                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Título do filme e Avaliação
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              movie.title,
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
                                  movie.voteAverage.toString(),
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

                        // Ano de lançamento
                        Text(
                          "Ano: ${movie.releaseDate.year}",
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 16,
                          ),
                        ),

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
                          movie.overview,
                          style: const TextStyle(fontSize: 16),
                          textAlign: TextAlign.justify,
                        ),
                      ],
                    ),
                  ),
                ],
              );
            }

            return const Center(child: Text("Filme não encontrado."));
          },
        ),
      ),
    );
  }
}
