import 'dart:convert';

class SeriesDetailModel {
  final int id;
  final String name;
  final String posterPath;
  final double voteAverage;
  final String overview;
  final List<Genre> genres;

  SeriesDetailModel({
    required this.id,
    required this.name,
    required this.posterPath,
    required this.voteAverage,
    required this.overview,
    required this.genres,
  });

  factory SeriesDetailModel.fromJson(Map<String, dynamic> json) {
    return SeriesDetailModel(
      id: json['id'],
      name: json['name'],
      posterPath: json['poster_path'],
      voteAverage: json['vote_average'].toDouble(),
      overview: json['overview'],
      genres: List<Genre>.from(json['genres'].map((x) => Genre.fromJson(x))),
    );
  }
}

class Genre {
  final int id;
  final String name;

  Genre({
    required this.id,
    required this.name,
  });

  factory Genre.fromJson(Map<String, dynamic> json) {
    return Genre(
      id: json['id'],
      name: json['name'],
    );
  }
}
