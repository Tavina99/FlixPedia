
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flixpedia/widgets/signin_button.dart';
import 'package:flixpedia/widgets/text_field.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RegisterPage extends StatefulWidget {
  final Function()? onTap;
  const RegisterPage({super.key, required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  //text editing controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  //sign user up method
  void signUserUp() async{
    //show loading circle
    showDialog(
      context: context,
      builder:(context){
        return const Center(
          child: CircularProgressIndicator(),
        );
    },
    );
    if(passwordController.text != confirmPasswordController.text){
      Navigator.pop(context);
      showErrorMessage("Passwords don't match");
    }else{
    //try creating the user
    try{
      //check if password is confirmed
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );
      //pop the loading circle 
      if(context.mounted)Navigator.pop(context);
    } on FirebaseAuthException catch (e){
      if(context.mounted)Navigator.pop(context);
      //show error message
      showErrorMessage(e.code);
    }}
  
  }
  void showErrorMessage(String message){
    showDialog(
      context: context,
      builder: (context){
        return AlertDialog(
          backgroundColor: Color(0xFFE50914),
          title:Center(
            
            child: Text(
              message,
              style: GoogleFonts.workSans(
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                        color: Colors.white,
                        
                      ),
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
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 25),
                    Text(
                      'Let\'s create an account for you!',
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
                      obscuretext: false,
                    ),
                    const SizedBox(height: 10),
                    //password textfield
                    MyTextField(
                      controller: passwordController,
                      hintText: 'Password',
                      obscuretext: true,
                    ),
                    const SizedBox(height: 10),
                    //confirm password textfield
                    MyTextField(
                      controller: confirmPasswordController,
                      hintText: 'Confirm Password',
                      obscuretext: true,
                    ),
                  
                    const SizedBox(height: 25),
                    //sign in button
                    SigninButton(
                      onTap:signUserUp,
                      text: "Sign Up" 
                    ),
                    const SizedBox(height:50),
                    //Not a user, SignUp
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Already have an account?',
                          style: TextStyle(color:Colors.grey[700]),
                          ),
                        const SizedBox(width: 6),
                        GestureDetector(
                          onTap: widget.onTap,
                          child: const Text(
                            'Login Now',
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
