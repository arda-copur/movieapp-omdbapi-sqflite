class Movie {
  final String imdbId;
  final String poster;
  final String title;
  final String year;

  Movie({required this.imdbId, required this.title, required this.poster, required this.year});

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(imdbId: json["imdbID"], poster: json["Poster"], title: json["Title"], year: json["Year"]);
  }
  Map<String, dynamic> toMap() {
    return {
      'imdb': imdbId,
      'title': title,
      'poster': poster,
      'year': year,
    };
  }

  factory Movie.fromMap(Map<String, dynamic> map) {
    return Movie(
      imdbId: map['imdb'],
      title: map['title'],
      poster: map['poster'],
      year: map['year'],
    );
  }
}
