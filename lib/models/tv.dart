class Tv {
  String name;
  String backDropPath;
  String originalName;
  String overview;
  String posterPath;
  String onAirdate;
  double voteAverage;
  

  Tv({
    required this.name,
    required this.backDropPath,
    required this.originalName,
    required this.overview,
    required this.posterPath,
    required this.onAirdate,
    required this.voteAverage,
    
  });
  factory Tv.fromJson(Map<String, dynamic> json) {
    return Tv(
        name: json["name"]  ?? "Some name",
        backDropPath:  json["backdrop_path"]??"some backdrop_path",
        originalName:  json["original_name"] ?? "some original name",
        overview:  json["overview"] ?? " some overview",
        posterPath: json["poster_path"] ?? "some poster path",
        onAirdate:json["first_air_date"] ?? "Some air date",
        voteAverage: json["vote_average"].toDouble()?? "Some vote average",
        
        );
  }
  
}
