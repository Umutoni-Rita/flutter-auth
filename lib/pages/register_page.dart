// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterauth/components/my_button.dart';
import 'package:flutterauth/components/my_textfield.dart';
import 'package:flutterauth/components/square_tile.dart';

class RegisterPage extends StatefulWidget {
  final Function()? onTap;
  const RegisterPage({super.key, required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  //text editing controller
  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  String error = "";

  void signUserIn() async {
    //show loading circle
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      //pop the loading circle
      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      if (e.code == 'invalid-email') {
        //show erro to user
        wrongEmailMessage();
      } else if (e.code == 'wrong-password') {
        //show error
        wrongPasswordMessage();
      }
    }
  }

  void wrongPasswordMessage() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Incorrect Password"),
        );
      },
    );
  }

  void wrongEmailMessage() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Incorrect Email"),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 50),

                //logo
                Icon(
                  Icons.lock,
                  size: 100,
                ),
                const SizedBox(height: 50),

                //welcome back
                Text(
                  "Welcome we know it's your first time",
                  style: TextStyle(color: Colors.grey[700], fontSize: 16),
                ),

                const SizedBox(height: 25),

                //username text field
                MyTextField(
                  controller: emailController,
                  hintText: 'Email',
                  obscureText: false,
                ),

                const SizedBox(height: 20),

                //passwordtext field
                MyTextField(
                  controller: passwordController,
                  hintText: 'Password',
                  obscureText: true,
                ),

                //forgot password
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 10, 30, 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        "Forgot Password?",
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 25),
                if (error != "")
                  Text(
                    error,
                    style: TextStyle(color: Colors.red),
                  ),
                const SizedBox(height: 25),

                //signin
                MyButton(
                  onTap: signUserIn,
                ),

                const SizedBox(height: 25),

                //continue with
                //a divider is kinda like a line
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Row(
                    children: [
                      Expanded(
                        child: Divider(
                          thickness: 0.8,
                          color: Colors.grey[400],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                          "Or continue with",
                          style: TextStyle(color: Colors.grey[700]),
                        ),
                      ),
                      Expanded(
                        child: Divider(
                          thickness: 0.8,
                          color: Colors.grey[400],
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                //google + apple
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    //google button
                    SquareTile(
                      imagePath: 'lib/images/google.png',
                    ),
                    const SizedBox(
                      width: 4.0,
                    ),
                    //apple button
                    SquareTile(
                      imagePath: 'lib/images/apple.png',
                    ),
                  ],
                ),

                const SizedBox(height: 30),

                //not a member? sign up
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Not a member?",
                      style: TextStyle(color: Colors.grey[700]),
                    ),
                    const SizedBox(
                      width: 4,
                    ),
                    GestureDetector(
                      onTap: widget.onTap,
                      child: Text(
                        "Register Now",
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
