import 'package:firebase_auth/firebase_auth.dart';
import 'package:flixpedia/screens/home_screen.dart';
import 'package:flixpedia/screens/login_or_register_screen.dart';
import 'package:flixpedia/screens/login_screen.dart';
import 'package:flutter/material.dart';


class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder:(context, snapshot) {
          //user is logged in
          if(snapshot.hasData){
            return const HomeScreen();
          }
          // user is not logged in
          else{
            return const LoginOrRegisterScreen();
          }
        },
      )
    );
  }
}