
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
 // Ensure this import matches your project structure
import 'package:flixpedia/widgets/constants.dart'; // Adjust according to your project

class WatchlistScreen extends StatefulWidget {
  const WatchlistScreen({super.key});

  @override
  WatchlistScreenState createState() => WatchlistScreenState();
}

class WatchlistScreenState extends State<WatchlistScreen> {
  Future<List<Map<String, dynamic>>> fetchWatchlist() async {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    final QuerySnapshot querySnapshot = await firestore.collection('watchlist').get();

    // Map each document to a Map<String, dynamic>
    List<Map<String, dynamic>> moviesList = querySnapshot.docs.map((doc) {
      Map<String, dynamic>? data = doc.data() as Map<String, dynamic>?;
      if (data != null) {
        return {
          'title': data['title'],
          'backDropPath': data['backDropPath'],
          'releaseDate': data['releaseDate'],
          'rating': data['rating'],
          'overview': data['overview'],
        };
      } else {
        // Handle the case where data is null
        return <String, dynamic>{};
      }
    }).where((movie) => movie.isNotEmpty).toList(); // Remove any empty maps that were added

    return moviesList;
  }

  Future<void> removeFromWatchlist(String title) async {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    await firestore.collection('watchlist').doc(title).delete();
    setState(() {}); // Refresh the page to show the updated watchlist
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Your Watchlist"),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: fetchWatchlist(), // This now returns a List<Map<String, dynamic>>
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Your watchlist is empty.'));
          }
          return GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, // Number of columns in the grid
              childAspectRatio: 3 / 4, // Aspect ratio for each item
            ),
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              final movieMap = snapshot.data![index];
              // Ensure you have a valid image path and title, or provide a fallback
              String imagePath = movieMap['backDropPath'] ?? ''; // Provide a fallback image path if null
              String title = movieMap['title'] ?? 'No Title'; // Provide a fallback title if null
              return GridTile(
                footer: GridTileBar(
                  backgroundColor: Colors.black45,
                  title: Text(
                    title, // Use the title from the map
                    style: TextStyle(fontSize: 12),
                    overflow: TextOverflow.ellipsis,
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete_outline, color: Colors.white),
                    onPressed: () => removeFromWatchlist(title), // Use the title from the map
                  ),
                ),
                child: Image.network(
                  '${Constants.imagePath}$imagePath', // Use the imagePath from the map
                  fit: BoxFit.cover,
                ),
              );
            },
          );
        },
      ),
    );
  }
}
