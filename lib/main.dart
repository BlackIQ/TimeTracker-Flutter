import 'package:flutter/material.dart';
import 'package:flutter_time_tracker/app/screens/landing.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Time Tracker Flutter',
      home: Landing(),
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
    );
  }
}
