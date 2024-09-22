import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:movie_app/common/utils.dart';
import 'package:movie_app/models/movie_detail_model.dart';
import 'package:movie_app/models/movie_model.dart';
import 'package:movie_app/models/series_datail_model.dart';
import 'package:movie_app/models/series_model.dart'; // Importar o modelo de séries

const baseUrl = 'https://api.themoviedb.org/3/';
const key = '?api_key=$apiKey';

class ApiServices {
  // Busca filmes top rated
  Future<Result> getTopRatedMovies() async {
    var endPoint = 'movie/top_rated';
    final url = '$baseUrl$endPoint$key';

    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      return Result.fromJson(jsonDecode(response.body));
    }
    throw Exception('Failed to load top-rated movies');
  }

  // Busca filmes que estão passando agora
  Future<Result> getNowPlayingMovies() async {
    var endPoint = 'movie/now_playing';
    final url = '$baseUrl$endPoint$key';

    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      return Result.fromJson(jsonDecode(response.body));
    }
    throw Exception('Failed to load now playing movies');
  }

  // Busca filmes futuros
  Future<Result> getUpcomingMovies() async {
    var endPoint = 'movie/upcoming';
    final url = '$baseUrl$endPoint$key';

    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      return Result.fromJson(jsonDecode(response.body));
    }
    throw Exception('Failed to load upcoming movies');
  }

  // Detalhes de um filme específico
  Future<MovieDetailModel> getMovieDetail(int movieId) async {
    final endPoint = 'movie/$movieId';
    final url = '$baseUrl$endPoint$key';

    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      return MovieDetailModel.fromJson(jsonDecode(response.body));
    }
    throw Exception('Failed to load movie details');
  }

  // Recomendação de filmes a partir de um filme
  Future<Result> getMovieRecommendations(int movieId) async {
    final endPoint = 'movie/$movieId/recommendations';
    final url = '$baseUrl$endPoint$key';

    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      return Result.fromJson(jsonDecode(response.body));
    }
    throw Exception('Failed to load movie recommendations');
  }

  // Busca por filmes
  Future<Result> getSearchedMovie(String searchText) async {
    final endPoint = 'search/movie?query=$searchText';
    final url = '$baseUrl$endPoint';
    final response = await http.get(Uri.parse(url), headers: {
      'Authorization': 'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI3NTAyYjhjMDMxYzc5NzkwZmU1YzBiNGY5NGZkNzcwZCIsInN1YiI6IjYzMmMxYjAyYmE0ODAyMDA4MTcyNjM5NSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.N1SoB26LWgsA33c-5X0DT5haVOD4CfWfRhwpDu9eGkc'
    });
    if (response.statusCode == 200) {
      return Result.fromJson(jsonDecode(response.body));
    }
    throw Exception('Failed to load search results');
  }

  // Busca filmes populares
  Future<Result> getPopularMovies() async {
    const endPoint = 'movie/popular';
    const url = '$baseUrl$endPoint$key';

    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      return Result.fromJson(jsonDecode(response.body));
    }
    throw Exception('Failed to load popular movies');
  }

  // Método para buscar séries populares
  Future<SeriesResult> getPopularSeries() async {
    const endPoint = 'tv/popular';
    const url = '$baseUrl$endPoint$key';

    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      return SeriesResult.fromJson(jsonDecode(response.body));
    }
    throw Exception('Failed to load popular series');
  }

  // Método para buscar séries mais bem avaliadas (Top Rated)
  Future<SeriesResult> getTopRatedSeries() async {
    const endPoint = 'tv/top_rated';
    final url = '$baseUrl$endPoint$key';

    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      return SeriesResult.fromJson(jsonDecode(response.body));
    }
    throw Exception('Failed to load top rated series');
  }

  // Implementação para buscar séries que estão passando hoje (Airing Today)
  Future<Result> getAiringTodaySeries() async {
    final endPoint = 'tv/airing_today';
    final url = '$baseUrl$endPoint$key';

    final response = await http.get(Uri.parse(url), headers: {
      'Authorization': 'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI3NTAyYjhjMDMxYzc5NzkwZmU1YzBiNGY5NGZkNzcwZCIsInN1YiI6IjYzMmMxYjAyYmE0ODAyMDA4MTcyNjM5NSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.N1SoB26LWgsA33c-5X0DT5haVOD4CfWfRhwpDu9eGkc'
    });
    if (response.statusCode == 200) {
      return Result.fromJson(jsonDecode(response.body));
    }
    throw Exception('Failed to load series airing today');
  }

  // Detalhes de uma série específica
  Future<SeriesDetailModel> getSeriesDetail(int seriesId) async {
    final endPoint = 'tv/$seriesId';
    final url = '$baseUrl$endPoint$key';

    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      return SeriesDetailModel.fromJson(jsonDecode(response.body));
    }
    throw Exception('Failed to load series details');
  }
}
