import 'package:carousel_slider/carousel_slider.dart';
import 'package:flixpedia/screens/details_screen.dart';
import 'package:flixpedia/widgets/constants.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flixpedia/models/movie.dart';
class TrendingSlider extends StatelessWidget {
  const TrendingSlider({
    super.key,
    required this.snapshot,
  });
  final AsyncSnapshot snapshot;
Future<void> addToWatchlist(Movie movie) async {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final CollectionReference watchlistCollection = firestore.collection('watchlist');
  watchlistCollection.doc(movie.title.toString()).set({
    'title': movie.title,
    'backDropPath':movie.backDropPath,
    'releaseDate':movie.releaseDate,
    'rating':movie.voteAverage,
    'overview':movie.overview
  });
  print("Movie added to Firestore watchlist: ${movie.title}");
}

Future<void> addToWatchedlist(Movie movie) async {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final CollectionReference watchlistCollection = firestore.collection('watchedlist');
  watchlistCollection.doc(movie.title.toString()).set({
    'title': movie.title,
    'backDropPath':movie.backDropPath,
    'releaseDate':movie.releaseDate,
    'rating':movie.voteAverage,
    'overview':movie.overview
  });
  print("Movie added to Firestore watchedlist: ${movie.title}");
}
  

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: CarouselSlider.builder(
        itemCount: snapshot.data!.length,
        options: CarouselOptions(
          height: 340, // Adjusted height to accommodate the add button
          autoPlay: true,
          viewportFraction: 0.55,
          enlargeCenterPage: true,
          pageSnapping: true,
          autoPlayCurve: Curves.fastOutSlowIn,
          autoPlayAnimationDuration: const Duration(seconds: 1),
        ),
        itemBuilder: (context, index, pageViewIndex) {
          final movie = snapshot.data[index];
          return Stack(
            alignment: Alignment.bottomCenter,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DetailsScreen(movie: movie),
                    ),
                  );
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    '${Constants.imagePath}${movie.posterPath}',
                    height: 300,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    filterQuality: FilterQuality.high,
                  ),
                ),
              ),
              Positioned(
                bottom: 10,
                right: 10,
                child: FloatingActionButton(
                  heroTag: 'buttonTag$index',
                  mini: true,
                  backgroundColor: Colors.red, // Customization for visibility
                  child: const Icon(Icons.bookmark_add, color: Colors.white),
                  onPressed: () => addToWatchlist(movie),
                ),
              ),
              Positioned(
                  bottom: 60,
                  right: 10,
                  child: FloatingActionButton(
                    heroTag: 'watched$index',
                    mini: true,
                    backgroundColor: Colors.green, // Green color for the "Watched" icon
                    child: const Icon(Icons.check, color: Colors.white),
                    onPressed: () => addToWatchedlist(movie),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}
