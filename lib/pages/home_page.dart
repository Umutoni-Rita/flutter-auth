// ignore_for_file: prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final user = FirebaseAuth.instance.currentUser!;

  void signUserOut() {
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(onPressed: signUserOut, icon: Icon(Icons.logout_rounded))
        ],
        backgroundColor: Color(0xFF64C369),
      ),
      body: Center(
        child: Text(
          "Logged in as: ${user.email!}",
          style: TextStyle(
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
