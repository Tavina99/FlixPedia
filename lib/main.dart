import 'package:firebase_core/firebase_core.dart';
import 'package:flixpedia/screens/auth_screen.dart';
import 'package:flixpedia/screens/search_screen.dart';
import 'package:flutter/foundation.dart';
import 'firebase_options.dart';
import 'colors.dart';
import 'screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'screens/login_screen.dart';
Future main() async{
  WidgetsFlutterBinding.ensureInitialized();
  if(kIsWeb){
    await Firebase.initializeApp(
    options: FirebaseOptions(apiKey: "AIzaSyBEt-Sql_Xq7fnuk3Sh_5vAZ-X6HeikzsU", 
    appId:"1:621746795231:web:3a937abe56c5b779612f6a" , messagingSenderId: "621746795231",
     projectId: "flix-pedia",databaseURL: "https://Flix Pedia.firebaseio.com")
  );
  }
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AuthPage(),
    );
  }
}  