import 'package:flutter/material.dart';
import 'package:flutter_time_tracker/app/screens/auth/auth.dart';
import 'package:flutter_time_tracker/app/screens/home/home.dart';

class Landing extends StatelessWidget {
  bool user = false;

  Landing({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return user ? const HomeScreen() : const AuthScreen();
  }
}
