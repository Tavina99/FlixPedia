import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flixpedia/models/movie.dart';
import 'package:flixpedia/models/tv.dart';
import 'package:flixpedia/widgets/constants.dart';
import 'package:http/http.dart' as http;
class Api{
  static const _onTvUrl ='https://api.themoviedb.org/3/tv/airing_today?api_key=${Constants.apiKey}';
  static const _trendingUrl ='https://api.themoviedb.org/3/trending/movie/day?api_key=${Constants.apiKey}'; 
  static const _onCinemaUrl ='https://api.themoviedb.org/3/movie/now_playing?api_key=${Constants.apiKey}';
  static const _topRatedUrl ='https://api.themoviedb.org/3/movie/top_rated?api_key=${Constants.apiKey}'; 
  static const _upcomingUrl ='https://api.themoviedb.org/3/movie/upcoming?api_key=${Constants.apiKey}'; 
  static const _highestGrossingUrl ='https://api.themoviedb.org/3/discover/movie?api_key=${Constants.apiKey}&sort_by=revenue.desc';
  static const _bestUrl = 'https://api.themoviedb.org/3/discover/movie?api_key=${Constants.apiKey}&primary_release_year=2024&sort_by=popularity.desc';
  static const genreId = '10751'; // Genre ID for Family which is suitable for children
  static const _childrenFriendlyUrl = 'https://api.themoviedb.org/3/discover/movie?api_key=${Constants.apiKey}&with_genres=$genreId';
  static const _searchUrl = 'https://api.themoviedb.org/3/search/multi?api_key=${Constants.apiKey}&query=';


   
  

  Future<List<Movie>> getTrendingMovies() async{
    final response = await http.get(Uri.parse(_trendingUrl));
    if(response.statusCode == 200){
       final decodedData = json.decode(response.body)['results'] as List;
       return decodedData.map((movie) => Movie.fromJson(movie)).toList();
    }else{
      throw Exception('Something Happened');
    }
   }
   
   Future<List<Movie>> getChildrenFriendlyMovies() async{
    final response = await http.get(Uri.parse(_childrenFriendlyUrl));
    if(response.statusCode == 200){
       final decodedData = json.decode(response.body)['results'] as List;
       return decodedData.map((movie) => Movie.fromJson(movie)).toList();
    }else{
      throw Exception('Something Happened');
    }
   }
  
  Future<List<Movie>> getHighestGrossingMovies() async{
    final response = await http.get(Uri.parse(_highestGrossingUrl));
    if(response.statusCode == 200){
       final decodedData = json.decode(response.body)['results'] as List;
       return decodedData.map((movie) => Movie.fromJson(movie)).toList();
    }else{
      throw Exception('Something Happened');
    }
   }
   

   Future<List<Movie>> getBestMovies() async{
    final response = await http.get(Uri.parse(_bestUrl));
    if(response.statusCode == 200){
       final decodedData = json.decode(response.body)['results'] as List;
       return decodedData.map((movie) => Movie.fromJson(movie)).toList();
    }else{
      throw Exception('Something Happened');
    }
   }
  Future<List<Tv>> getOnTv() async{
    final DateTime now = DateTime.now();
    final formattedDate = "${now.year}-${now.month.toString().padLeft(2, '0')}-${now.day.toString().padLeft(2, '0')}";
    final response = await http.get(Uri.parse('$_onTvUrl&air_date=$formattedDate&region=US'));
    if(response.statusCode == 200){
       final decodedData = json.decode(response.body)['results'] as List;
       return decodedData.map((tv) => Tv.fromJson(tv)).toList();
    }else{
      throw Exception('Something Happened');
    }
   }
   

   Future<List<Movie>> getOnCinema() async{
    final response = await http.get(Uri.parse(_onCinemaUrl));
    if(response.statusCode == 200){
       final decodedData = json.decode(response.body)['results'] as List;
       return decodedData.map((movie) => Movie.fromJson(movie)).toList();
    }else{
      throw Exception('Something Happened');
    }
   }

   Future<List<Movie>> getTopRatedMovies() async{
    final response = await http.get(Uri.parse(_topRatedUrl));
    if(response.statusCode == 200){
       final decodedData = json.decode(response.body)['results'] as List;
       return decodedData.map((movie) => Movie.fromJson(movie)).toList();
    }else{
      throw Exception('Something Happened');
    }
   }


   Future<List<Movie>> getUpcomingMovies() async{
    final response = await http.get(Uri.parse(_upcomingUrl));
    if(response.statusCode == 200){
       final decodedData = json.decode(response.body)['results'] as List;
       return decodedData.map((movie) => Movie.fromJson(movie)).toList();
    }else{
      throw Exception('Something Happened');
    }
   }
   Future<List<Movie>> searchMovies(String query) async {
  var url = Uri.parse('$_searchUrl$query');
  var response = await http.get(url);
  if (response.statusCode == 200) {
    var data = json.decode(response.body);
    List<Movie> movies = List.from(data['results']).map<Movie>((item) => Movie.fromJson(item)).toList();
    return movies;
  } else {
    // Handle error or return an empty list
    throw Exception('Failed to load search results');
  }
}
   

     
}