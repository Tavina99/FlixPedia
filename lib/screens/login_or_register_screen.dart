
import 'package:flixpedia/screens/login_screen.dart';
import 'package:flixpedia/screens/register_screen.dart';
import 'package:flutter/material.dart';


class LoginOrRegisterScreen extends StatefulWidget {
  // Constructor with an optional key parameter for widget identification.
  const LoginOrRegisterScreen({super.key});

  @override
  
  State<LoginOrRegisterScreen> createState() => _LoginOrRegisterScreenState();
}

class _LoginOrRegisterScreenState extends State<LoginOrRegisterScreen> {
  // A boolean variable to track which page to show, login or register.
  bool showloginPage = true;

  // Method to toggle the boolean state, which switches between showing the login or register page.
  void togglePages(){
    setState(() {
      // Flips the boolean value to switch views.
      showloginPage = !showloginPage;
    });
  }
  @override
  Widget build(BuildContext context) {
    // The build method decides which page to display based on the boolean value.
    if(showloginPage){
      // If showloginPage is true, display the LoginPage and pass the togglePages method to it.
      return LoginPage(
        onTap: togglePages,
        );
    }else{
      // If showloginPage is false, display the RegisterPage and also pass the togglePages method to it.
      return RegisterPage(
        onTap: togglePages,
      );
    }
  }
}
