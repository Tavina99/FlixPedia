
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flixpedia/api/api.dart';
import 'package:flixpedia/models/movie.dart';
import 'package:flixpedia/models/tv.dart';
import 'package:flixpedia/models/MoviesSlider.dart';
import 'package:flixpedia/models/TrendingSlider.dart';
import 'package:flixpedia/screens/search_screen.dart';
import 'package:flixpedia/screens/watchlist_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flixpedia/colors.dart';
import 'package:flixpedia/models/Tv_Slider';
import 'package:flixpedia/screens/profileSettings_screen.dart';
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<Tv>> onTv;
  late Future<List<Movie>> onCinema;
  late Future<List<Movie>> highestGrossingMovies;
  late Future<List<Movie>> bestMovies;
  late Future<List<Movie>> trendingMovies;
  late Future<List<Movie>> topratedMovies;
  late Future<List<Movie>> upcomingMovies;
  late Future<List<Movie>> childrenFriendlyMovies;
  @override
  void initState() {
    super.initState();
    onTv = Api().getOnTv(); 
    onCinema = Api().getOnCinema(); 
    highestGrossingMovies = Api().getHighestGrossingMovies();
    bestMovies = Api().getBestMovies();
    childrenFriendlyMovies = Api().getChildrenFriendlyMovies();
    trendingMovies = Api().getTrendingMovies(); 
    topratedMovies = Api().getTopRatedMovies();
    upcomingMovies= Api().getUpcomingMovies();
  }
  final user = FirebaseAuth.instance.currentUser!;
  void signUserOut(){
    FirebaseAuth.instance.signOut();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Colours.scaffoldBgColor,
      appBar: AppBar(
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu, color: Colors.white),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Image.asset(
          'assets/flixpedia.png',
          fit: BoxFit.cover,
          height: 40,
          filterQuality: FilterQuality.high,
          ),
        centerTitle: true,

        actions: [
          IconButton(
            onPressed: (){
              Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const SearchPage()),
            );
            },
             icon: const Icon(Icons.search,size:30,color: Colors.white,),
             ),
          const  SizedBox(width: 20),
          IconButton(
            onPressed: signUserOut,
             icon: const Icon(Icons.logout,color: Colors.white,),
             )
        ],
        

      ),
      drawer: Theme(
        data: Theme.of(context).copyWith(
          // Copy the current theme and override the canvas color
          canvasColor: Colors.black, // Set the dark color here for the drawer background
        ),
        child: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              const DrawerHeader(
                decoration: BoxDecoration(
                  color: Colours.scaffoldBgColor,
                ),
                child: Text('Menu', style: TextStyle(color: Colors.white, fontSize: 24)),
              ),
              _createDrawerItem(icon: Icons.person, text: 'Profile Settings', onTap: () {
                // Navigate to Profile Settings Page
                Navigator.push(
                 context,
                 MaterialPageRoute(builder: (context) =>  ProfileSettingsScreen()),
            );
              }),
              _createDrawerItem(icon: Icons.list, text: 'Watchlist', onTap: () {
                // Navigate to Watchlist Page
                Navigator.push(
                 context,
                 MaterialPageRoute(builder: (context) => const WatchlistScreen()),
            );
        
              }),
              _createDrawerItem(icon: Icons.history, text: 'Watched List', onTap: () {
                // Navigate to Watched List Page
              }),
              _createDrawerItem(icon: Icons.search, text: 'Search History', onTap: () {
                // Navigate to Search History Page
              }),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Logged in as : ${user.email!}",style: GoogleFonts.dmSans(fontSize: 15,color: const Color(0xFFE50914),)),
              const SizedBox(height: 24,),
              Text('Now On Cinema', style: GoogleFonts.aBeeZee(fontSize: 25,color: Colors.white,),
              ),
              const SizedBox(height: 32),
              SizedBox(
                child: FutureBuilder(
                  future: onCinema,
                  builder: (context, snapshot) {
                    if(snapshot.hasError){
                      return Center(
                        child: Text(snapshot.error.toString()),
                        );
                    }else if(snapshot.hasData){                    
                      return TrendingSlider(snapshot: snapshot);  
                    }else{
                      return const Center(child:CircularProgressIndicator( ));
                    }

                  },

                ),
              ),
              const SizedBox(height: 32),
              Text('Tonight On TV', style: GoogleFonts.aBeeZee(fontSize: 25,color: Colors.white,),
              ),
              const SizedBox(height: 32),
              SizedBox(
                child: FutureBuilder(
                  future: onTv,
                  builder: (context, snapshot) {
                    if(snapshot.hasError){
                      return Center(
                        child: Text(snapshot.error.toString()),
                        );
                    }else if(snapshot.hasData){                    
                      return TvSlider(snapshot: snapshot);  
                    }else{
                      return const Center(child:CircularProgressIndicator( ));
                    }

                  },

                ),
              ),
              const SizedBox(height: 32),
              Text('Highest-Grossing Movies', style: GoogleFonts.aBeeZee(fontSize: 25,color: Colors.white,),
              ),
              const SizedBox(height: 32),
              SizedBox(
                child: FutureBuilder(
                  future: highestGrossingMovies,
                  builder: (context, snapshot) {
                    if(snapshot.hasError){
                      return Center(
                        child: Text(snapshot.error.toString()),
                        );
                    }else if(snapshot.hasData){                    
                      return MoviesSlider(snapshot: snapshot);  
                    }else{
                      return const Center(child:CircularProgressIndicator( ));
                    }

                  },

                ),
              ),
              const SizedBox(height: 32),

              Text('Best Movies This year', style: GoogleFonts.aBeeZee(fontSize: 25,color: Colors.white,),
              ),
              const SizedBox(height: 32),
              SizedBox(
                child: FutureBuilder(
                  future: bestMovies,
                  builder: (context, snapshot) {
                    if(snapshot.hasError){
                      return Center(
                        child: Text(snapshot.error.toString()),
                        );
                    }else if(snapshot.hasData){                    
                      return MoviesSlider(snapshot: snapshot);  
                    }else{
                      return const Center(child:CircularProgressIndicator( ));
                    }

                  },

                ),
              ),
              const SizedBox(height: 32),

              Text('Children-Friendly Movies', style: GoogleFonts.aBeeZee(fontSize: 25,color: Colors.white,),
              ),
              const SizedBox(height: 32),
              SizedBox(
                child: FutureBuilder(
                  future: childrenFriendlyMovies,
                  builder: (context, snapshot) {
                    if(snapshot.hasError){
                      return Center(
                        child: Text(snapshot.error.toString()),
                        );
                    }else if(snapshot.hasData){                    
                      return MoviesSlider(snapshot: snapshot);  
                    }else{
                      return const Center(child:CircularProgressIndicator( ));
                    }

                  },

                ),
              ),
              const SizedBox(height: 32),
              Text('Trending Movies', style: GoogleFonts.aBeeZee(fontSize: 25,color: Colors.white,),
              ),
              const SizedBox(height: 32),
              SizedBox(
                child: FutureBuilder(
                  future: trendingMovies,
                  builder: (context, snapshot) {
                    if(snapshot.hasError){
                      return Center(
                        child: Text(snapshot.error.toString()),
                        );
                    }else if(snapshot.hasData){                    
                      return MoviesSlider(snapshot: snapshot);  
                    }else{
                      return const Center(child:CircularProgressIndicator( ));
                    }

                  },

                ),
              ),
              const SizedBox(height: 32),
              Text('Top Rated Movies',
              style: GoogleFonts.aBeeZee(
                fontSize: 25,
                color: Colors.white,
                ),
              ),
              const SizedBox(height: 32),
              SizedBox(
                child: FutureBuilder(
                  future: topratedMovies,
                  builder: (context, snapshot) {
                    if(snapshot.hasError){
                      return Center(
                        child: Text(snapshot.error.toString()),
                        );
                    }else if(snapshot.hasData){                    
                      return MoviesSlider(snapshot: snapshot);  
                    }else{
                      return const Center(child:CircularProgressIndicator( ));
                    }

                  },

                ),
              ),
              const SizedBox(height: 32),
              Text('Upcoming Movies',
              style: GoogleFonts.aBeeZee(
                fontSize: 25,
                color: Colors.white,
                ),
              ),
              const SizedBox(height: 32),
              SizedBox(
                child: FutureBuilder(
                  future: upcomingMovies,
                  builder: (context, snapshot) {
                    if(snapshot.hasError){
                      return Center(
                        child: Text(snapshot.error.toString()),
                        );
                    }else if(snapshot.hasData){                    
                      return MoviesSlider(snapshot: snapshot);  
                    }else{
                      return const Center(child:CircularProgressIndicator( ));
                    }

                  },

                ),
              ),


            ],
          ),
        )

      )
    );
  }
  Widget _createDrawerItem({required IconData icon, required String text, VoidCallback? onTap}) {
    return ListTile(
      title: Row(
        children: <Widget>[
          Icon(icon, color: Colors.black),
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text(text, style: const TextStyle(color: Colors.black)),
          ),
        ],
      ),
      onTap: onTap,
    );
  }

}

