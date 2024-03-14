class Movie {
  String title;
  String backDropPath;
  String overview;
  String posterPath;
  String releaseDate;
  double voteAverage;
  double id;
 

  Movie({
    required this.title,
    required this.backDropPath,
    required this.overview,
    required this.posterPath,
    required this.releaseDate,
    required this.voteAverage,
    required this.id,
    

  });
  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'posterPath': posterPath,
      'id': id,
      // Map other fields as necessary
    };
  }
  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
        title: json["title"] ?? "name",
        backDropPath:  json["backdrop_path"]??"some revenue",
        overview:  json["overview"]??"some revenue",
        posterPath: json["poster_path"]??"some revenue",
        releaseDate:json["release_date"]??"first_air_date",
        voteAverage: (json["vote_average"] is num ? json["vote_average"] : num.parse(json["vote_average"].toString())).toDouble(),
        id: json["id"].toDouble()??"some id"
        
        );
  }
 
}

