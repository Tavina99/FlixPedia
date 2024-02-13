
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flixpedia/api/api.dart';
import 'package:flixpedia/models/movie.dart';
import 'package:flixpedia/widgets/MoviesSlider.dart';
import 'package:flixpedia/widgets/TrendingSlider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flixpedia/colors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<Movie>> trendingMovies;
  late Future<List<Movie>> topratedMovies;
  late Future<List<Movie>> upcomingMovies;
  @override
  void initState() {
    super.initState();
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
            onPressed: signUserOut,
             icon: const Icon(Icons.logout,color: Colors.white,),
             )
        ],
        

      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Logged in as : ${user.email!}",style: GoogleFonts.dmSans(fontSize: 15,color: Color(0xFFE50914),)),
              const SizedBox(height: 24,),
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
                      return TrendingSlider(snapshot: snapshot);  
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
}

