import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_time_tracker/app/screens/auth/auth.dart';
import 'package:flutter_time_tracker/app/screens/home/home.dart';

class Landing extends StatelessWidget {
  final user = FirebaseAuth.instance.currentUser;

  Landing({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return user == null ? const AuthScreen() : const HomeScreen();
  }
}
