import 'package:flixpedia/screens/details_screen.dart';
import 'package:flixpedia/widgets/constants.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flixpedia/models/movie.dart';

class MoviesSlider extends StatelessWidget {
  const MoviesSlider({
    super.key, required this.snapshot,
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

  // Helper function to add a movie to the watchlist
  
 
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      width: double.infinity,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemCount: snapshot.data!.length,
        itemBuilder: (context, index) {
          final movie = snapshot.data![index]; // Extract the current movie
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Stack(
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
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      '${Constants.imagePath}${movie.posterPath}',
                      height: 200,
                      width: 150,
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
            ),
          );
        },
      ),
    );
  }
}
