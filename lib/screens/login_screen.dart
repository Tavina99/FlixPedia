
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flixpedia/widgets/signin_button.dart';
import 'package:flixpedia/widgets/text_field.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  final Function()? onTap;
  const LoginPage({super.key, required this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //text editing controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  
  void signUserIn() async{
    //show loading circle
    showDialog(
      context: context,
      builder:(context){
        return const Center(
          child: CircularProgressIndicator(),
        );
    },
    );
    try{
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      if(context.mounted)Navigator.pop(context);
    } on FirebaseAuthException catch (e){
      if(context.mounted)Navigator.pop(context);
      //show error message
      showErrorMessage(e.code);
    }
  
  }
  void showErrorMessage(String message){
    showDialog(
      context: context,
      builder: (context){
        return AlertDialog(
          backgroundColor: Colors.deepPurple,
          title:Center(
            child: Text(
              message,
              style:const TextStyle(color:Colors.white),
              ),
              ),
        );
    },
    );
  }
  
  
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
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
      ),
      body: SafeArea(
          child: Center(
            // SingleChildScrollView to prevent overflow when the keyboard appears.
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 50),
                    Text(
                      'Welcome back you\'ve been missed!',
                      style: TextStyle(
                        color: Colors.grey[700],
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 25),
                    //username textfield
                    MyTextField(
                      controller: emailController,
                      hintText: 'Email',
                      obscuretext: false, // Makes the text visible in the email field.
                    ),
                    const SizedBox(height: 25),
                    //password textfield
                    MyTextField(
                      controller: passwordController,
                      hintText: 'Password',
                      obscuretext: true,
                    ),
                
                    const SizedBox(height: 10),
                    //forgot password
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text('Forgot Password?', style: TextStyle(color: Colors.grey[600])),
                        ],
                      ),
                    ),
                    const SizedBox(height: 25),
                    // Sign-in button that triggers the signUserIn method
                    SigninButton(
                      onTap:signUserIn, 
                      text: "Sign In",
                    ),
                    const SizedBox(height:50),
                    //Not a user, SignUp
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Not a User?',
                          style: TextStyle(color:Colors.grey[700]),
                          ),
                        const SizedBox(width: 6),
                        // Link to navigate to the registration page if the user doesn't have an account.
                        GestureDetector(
                          onTap: widget.onTap,
                          child: const Text(
                            'Sign Up Now',
                            style: TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.bold
                            )
                          ),
                        ),
                
                      ],
                    ),
                  ],
                ),
              ))),

      //   ],
    );
  }
}
