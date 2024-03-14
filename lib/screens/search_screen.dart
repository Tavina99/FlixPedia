import 'package:flixpedia/api/api.dart';
import 'package:flixpedia/screens/details_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
// Import your models and widgets here

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  SearchPageState createState() => SearchPageState();
}

class SearchPageState extends State<SearchPage> {
  final TextEditingController searchController = TextEditingController();
  List<dynamic> searchResults = [];
  bool isLoading = false;

  


  void _performSearch() async {
  setState(() {
    isLoading = true; // Show loading indicator
  });

  try {
    final results = await Api().searchMovies(searchController.text);
    setState(() {
      searchResults = results;
      isLoading = false; // Hide loading indicator
    });
  } catch (e) {
    setState(() {
      isLoading = false; // Hide loading indicator
      // Handle the error, e.g., show an error message
    });
    print(e);
  }
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // Example color, replace with Colours.scaffoldBgColor
      appBar: AppBar(
        leading: const BackButton(), // Replace with your BackBtn widget
        backgroundColor: Colors.black, // Example color, replace with Colours.scaffoldBgColor
        title: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'Search Movies or Tv Shows',
            style: GoogleFonts.aBeeZee(fontSize: 20, color: Colors.white),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextField(
              controller: searchController,
              cursorColor: Colors.white,
              style: const TextStyle(color: Colors.white), // Set text color to white
              decoration: InputDecoration(
                hintText: "Search...",
                hintStyle: TextStyle(color: Colors.white.withOpacity(0.5)),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white.withOpacity(0.7)),
                ),
                focusedBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFE50914),
              ),
              onPressed: isLoading ? null : () => _performSearch(),
              child: isLoading
                  ? const CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.white))
                  : Text('Search', style: GoogleFonts.aBeeZee(fontSize: 16, color: Colors.white)),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : searchResults.isEmpty
                      ? const Center(child: Text("No results found", style: TextStyle(color: Colors.white)))
                      : GridView.builder(
  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
    crossAxisCount: 2, // Number of columns
    crossAxisSpacing: 4.0, // Horizontal space between cards
    mainAxisSpacing: 4.0, // Vertical space between cards
  ),
  itemCount: searchResults.length,
  itemBuilder: (context, index) {
    final movie = searchResults[index];
    return Card(
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DetailsScreen(movie: movie),
            ),
          );
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Image.network(
                'https://image.tmdb.org/t/p/w500${movie.posterPath}',
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                movie.title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 8.0),
              child: Text(
                'Rating: ${movie.voteAverage}',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black.withOpacity(0.6),
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  },
),

            ),
          ],
        ),
      ),
    );
  }
}

  
  
     
 






