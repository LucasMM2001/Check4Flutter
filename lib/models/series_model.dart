import 'dart:convert';

class Series {
  final int id;
  final String name;
  final String posterPath;
  final double voteAverage;

  Series({
    required this.id,
    required this.name,
    required this.posterPath,
    required this.voteAverage,
  });

  factory Series.fromJson(Map<String, dynamic> json) {
    return Series(
      id: json['id'],
      name: json['name'],
      posterPath: json['poster_path'] ?? '', // Handle null case
      voteAverage: (json['vote_average'] as num).toDouble(),
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

class SeriesResult { // Renomeando Result para SeriesResult
  final List<Series> series;

  SeriesResult({required this.series});

  factory SeriesResult.fromJson(Map<String, dynamic> json) {
    var seriesList = json['results'] as List;
    List<Series> series = seriesList.map((i) => Series.fromJson(i)).toList();
    return SeriesResult(series: series);
  }
}
