import 'package:flixpedia/screens/login_screen.dart';
import 'package:flixpedia/screens/register_screen.dart';
import 'package:flutter/material.dart';


class LoginOrRegisterScreen extends StatefulWidget {
  const LoginOrRegisterScreen({super.key});

  @override
  State<LoginOrRegisterScreen> createState() => _LoginOrRegisterScreenState();
}

class _LoginOrRegisterScreenState extends State<LoginOrRegisterScreen> {

  //initially show login page
  bool showloginPage = true;
  //toggle between login and register page
  void togglePages(){
    setState(() {
      showloginPage = !showloginPage;
    });
  }
  @override
  Widget build(BuildContext context) {
    if(showloginPage){
      return LoginPage(
        onTap: togglePages,
        );
    }else{
      return RegisterPage(
        onTap: togglePages,
      );
    }
  }
}