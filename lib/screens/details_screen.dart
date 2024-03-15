import 'package:flixpedia/colors.dart';
import 'package:flixpedia/models/movie.dart';
import 'package:flixpedia/widgets/back_button.dart';
import 'package:flixpedia/widgets/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flixpedia/models/MoviesSlider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// Ensure you import your models, colors, and widgets here

// Import your models, colors, and widgets here

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({
    super.key,
    required this.movie,
  });

  final Movie movie;
  Future<void> addToWatchlist(Movie movie) async {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    final CollectionReference watchlistCollection = firestore.collection('watchlist');
    await watchlistCollection.doc(movie.title.toString()).set({
      'title': movie.title,
      'backDropPath': movie.backDropPath,
      'releaseDate': movie.releaseDate,
      'rating': movie.voteAverage,
      'overview': movie.overview
    });
    print("Movie added to Firestore watchlist: ${movie.title}");
  }
  Future<void> addToWatchedlist(Movie movie) async {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    final CollectionReference watchedlistCollection = firestore.collection('watchedlist');
    await watchedlistCollection.doc(movie.title.toString()).set({
      'title': movie.title,
      'backDropPath': movie.backDropPath,
      'releaseDate': movie.releaseDate,
      'rating': movie.voteAverage,
      'overview': movie.overview
    });
    print("Movie added to Firestore watched list: ${movie.title}");
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colours.scaffoldBgColor,
      body: CustomScrollView(
        slivers: [
          SliverAppBar.large(
            leading: const BackBtn(),
            backgroundColor: Colours.scaffoldBgColor,
            expandedHeight: 350,
            pinned: true,
            floating: false,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(movie.title, style: GoogleFonts.openSans(color: Colors.white, fontWeight: FontWeight.bold)),
              background: Hero(
                tag: '${movie.title}-poster',
                child: Image.network(
                  '${Constants.imagePath}${movie.posterPath}',
                  filterQuality: FilterQuality.high,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Overview',
                    style: GoogleFonts.openSans(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    movie.overview,
                    style: GoogleFonts.roboto(
                      fontSize: 16,
                      color: Colors.white.withOpacity(0.9),
                    ),
                  ),
                  const SizedBox(height: 20),
                  DetailInfoRow(
                    title: 'Release Date: ',
                    value: movie.releaseDate,
                    icon: Icons.calendar_today_outlined,
                  ),
                  DetailInfoRow(
                    title: 'Rating: ',
                    value: '${movie.voteAverage.toStringAsFixed(1)}/10',
                    icon: Icons.star_border_outlined,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      FloatingActionButton(
                        heroTag: "addToWatchlist",
                        backgroundColor: Colors.red,
                        child: const Icon(Icons.bookmark_add, color: Colors.white),
                        onPressed: () => addToWatchlist(movie),
                      ),
                      FloatingActionButton(
                        heroTag: "addToWatchedList",
                        backgroundColor: Colors.green,
                        child: const Icon(Icons.check, color: Colors.white),
                        onPressed: () => addToWatchedlist(movie),
                      ),
                    ],
                  ),
                  // Add more details or widgets as needed
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class DetailInfoRow extends StatelessWidget {
  const DetailInfoRow({
    Key? key,
    required this.title,
    required this.value,
    required this.icon,
  }) : super(key: key);

  final String title;
  final String value;
  final IconData icon;
  
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        children: [
          Icon(icon, color: Colors.white.withOpacity(0.8)),
          const SizedBox(width: 8),
          Text(
            title,
            style: GoogleFonts.roboto(fontSize: 16, color: Colors.white.withOpacity(0.8), fontWeight: FontWeight.bold),
          ),
          Expanded(
            child: Text(
              value,
              style: GoogleFonts.roboto(fontSize: 16, color: Colors.white.withOpacity(0.8)),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}

// DetailInfoRow class remains the same as provided in the previous message
