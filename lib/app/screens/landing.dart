import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_time_tracker/app/screens/auth/auth.dart';
import 'package:flutter_time_tracker/app/screens/home/home.dart';

class Landing extends StatefulWidget {
  Landing({Key? key}) : super(key: key);

  @override
  State<Landing> createState() => _LandingState();
}

class _LandingState extends State<Landing> {
  bool userState = false;

  void checkUser() {
    FirebaseAuth.instance
        .authStateChanges()
        .listen((User? user) {
      if (user == null) {
        setState(() {
          userState = false;
        });
      } else {
        userState = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    checkUser();
    return userState ? const HomeScreen() : const AuthScreen();
  }
}
