import 'package:flutter/material.dart';
import 'package:flutter_time_tracker/app/firebase/firebase_options.dart';
import 'package:flutter_time_tracker/app/screens/landing.dart';

import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

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
