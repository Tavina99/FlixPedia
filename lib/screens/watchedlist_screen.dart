
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
 // Ensure this import matches your project structure
import 'package:flixpedia/widgets/constants.dart'; // Adjust according to your project

class WatchedlistScreen extends StatefulWidget {
  const WatchedlistScreen({super.key});

  @override
  WatchedlistScreenState createState() => WatchedlistScreenState();
}

class WatchedlistScreenState extends State<WatchedlistScreen> {
  Future<List<Map<String, dynamic>>> fetchWatchlist() async {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    final QuerySnapshot querySnapshot = await firestore.collection('watchedlist').get();

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
    await firestore.collection('watchedlist').doc(title).delete();
    setState(() {}); // Refresh the page to show the updated watchlist
  }

  @override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: const Text("Your Watched List", style: TextStyle(color: Colors.white)),
      backgroundColor: const Color(0xFFE50914), // Elegant AppBar color
    ),
    body: FutureBuilder<List<Map<String, dynamic>>>(
      future: fetchWatchlist(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('Your watched list is empty.'));
        }
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, // Number of columns
              childAspectRatio: 0.6, // Adjust the aspect ratio
              mainAxisSpacing: 10, // Space between items
              crossAxisSpacing: 10,
            ),
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              final movie = snapshot.data![index];
              return Card(
                elevation: 5, // Adds shadow
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15), // Rounded corners
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      CachedNetworkImage(
                        imageUrl: "${Constants.imagePath}${movie['backDropPath']}",
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: double.infinity,
                        placeholder: (context, url) => const CircularProgressIndicator(),
                        errorWidget: (context, url, error) => const Icon(Icons.error),
                      ),
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.5), // Semi-transparent overlay
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              child: Text(
                                movie['title'] ?? 'No Title',
                                style: const TextStyle(color: Colors.white, fontSize: 14),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete, color: Colors.red),
                              onPressed: () => removeFromWatchlist(movie['title']),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
    ),
    backgroundColor: const Color(0xFF23272E),
  );
}
}

