class Movie {
  final int id;
  final String title;
  final double voteAverage;
  final String releaseDate;
  final String overview;
  final String posterPath;

  Movie(
    this.id,
    this.title,
    this.voteAverage,
    this.releaseDate,
    this.overview,
    this.posterPath,
  );

  factory Movie.fromJson(Map<String, dynamic> parsedJson) {
    final id = parsedJson['id'];
    final title = parsedJson['title'];
    final voteAverage = parsedJson['vote_average'] * 1.0;
    final releaseDate = parsedJson['release_date'];
    final overview = parsedJson['overview'];
    final posterPath = parsedJson['poster_path'];

    return Movie(
      id,
      title,
      voteAverage,
      releaseDate,
      overview,
      posterPath,
    );
  }
}
